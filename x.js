
// find call addresses
let calls = {};
debugBefore = ()=> {      
   const pc = cpu.getState().pc;
   if(mem_read(pc) == 0xCD) {
      // it's call
      const address = mem_read_word(pc+1);

      if(calls[address] === undefined) {
         console.log(`${hex(pc,4)} CALL ${hex(address,4)}`);
         calls[address] = true;
      }
   }
}

// count t-states in turbo tape
let ct = 0;
debugBefore = ()=> {      
   const pc = cpu.getState().pc;
   //if(pc === 0x8927) ct = cycles;
   //if(pc === 0x892f) console.log(`${cycles-ct}`);

   if(pc === 0x8969) ct = cycles;
   if(pc === 0x8983) console.log(`${cycles-ct}`);
}


// measure turbo tape bit length and threshold
(function() {
   let hits = {};
   let hv = [];
   let counter = 0;
   let values = [];
   let record = false;
   debugBefore = ()=> {      
      const { a, pc } = cpu.getState();
      
      // start recording after returning from "CALL sync_tape"
      if(pc === 0x8917) record = true;

      // log the value in A register before "CP THRESHOLD"
      if(pc === 0x8971) {
         if(record) {
            counter++;      
            values[counter] = a;
            const index = `L${a}`;
            hits[index] = (hits[index] || 0) + 1;            
            hv[a] = (hv[a] || 0) + 1;
            // if(counter % 512 === 0) console.log(hits);
         }      
      }

      // final print after loading file, before "ld (0x83e9), de"
      if(pc === 0x8956) {
         hv.forEach((e,i)=>{ console.log(`${i}: ${Math.round((e/counter)*100)}`)});
         record = false;
         hv = [];
         counter = 0;
      }
   }
   let print = function() {
      console.log(values.join("\n"));
   };
   return print;
})();

// turbo tape sync header
let _counter = 0;
debugBefore = ()=> {      
   const { pc, d, e, a } = cpu.getState();   
   if(pc === 0x8971) {
      _counter++;
      const de = e+d*256;
      if(_counter < 1024) console.log(`${hex(de,4)} (${_counter})`);
      //if(_counter < 1024) console.log(`${bin(de,16)} (${_counter})`);      
      //if(_counter < 1024) console.log(`${hex(a)} ${_counter}`);
   }
}


// logs when writing in mem at specific address
function hooked_mem_write(address, value) {
   mem_write(address, value);
   if(address === 0x4000) {
      console.log(`writing in mem ${hex(address,4)}: ${hex(value)} from pc=${hex(cpu.getState().pc,4)}`);
   }
}
cpu = new Z80({ mem_read, mem_write: hooked_mem_write, io_read, io_write });

// logs when RST 30 is called
debugBefore = (function() {
   let lastpc = 0;
   return function() {         
      if(lastpc === 0x800f) {
         // there was a call to RST 30
         console.log(cpu_status());
      }
      lastpc = cpu.getState().pc;
   };
})();


/*
// *******************************************************************************
// input test signal
let phase = 0;
let tone = 748.7;
function cloadAudioSamples(n) {
   tapeHighPtr += (n*tapeSampleRate);
   if(tapeHighPtr >= cpuSpeed) {
      tapeHighPtr-=cpuSpeed;
      const audio = Math.sin(phase) * 0.75;
      phase += (2 * Math.PI * tone / 44100);
      phase = phase % (2 * Math.PI);
      cassette_bit_in = audio > 0 ? 1 : 0;
   }
}
*/

// generate tone burst vsync

//let tone = 49.62 * 60;  
let tone = 49.556 * 80

let freq = tone;
let duty = 0.5;
let seq = [1, 1, 0, 1, 1, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];

(function() {
   let phase = 0;
   let silent = false;
   let seqp = 0;

   speakerSound.onaudioprocess = function(e) {
      const output = e.outputBuffer.getChannelData(0);
   
      // playback what is in the audio buffer
      for(let i=0; i<bufferSize; i++) {
         //const audio = Math.sin(phase) * 0.75;
         const audio = phase <= (duty * 2 * Math.PI) ? 0.75 : -0.75;
         output[i] = silent ? -0.75 : audio;

         phase += (2 * Math.PI * freq / 48000);
         if(phase > 2 * Math.PI) {
            //const bitm = Math.random()< 0.5 ? 1 : 2;
            const b = seq[(seqp++)% seq.length];
                 if(b === 0)  { silent = false; freq = tone; }
            else if(b === 1)  { silent = false; freq = tone * 2; }
            else if(b === -1) { silent = true; freq = tone*2; }
         }
         phase = phase % (2 * Math.PI);            
      }          
   }
})();

//***************************************************
// generate random bits sync with raster
let tone = 500.78;
let duty = 0.5;
let inv = false;

(function() {
   let phase = 0;
   let freq = tone;
   let cnt = 0;
   let scnt = 0;

   speakerSound.onaudioprocess = function(e) {
      const output = e.outputBuffer.getChannelData(0);
         
      for(let i=0; i<bufferSize; i++) {                  
         const audio = phase <= (duty * 2 * Math.PI) ? 0.75 : -0.75;
         output[i] = inv ? audio : -audio;

         phase += (2 * Math.PI * freq / 48000);
         if(phase > 2 * Math.PI) {
            const bitm = Math.random()< 0.5 ? 1 : 4;
                 if(cnt === 0 ) freq = tone / 2;                        
            else if(cnt === 1 ) freq = tone / 2;                        
            else freq = tone;
         }
         phase = phase % (2 * Math.PI);           

         scnt++;                    
         if(scnt > 48000 / 500.78)
         {
            scnt -= 48000 / 500.78;
            cnt++;
            cnt = cnt % 10;
         }
      }          
   }
})();


//***************************************************
// generate random bits square wave with duty cycle
let tone = 500.78;
let duty = 0.5;
let inv = false;

(function() {
   let phase = 0;
   let freq = tone;

   speakerSound.onaudioprocess = function(e) {
      const output = e.outputBuffer.getChannelData(0);
         
      for(let i=0; i<bufferSize; i++) {         
         const audio = phase <= (duty * 2 * Math.PI) ? 0.75 : -0.75;
         output[i] = inv ? audio : -audio;

         phase += (2 * Math.PI * freq / 48000);
         if(phase > 2 * Math.PI) {
            const bitm = Math.random()< 0.5 ? 1 : 4;
            freq = tone * bitm;            
         }
         phase = phase % (2 * Math.PI);            
      }          
   }
})();


//***************************************************
// generate pure square wave with duty cycle
let freq = 501.25;
let duty = 0.5;
let inv = false;

(function() {
   let phase = 0;   

   speakerSound.onaudioprocess = function(e) {
      const output = e.outputBuffer.getChannelData(0);
         
      for(let i=0; i<bufferSize; i++) {         
         const audio = phase <= (duty * 2 * Math.PI) ? 0.75 : -0.75;
         output[i] = inv ? audio : -audio;

         phase += (2 * Math.PI * freq / 48000);
         phase = phase % (2 * Math.PI);            
      }          
   }
})();



// logs when unknown io bits are changed
(function() {
   let old_io_bit_7; 
   let old_caps_lock_bit;
   let old_io_bit_4;

   debugBefore = ()=> {      
      old_io_bit_7      = io_bit_7;
      old_caps_lock_bit = caps_lock_bit;
      old_io_bit_4      = io_bit_4;
   }
   debugAfter = ()=> {                
      let { pc } = cpu.getState();
      if(old_io_bit_7 != io_bit_7)           console.log(`bit 7 changed from ${old_io_bit_7     } to ${io_bit_7     } at ${hex(pc,4)}`);
      if(old_caps_lock_bit != caps_lock_bit) console.log(`bit 6 changed from ${old_caps_lock_bit} to ${caps_lock_bit} at ${hex(pc,4)}`);
      if(old_io_bit_4 != io_bit_4)           console.log(`bit 4 changed from ${old_io_bit_4     } to ${io_bit_4     } at ${hex(pc,4)}`);
   }
})();


// installs debug on RST 38
(function() {
   // writes a RET at 0038h
   mem_write(0x0038, 0xc9);
   // install debug function
   debugBefore = (function() {
      let previous_pc = 0;
      return function() {     
         const pc = cpu.getState().pc;    
         if(pc === 0x0038) {
            // there was a call to RST 38
            console.log(`RST 38h called from ${hex(previous_pc, 4)}`);
            console.log(cpu_status());
         }
      };
   })();
   console.log("debug RST 38h installed");
})();


// breakpoints debugger
let brk = [];
(function() {
   // install debug function
   debugBefore = (function() {
      return function() {     
         const pc = cpu.getState().pc;    
         if(brk[pc] === true) {
            console.log(cpu_status());
         }
      };
   })();
   console.log("breakpoints debugger installed");
})();


// installs debug on RST 38
(function() {
   // writes a RET at 0038h
   mem_write(0x0038, 0xc9);
   // install debug function
   debugBefore = (function() {
      let previous_pc = 0;
      return function() {     
         const pc = cpu.getState().pc;    
         if(pc === 0x0038) {
            // there was a call to RST 38
            console.log(`RST 38h called from ${hex(previous_pc, 4)}`);
            console.log(cpu_status());
         }
      };
   })();
   console.log("debug RST 38h installed");
})();


// breakpoints debugger
(function() {
   // install debug function
   debugBefore = (function() {
      return function() {     
         const { pc, sp } = cpu.getState();    
         if(pc >= 0x6000 && pc <= 0x7fff) {
            console.log(`${hex(pc,4)} sp ${hex(sp,4)}`);
         }
      };
   })();
   console.log("breakpoints debugger installed");
})();


// breakpoints debugger
(function() {
   // install debug function
   debugBefore = (function() {
      return function() {     
         const { pc, sp, h, l } = cpu.getState();    
         if(pc == 0x0100) {
            console.log(`we are at ${hex(pc,4)}`);
         }
      };
   })();
   console.log("breakpoints debugger installed");
})();


// fill video memory
(function() {
   for(let t=0xC000;t<0xCFFF;t++) mem_write(t, t & 0xFF);
})();


function bitmapChars(chars) {
   let w = [];
   for(let t=0; t<chars.length; t++) {
      let b = chars[t];
      let s = [];
      for(i=7; i>=0; i--) {
         if((b & (1<<i))) s.push(" ");
         else s.push("X");
      }
      w.push(s.join(""));
   }
   console.log(w.join("\n"));
}
