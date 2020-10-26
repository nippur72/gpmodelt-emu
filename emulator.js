"use strict";

// 64K RAM
const memory = new Uint8Array(65536).fill(0x00); 

function initMem() {
   function rom_load(rom, address) {
      for(let i=0; i<rom.length; i++) {
         memory[address+i] = rom[i];
      }
   }


   rom_load(rom_E000,        0xE000);
   rom_load(rom_E400,        0xE400);

   if(FLOPPY_8_INCHES) rom_load(rom_E800_FDC8,   0xE800);
   else                rom_load(rom_E800_FDC525, 0xE800);

   rom_load(rom_EC00_ACI,    0xEC00);

   /*
   rom_load(rom_MON24_2,   0xE000);
   rom_load(rom_SYS2K_482, 0xE400);
   rom_load(rom_RIG02_U,   0xE800);
   */

   rom_load([ 0xC3, 0x00, 0xE0 ], 0x0000); // JP E000
}

let speaker_A = 0;
let cassette_bit_out1 = 0;
let cassette_bit_out2 = 0;
let cassette_bit_in = 0;

let tape_monitor = true;

let cpu = new Z80({ mem_read, mem_write, io_read, io_write });

/******************/

const lineRate = 10000000 / 640;             // 640 dot pixels per line (512 active area)
const frameRate = lineRate / 312.5;          // 50 Hz PAL standard
const frameDuration = 1000/frameRate;        // duration of 1 frame in msec
const cpuSpeed = 10000000 / 4;               // 10 MHz divided by 4
const cyclesPerLine = (cpuSpeed / lineRate);

let stopped = false; // allows to stop/resume the emulation

let frames = 0;
let nextFrameTime = 0;
let averageFrameTime = 0;
let minFrameTime = Number.MAX_VALUE;

let cycle = 0;
let cycles = 0;

let throttle = false;

let options = {
   load: undefined,
   restore: true,
   notapemonitor: false,
   scanlines: true,
   saturation: 1.0,
   bt: undefined,
   bb: undefined,
   bh: undefined
};

function cpuCycle() {
   if(debugBefore !== undefined) debugBefore();
   let elapsed = cpu.run_instruction();
   if(debugAfter !== undefined) debugAfter(elapsed);
   cycle += elapsed;
   cycles += elapsed;
   writeAudioSamples(elapsed);
   cloadAudioSamples(elapsed); 
   if(csaving) csaveAudioSamples(elapsed);       
   return elapsed;
}

// scanline version
function renderLines(nlines, hidden) {
   for(let t=0; t<nlines; t++) {
      // draw video
      if(!hidden) drawFrame_y();

      // run cpu
      while(true) {         
         if(debugBefore !== undefined) debugBefore();
         let elapsed = cpu.run_instruction();
         if(debugAfter !== undefined) debugAfter(elapsed);
         cycle += elapsed;
         cycles += elapsed;
         writeAudioSamples(elapsed);
         cloadAudioSamples(elapsed); 
         if(csaving) csaveAudioSamples(elapsed);       
         
         if(cycle>=cyclesPerLine) {
            cycle-=cyclesPerLine;
            break;            
         }
      } 
   }
}

let haltD = false;

function renderAllLines() {
   renderLines(HIDDEN_SCANLINES_TOP, true);               
   renderLines(SCREEN_H, false);                    
   renderLines(HIDDEN_SCANLINES_BOTTOM, true);               

   // update HALT status
   let halt = cpu.getState().halted;
   if(haltD != halt) {
      const element = document.getElementById("halt");
      element.style.display = halt ? "block" : "none";
   }
   haltD = halt;
}

let nextFrame;
let end_of_frame_hook = undefined;

function oneFrame() {   
   const startTime = new Date().getTime();      

   if(nextFrame === undefined) nextFrame = startTime;

   nextFrame = nextFrame + (1000/frameRate); // ~50Hz  

   renderAllLines();
   frames++;

   if(end_of_frame_hook !== undefined) end_of_frame_hook();

   const now = new Date().getTime();
   const elapsed = now - startTime;
   averageFrameTime = averageFrameTime * 0.992 + elapsed * 0.008;
   if(elapsed < minFrameTime) minFrameTime = elapsed;

   let time_out = nextFrame - now;
   if(time_out < 0 || throttle) {
      time_out = 0;
      nextFrame = undefined;      
   }
   if(!stopped) setTimeout(()=>oneFrame(), time_out);   
}

// ********************************* CPU TO AUDIO BUFFER *********************************************

const audioBufferSize = 16384; // enough to hold more than one frame time
const audioBuffer = new Float32Array(audioBufferSize);

let audioPtr = 0;                // points to the write position in the audio buffer (modulus)
let audioPtr_unclipped = 0;      // audio buffer writing absolute counter 
let downSampleCounter = 0;       // counter used to downsample from CPU speed to 48 Khz

function writeAudioSamples(n) {
   downSampleCounter += (n * sampleRate);
   if(downSampleCounter >= cpuSpeed) {
      let s = (speaker_A ? -0.5 : 0.0);
      const st = (cassette_bit_out1 && cassette_bit_out2 ? 0.75 : cassette_bit_out2 ? -0.75 : 0 );
      if(tape_monitor) s += st + (cassette_bit_in ? 0.5 : 0.0);
      downSampleCounter -= cpuSpeed;
      audioBuffer[audioPtr++] = s;
      audioPtr = audioPtr % audioBufferSize;
      audioPtr_unclipped++;
   }      
}

// ********************************* AUDIO BUFFER TO BROWSER AUDIO ************************************

let audioContext = new (window.AudioContext || window.webkitAudioContext)();
const bufferSize = 4096;
const sampleRate = audioContext.sampleRate;
var speakerSound = audioContext.createScriptProcessor(bufferSize, 1, 1);

let audioPlayPtr = 0;
let audioPlayPtr_unclipped = 0;

speakerSound.onaudioprocess = function(e) {
   const output = e.outputBuffer.getChannelData(0);

   // playback gone too far, wait   
   if(audioPlayPtr_unclipped + bufferSize > audioPtr_unclipped ) {
      for(let i=0; i<bufferSize; i++) output[i];
      return;
   }
  
   // playback what is in the audio buffer
   for(let i=0; i<bufferSize; i++) {
      const audio = audioBuffer[audioPlayPtr++];
      audioPlayPtr = audioPlayPtr % audioBufferSize;
      audioPlayPtr_unclipped++;
      output[i] = audio;
    }    
    
    // write pointer should be always ahead of reading pointer
    // if(kk++%50==0) console.log(`write: ${audioPtr_unclipped} read: ${audioPlayPtr_unclipped} diff: ${audioPtr_unclipped-audioPlayPtr_unclipped}`);
}

function goAudio() {
   audioPlayPtr_unclipped = 0;
   audioPlayPtr = 0;

   audioPtr = 0;
   audioPtr_unclipped = 0;

   speakerSound.connect(audioContext.destination);
}

function stopAudio() {
   speakerSound.disconnect(audioContext.destination);
}

function audioContextResume() {   
   if(audioContext.state === 'suspended') {
      audioContext.resume().then(() => {
         console.log('sound playback resumed successfully');
      });
   }
}

goAudio();


/*********************************************************************************** */

let tapeSampleRate = 0;
let tapeBuffer = new Float32Array(0);
let tapeLen = 0;
let tapePtr = 0;
let tapeHighPtr = 0;

function cloadAudioSamples(n) {
   if(tapePtr >= tapeLen) {
      cassette_bit_in = 1;
      return;
   }

   tapeHighPtr += (n*tapeSampleRate);
   if(tapeHighPtr >= cpuSpeed) {
      tapeHighPtr-=cpuSpeed;
      cassette_bit_in = tapeBuffer[tapePtr] > 0 ? 1 : 0;
      tapePtr++;      
   }
}

// ********************************* CPU TO CSAVE BUFFER *********************************************

const csaveBufferSize = 44100 * 5 * 60; // five minutes max

let csaveBuffer;                 // holds the tape audio for generating the WAV file
let csavePtr;                    // points to the write position in the csaveo buffer 
let csaveDownSampleCounter;      // counter used to downsample from CPU speed to 48 Khz

let csaving = false;

function csaveAudioSamples(n) {
   csaveDownSampleCounter += (n * 44100);
   if(csaveDownSampleCounter >= cpuSpeed) {
      const s = (cassette_bit_out1 && cassette_bit_out2 ? 0.75 : cassette_bit_out2 ? -0.75 : 0 );
      csaveDownSampleCounter -= cpuSpeed;
      csaveBuffer[csavePtr++] = s;
   }      
}

function csave() {
   csavePtr = 0;
   csaveDownSampleCounter = 0;
   csaveBuffer = new Float32Array(csaveBufferSize);
   csaving = true;
   console.log("saving audio (max 5 minutes); use cstop() to stop recording");
}

function cstop() {
   csaving = false;

   // trim silence before and after
   let start = csaveBuffer.indexOf(0.75)-100;
   let end = csaveBuffer.lastIndexOf(0.75)+100;

   start = Math.max(start, 0);
   end   = Math.min(end, csaveBuffer.length);

   const audio = csaveBuffer.slice(start, end);
   const length = Math.round(audio.length / 44100);

   const wavData = {
      sampleRate: 44100,
      channelData: [ audio ]
   };
     
   const buffer = encodeSync(wavData, { bitDepth: 16, float: false });      
   
   let blob = new Blob([buffer], {type: "application/octet-stream"});   
   const fileName = "csaved.wav";
   saveAs(blob, fileName);
   console.log(`downloaded "${fileName}" (${length} seconds of audio)`);
}

/*********************************************************************************** */

// prints welcome message on the console
welcome();

power();

parseQueryStringCommands();

// starts drawing frames
oneFrame();

// autoload program and run it
if(autoload !== undefined) {
   // gives 1 sec delay, so that load happens after ram is initialized by the eprom
   setTimeout(()=>loadBytes(autoload), 1000);
}

cpm();

/*
let ff = 0;
// logs when PC = BA00h (CPM entry)
debugBefore = (function() {
   let lastpc = 0;
   return function() {
      if(lastpc === 0xBA00) {
         // there was a call to RST 30
         console.log(`************ CP/M entry point reached`);
      }

      if(lastpc === 0xE818) {
         ff = 100;
         console.log(`************ qui ${cpu_status()}`);
         dumpStack();
      }

      if(ff>0) {
         console.log(`${cpu_status()}`);
         ff--;
      }

      lastpc = cpu.getState().pc;
   };
})();
*/