"use strict";

class GPEmulator {
   constructor() {
      this.aspect = 1.5;             // aspect varies greatly due to Y deflection trimmer regulation
      this.charset_bit = 1;          // selects charset ROM font
      this.poly88 = false;           // poly88 VTI emulation
      
      this.audioEnabled = false;

      this.audio = new Audio(4096);  // the browser audio player
      this.audioBufferSize = 4096;   // size of the audio buffer, enough to hold more than one frame time
      this.audioBuffer = new Float32Array(this.audioBufferSize);  // audio buffer      
      this.audioPtr = 0;             // points to the write position in the audio buffer
      this.downSampleCounter = 0;    // counter used to downsample from CPU speed to 48 Khz audio

      this.tape = new Tape(this);
      this.tape_monitor = true;      // play tape signals on the audio

      // hardware bits TODO move to tape  
      this.cassette_bit_out1 = 0;
      this.cassette_bit_out2 = 0;
      this.cassette_bit_in = 0;
      
      // frame renderer
      this.last_timestamp = 0;      
      this.oneFrameThisBind = timestamp => this.oneFrame(timestamp);  // bind this to oneFrame once for all
      this.averageFrameTime = 0;

      this.stopped = false;   // allows to stop/resume the emulation
      this.frames = 0;        // count number of frames drawn
      this.cycles = 0;        // count number of CPU cycles
      this.cycle = 0;          // counts cycles for a frame rendering

      this.system_clock;
      this.cpu_divisor;
      this.dotpixels;
      this.numscanlines;
      this.lineRate;
      this.frameRate;
      this.cpuSpeed;
      this.cyclesPerLine;
      this.hiddenlines;   
      
      this.ROM_CONFIG = "T20";

      this.cpu = new Z80({ 
         mem_read : this.mem_read.bind(this) , 
         mem_write: this.mem_write.bind(this), 
         io_read  : this.io_read.bind(this)  , 
         io_write : this.io_write.bind(this) 
      });

      // 64K RAM
      this.memory = new Uint8Array(65536).fill(0x00); 

      this.serial = new Serial();

      this.sasi = new SASI_CONTROLLER();

      this.videoRenderer = new VideoRenderer();
      this.videoRenderer.calculateGeometry();

      this.keyboard = new AsciiKeyboard(this);
   }

   systemConfig() {
      let T08 = this.ROM_CONFIG == "T08";
      let T20 = this.ROM_CONFIG == "T20";
      if(!T08 && !T20) throw "invalid configuration";
   
      this.system_clock = T20 ? 12000000 : 10000000;             // 10 Mhz 64x16, 24Mhz 80x24
      this.cpu_divisor  = T20 ? 5 : 4;                           // cpu clock divisor from system clock
      this.dotpixels    = T20 ? 768 : 640;                       // number of dot pixels per line (512, 640 active area)
      this.numscanlines = 312;                                   // fixed PAL number of lines
      this.hiddenlines  = T20 ? 0 : 312-(16*13);                 // 64x16 has hidden lines, 80x24 has not
      this.lineRate = this.system_clock / this.dotpixels;        // results in 15625 standard PAL
      this.frameRate = this.lineRate / this.numscanlines;        // results in 50 Hz standard PAL
      this.cpuSpeed = this.system_clock / this.cpu_divisor;      // CPU speed
      this.cyclesPerLine = (this.cpuSpeed / this.lineRate) / 2;  // how much CPU cycles per single scan line (/2 two pal frames)
   
      if(this.poly88) {
         this.cpuSpeed /= 2;
         this.cyclesPerLine /= 2;
      }
   }

   rom_load(rom, address) {
      for(let i=0; i<rom.length; i++) {
         this.memory[address+i] = rom[i];
      }
   }
   
   initMem() {   
      if(this.ROM_CONFIG == "T08") {
         this.rom_load(rom_E000,        0xE000);
         this.rom_load(rom_E400,        0xE400);
         this.rom_load(rom_E800_FDC525, 0xE800);   // 5" FDC
         this.rom_load(rom_EC00_ACI,    0xEC00);
   
         this.videoRenderer.SCREEN_COLUMNS = 64;
         this.videoRenderer.SCREEN_ROWS    = 16;
         this.videoRenderer.SCREEN_COLUMNS_ARR = 64;
   
         FLOPPY_8_INCHES = false;
      }
   
      if(this.ROM_CONFIG == "T10") {
         this.rom_load(rom_E000,        0xE000);
         this.rom_load(rom_E400,        0xE400);
         this.rom_load(rom_E800_FDC8,   0xE800);   // 8" FDC
         this.rom_load(rom_EC00_ACI,    0xEC00);
   
         this.videoRenderer.SCREEN_COLUMNS = 64;
         this.videoRenderer.SCREEN_ROWS    = 16;
         this.videoRenderer.SCREEN_COLUMNS_ARR = 64;
   
         FLOPPY_8_INCHES = true;
      }
   
      /*
      if(this.ROM_CONFIG == "rig") {
         this.rom_load(rom_MON24_2,   0xE000);
         this.rom_load(rom_SYS2K_482, 0xE400);
         this.rom_load(rom_RIG02_U,   0xE800);
         this.videoRenderer.SCREEN_COLUMNS = 80;
         this.videoRenderer.SCREEN_ROWS    = 24;
         this.videoRenderer.SCREEN_COLUMNS_ARR = 128;
      }
   
      if(this.ROM_CONFIG == "scheda2") {
         this.rom_load(rom_U1MON1512, 0xE000);
         this.rom_load(rom_U3FDC,     0xE800);
         this.videoRenderer.SCREEN_COLUMNS = 80;
         this.videoRenderer.SCREEN_ROWS    = 24;
         this.videoRenderer.SCREEN_COLUMNS_ARR = 128;
      }
      */
   
      if(this.ROM_CONFIG == "T20") {
         this.rom_load(rom_T20V24, 0xE000);
         this.videoRenderer.SCREEN_COLUMNS = 80;
         this.videoRenderer.SCREEN_ROWS    = 24;
         this.videoRenderer.SCREEN_COLUMNS_ARR = 128;
      }
   
      // ROM di test di Gabriele Rossi
      // rom_load(rom_GPMON007, 0xE000);
   
      this.rom_load([ 0xC3, 0x00, 0xE0 ], 0x0000); // JP E000
   
      this.videoRenderer.calculateGeometry();
   
      wd1791.recalcFloppy();
   }
         
   oneFrame(timestamp) {
      let stamp = timestamp === undefined ? this.last_timestamp : timestamp;
      let msec = stamp - this.last_timestamp;
      this.last_timestamp = stamp;
   
      let ncycles = this.cpuSpeed * (msec / 1000);
   
      if(msec > this.frameRate*2) ncycles = this.cpuSpeed * (this.frameRate*2 / 1000);
   
      this.systemTicks(ncycles);
   
      this.averageFrameTime = this.averageFrameTime * 0.992 + msec * 0.008;
         
      if(!this.stopped) requestAnimationFrame(this.oneFrameThisBind);      
   }   

   systemTicks(ncycles) {
      let endCycle = this.cycles + ncycles;
   
      while(this.cycles < endCycle) {
         if(debugBefore !== undefined) debugBefore();
         let elapsed = this.cpu.run_instruction();
         if(debugAfter !== undefined) debugAfter(elapsed);
         this.cycle += elapsed;
         this.cycles += elapsed;
         if(this.audioEnabled) {
            this.writeAudioSamples(elapsed);
            this.tape.cloadAudioSamples(elapsed);
            if(this.tape.csaving) this.tape.csaveAudioSamples(elapsed);
         }
         if(this.cycle>=this.cyclesPerLine) {
            this.cycle-=this.cyclesPerLine;
            this.videoRenderer.drawFrame_y();
            this.frames++;
            update_halt_led();
         }
      }
   }
   
   // write cassette bits on the audio buffer for n samples with downsampling
   writeAudioSamples(n) {
      this.downSampleCounter += (n * this.audio.sampleRate);
      if(this.downSampleCounter >= this.cpuSpeed) {
         let s = 0;
         const st = (this.cassette_bit_out1 && this.cassette_bit_out2 ? 0.75 : this.cassette_bit_out2 ? -0.75 : 0 );
         if(this.tape_monitor) s += st + (this.cassette_bit_in ? 0.5 : 0.0);
         this.downSampleCounter -= this.cpuSpeed;
         this.audioBuffer[this.audioPtr++] = s;
         if(this.audioPtr > this.audioBufferSize) {
            this.audio.playBuffer(this.audioBuffer);
            this.audioPtr = 0;
         }      
      }      
   }   

   mem_read(address) {
      return this.memory[address];
   }
   
   mem_write(address, value) {
      // TODO replicate video memory pages
      if(address <= 0xCFFF) this.memory[address] = value;
      // warn disabled for T20 firmware
      // else console.warn(`ROM write at address ${hex(address,4)}h value ${hex(value)}h pc=${hex(emulator.cpu.getState().pc,4)}h`);
   }
   
   io_read(ioport) {  
      const port = ioport & 0xFF;
      //if(port!=0xFF) warn(`read from unknown port ${hex(port)}h`);
      switch(port) {
   
         case 0x6d:
            return ~this.sasi.SASI_read_pins() & 0xFF;
   
         case 0x6c:
            return ~this.sasi.SASI_read_data() & 0xFF;
   
         case 0x3f:
            return FDC_read_port_3f();
   
         case 0xff:
         case 0xd8:
            // keyboard
            return this.keyboard.keyboard_read();
   
         case 0x77:
            // ACI + video sync pins
            // VSYNC necessita bit 3 posto a 0, bit 2 posto a 1
            return 0b00000100 | (this.cassette_bit_in << 1);
   
         case 0x78:
            // serial data read
            return this.serial.cpu_read_data();
   
         case 0x7a:
            // serial status, always ready
            return this.serial.cpu_read_status();
   
         case 0xc0:
         case 0xe8:
            if(this.poly88) return this.keyboard.keyboard_read();
            else return 0;
   
         case 0xBC:
         case 0xBD:
         case 0xBE:
         case 0xBF: {
            let reg  = port - 0xBC;
            return ~FDC_read(reg) & 0xFF;   // negated because D0-D7 are negated on the 1791
         }
      }
   
      //warn(`read from unknown port ${hex(port)}h`);
      return 0x00;
   }
   
   io_write(ioport, value) {    
      const port = ioport & 0xFF;
   
      //console.log(`io write ${hex(port)} ${hex(value)}`)
      switch(port) {
   
         case 0x3f:
            FDC_write_port_3f(value);
            return;
   
         case 0x5c:
            // parallel printer
            printerWrite(value);
            return;
   
         case 0x6d:
            return this.sasi.SASI_write_pins(~value & 0xFF);
   
         case 0x6c:
            return this.sasi.SASI_write_data(~value & 0xFF);
   
         case 0x5e:
         case 0x5f:
            // paralle printer config, ignored
            return;
   
         case 0x77:
            // ACI port
            this.cassette_bit_out1 = (value & (1<<0)) > 0;
            this.cassette_bit_out2 = (value & (1<<2)) > 0;
            return;
   
         case 0x78:
            // serial data
            this.serial.cpu_write_data(value);
            return;
   
         case 0x7a:
            // serial command, ignored
            this.serial.cpu_write_command(value);
            return;
   
         case 0xBC:
         case 0xBD:
         case 0xBE:
         case 0xBF: {
           let reg  = port - 0xBC;
           let data = ~value & 0xFF;      // negated because D0-D7 are negated on the 1791
           FDC_write(reg, data);
           return;
         }
      } 
      //warn(`write on unknown port ${hex(port)}h value ${hex(value)}h`);
   }
}

