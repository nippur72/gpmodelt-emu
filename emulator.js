"use strict";

// TODO audio with libemu

// 64K RAM
const memory = new Uint8Array(65536).fill(0x00); 

let ROM_CONFIG = "T20";

function initMem() {
   function rom_load(rom, address) {
      for(let i=0; i<rom.length; i++) {
         memory[address+i] = rom[i];
      }
   }

   if(ROM_CONFIG == "T08") {
      rom_load(rom_E000,        0xE000);
      rom_load(rom_E400,        0xE400);
      rom_load(rom_E800_FDC525, 0xE800);   // 5" FDC
      rom_load(rom_EC00_ACI,    0xEC00);

      SCREEN_COLUMNS = 64;
      SCREEN_ROWS    = 16;
      SCREEN_COLUMNS_ARR = 64;

      FLOPPY_8_INCHES = false;
   }

   if(ROM_CONFIG == "T10") {
      rom_load(rom_E000,        0xE000);
      rom_load(rom_E400,        0xE400);
      rom_load(rom_E800_FDC8,   0xE800);   // 8" FDC
      rom_load(rom_EC00_ACI,    0xEC00);

      SCREEN_COLUMNS = 64;
      SCREEN_ROWS    = 16;
      SCREEN_COLUMNS_ARR = 64;

      FLOPPY_8_INCHES = true;
   }

   /*
   if(ROM_CONFIG == "rig") {
      rom_load(rom_MON24_2,   0xE000);
      rom_load(rom_SYS2K_482, 0xE400);
      rom_load(rom_RIG02_U,   0xE800);
      SCREEN_COLUMNS = 80;
      SCREEN_ROWS    = 24;
      SCREEN_COLUMNS_ARR = 128;
   }

   if(ROM_CONFIG == "scheda2") {
      rom_load(rom_U1MON1512, 0xE000);
      rom_load(rom_U3FDC,     0xE800);
      SCREEN_COLUMNS = 80;
      SCREEN_ROWS    = 24;
      SCREEN_COLUMNS_ARR = 128;
   }
   */

   if(ROM_CONFIG == "T20") {
      rom_load(rom_T20V24, 0xE000);
      SCREEN_COLUMNS = 80;
      SCREEN_ROWS    = 24;
      SCREEN_COLUMNS_ARR = 128;
   }

   // ROM di test di Gabriele Rossi
   // rom_load(rom_GPMON007, 0xE000);

   rom_load([ 0xC3, 0x00, 0xE0 ], 0x0000); // JP E000

   calculateGeometry();

   recalcFloppy();
}

let speaker_A = 0;
let cassette_bit_out1 = 0;
let cassette_bit_out2 = 0;
let cassette_bit_in = 0;

let tape_monitor = true;

let cpu = new Z80({ mem_read, mem_write, io_read, io_write });

/******************/

let system_clock;
let cpu_divisor;
let dotpixels;
let numscanlines;
let lineRate;
let frameRate;
let cpuSpeed;
let cyclesPerLine;
let hiddenlines;

function systemConfig() {

   let T08 = ROM_CONFIG == "T08";
   let T20 = ROM_CONFIG == "T20";

   system_clock = T20 ? 12000000 : 10000000;   // 10 Mhz 64x16, 24Mhz 80x24
   cpu_divisor  = T20 ? 5 : 4;                 // cpu clock divisor from system clock
   dotpixels    = T20 ? 768 : 640;             // number of dot pixels per line (512, 640 active area)
   numscanlines = 312.5;                       // fixed PAL number of lines
   hiddenlines  = T20 ? 0 : 312-(16*13);       // 64x16 has hidden lines, 80x24 has not
   lineRate = system_clock / dotpixels;        // results in 15625 standard PAL
   frameRate = lineRate / numscanlines;        // results in 50 Hz standard PAL
   cpuSpeed = system_clock / cpu_divisor;      // CPU speed
   cyclesPerLine = (cpuSpeed / lineRate) / 2;  // how much CPU cycles per single scan line (/2 two pal frames)

   if(poly88) {
      cpuSpeed /= 2;
      cyclesPerLine /= 2;
   }
}

let stopped = false; // allows to stop/resume the emulation

let frames = 0;
let averageFrameTime = 0;

let cycle = 0;
let cycles = 0;

let throttle = false;

let audioEnabled = false;

let options = {
   load: undefined,
   restore: true,
   notapemonitor: false,
   scanlines: true,
   saturation: 1.0,
};

let end_of_frame_hook = undefined;

function renderAllLines() {
   systemTicks(cyclesPerLine*numscanlines);
}

// NEW CODE

let last_timestamp = 0;
function oneFrame(timestamp) {
   let stamp = timestamp === undefined ? last_timestamp : timestamp;
   let msec = stamp - last_timestamp;
   last_timestamp = stamp;

   let ncycles = cpuSpeed * (msec / 1000);

   if(msec > frameRate*2) ncycles = cpuSpeed * (frameRate*2 / 1000);

   systemTicks(ncycles);

   averageFrameTime = averageFrameTime * 0.992 + msec * 0.008;

   if(!stopped) requestAnimationFrame(oneFrame);
}

function systemTicks(ncycles) {
   let endCycle = cycles + ncycles;

   while(cycles < endCycle) {
      if(debugBefore !== undefined) debugBefore();
      let elapsed = cpu.run_instruction();
      if(debugAfter !== undefined) debugAfter(elapsed);
      cycle += elapsed;
      cycles += elapsed;
      if(audioEnabled) {
         writeAudioSamples(elapsed);
         cloadAudioSamples(elapsed);
         if(csaving) csaveAudioSamples(elapsed);
      }
      if(cycle>=cyclesPerLine) {
         cycle-=cyclesPerLine;
         drawFrame_y();
      }
   }
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

parseQueryStringCommands();

power();

// calculate cpu speed
systemConfig();

// starts drawing frames
oneFrame();

// autoload program and run it
if(autoload !== undefined) {
   // gives 1 sec delay, so that load happens after ram is initialized by the eprom
   setTimeout(()=>loadBytes(autoload), 1000);
}

setTimeout(()=>load_default_disks(), 500);

// simulate paddles on poly88
let paddle0 = 0;
let paddle1 = 0;
(function() {
   document.onmousemove = handleMouseMove;
   let canvas = document.getElementById("canvas");
   function handleMouseMove(event) {
      paddle0 = Math.min(Math.floor(event.pageX/canvas.clientWidth * 128),127);
      paddle1 = Math.min(Math.floor(event.pageY/canvas.clientHeight * 128),127);
      //console.log(paddle0,paddle1);
   }
})();

function poly88_paddles_arduino() {
   if((cycles & (1<20))!=0) return paddle0;
   else                     return paddle1 | 128;
}

/*
// logs when PC = BA00h (CPM entry)
debugBefore = (function() {
   let first_time = true;
   return function() {
      let pc = cpu.getState().pc;

      if(pc === 0x0000) console.warn(`*** 0000H STARTED***`);
      if(pc === 0xBA00) console.warn(`*** CPM STARTED (BIOS $BA00) ***`);
      if(pc === 0x0100) console.warn(`*** 0100H STARTED ***`);
      if(pc === 0xEA87) console.warn(`*** EA87H RETURN WITH ERROR ***`);
      if(pc === 0xE8FE) console.warn(`*** E8FEH READ BYTES ***`);
      if(pc === 0xE8FC) console.warn(`*** E8FEH READ BYTES ***`);
      if(pc === 0xEABF) console.warn(`*** HERE ***`);
      if(pc === 0xEA7E) console.warn(`*** HERE ***`);
      if(pc === 0xE8D6) console.warn(`*** HERE ***`);

      //if(pc > 0xA000 && pc < 0xE000 && first_time) {
      //   console.warn(`*** first time at ${cpu_status()} ***`);
      //   first_time = false;
      //}

   };
})();
*/

/*
debugBefore = (function() {
   let first_time = true;
   return function() {
      let pc = cpu.getState().pc;

      if(pc === 0x0100) {
         console.warn(`*** 0100H STARTED ***`);
         console.log(cpu_status());
      }

      if(pc === 0xBA00) {
         console.warn(`*** ${hex(pc,4)} START CPM BIOS ***`);
         dumpMem(0xA400,0xB9FF);
         dumpMem(0xBA00,0xBFFF);
         console.log(cpu_status());
      }

      if(pc === 0x0103) {
         console.warn(`*** ${hex(pc,4)} TOUCHED! ***`);
         console.log(cpu_status());
      }

      if(pc === 0xeaa3) {
         console.warn(`*** ${hex(pc,4)} TOUCHED! ***`);
         console.log(cpu_status());
      }

      //if(pc > 0xA000 && pc < 0xE000 && first_time) {
      //   console.warn(`*** first time at ${cpu_status()} ***`);
      //   first_time = false;
      //}

   };
})();
*/
