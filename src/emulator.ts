"use strict";

import { Z80, Z80CPU } from "./libemu/Z80";
import { Audio } from "./libemu/audio";
import { Serial } from "./serial";
import { VideoRenderer } from "./video";
import { Tape } from "./csave";
import { SASI_CONTROLLER, SASI_HDC_MEDIA_SIZE, SASI_FDC_MEDIA_SIZE } from "./sa1400";

import { WD7191 } from "./wd1791";
import { printerWrite } from "./libemu/printer";
import { AsciiKeyboard } from "./keyboard";
import { BrowserDriver } from "./browser";
import { HardDisk } from "./sa1400";

import { rom_E000        } from "./roms/rom.E000";
import { rom_E400        } from "./roms/rom.E400";
import { rom_E800_FDC8   } from "./roms/rom.E800_FDC8";
import { rom_E800_FDC525 } from "./roms/rom.E800_FDC525";
import { rom_EC00_ACI    } from "./roms/rom.EC00";
import { rom_T20V24      } from "./roms/rom.T20V24";

// other utils
import { getFileExtension } from "./files";

// emulator configuration
interface Config {
   model: string;    // T08, T10, T20, POLY88, CHILDZ ?
   load?: string;
}

class GPEmulator {
   aspect: number;
   charset_bit: number;
   poly88: boolean;
   imsai_soundcard: boolean;

   audioEnabled: boolean;
   audio: Audio;
   audioBufferSize: number;
   audioBuffer: Float32Array;
   audioPtr: number;
   downSampleCounter: number;

   tape: Tape;
   tape_monitor: boolean;
   cassette_bit_out1: number;
   cassette_bit_out2: number;
   cassette_bit_in: number;

   last_timestamp: number;
   oneFrameThisBind: (timestamp: number) => void;
   averageFrameTime: number;

   stopped: boolean;
   frames: number;
   cycles: number;
   cycle: number;

   system_clock: number = 0;
   cpu_divisor: number = 0;
   dotpixels: number = 0;
   numscanlines: number = 0;
   lineRate: number = 0;
   frameRate: number = 0;
   cpuSpeed: number = 0;
   cyclesPerLine: number = 0;
   hiddenlines: number = 0;

   ROM_CONFIG: string;  // TODO restric configs

   cpu: Z80CPU;
   memory: Uint8Array;
   serial: Serial;
   sasi: SASI_CONTROLLER;
   videoRenderer: VideoRenderer;
   keyboard: AsciiKeyboard;
   wd1791: WD7191;

   browser: BrowserDriver;

   debugBefore: undefined | (()=>void);
   debugAfter: undefined | ((elapsed: number)=>void);

   constructor(config: Config) {
      this.aspect = 1.5;             // aspect varies greatly due to Y deflection trimmer regulation
      this.charset_bit = 1;          // selects charset ROM font
      this.poly88 = false;           // poly88 VTI emulation
      this.imsai_soundcard = true;   // IMSAI sound card using INTEN line (DI/EI)
      
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

      this.ROM_CONFIG = config.model;

      this.cpu = Z80({
         mem_read : this.mem_read.bind(this) , 
         mem_write: this.mem_write.bind(this), 
         io_read  : this.io_read.bind(this)  , 
         io_write : this.io_write.bind(this) 
      });

      // 64K RAM
      this.memory = new Uint8Array(65536).fill(0x00); 

      this.serial = new Serial();

      this.sasi = new SASI_CONTROLLER();

      this.videoRenderer = new VideoRenderer(this);
      this.videoRenderer.calculateGeometry();

      this.keyboard = new AsciiKeyboard(this);

      this.wd1791 = new WD7191(config.model != "T08");

      this.browser = new BrowserDriver(this);
   }

   systemConfig() {
      let hires = this.ROM_CONFIG == "T20";

      this.system_clock = hires ? 12000000 : 10000000;           // 10 Mhz 64x16, 24Mhz 80x24
      this.cpu_divisor  = hires ? 5 : 4;                         // cpu clock divisor from system clock
      this.dotpixels    = hires ? 768 : 640;                     // number of dot pixels per line (512, 640 active area)
      this.numscanlines = 312;                                   // fixed PAL number of lines
      this.hiddenlines  = hires ? 0 : 312-(16*13);               // 64x16 has hidden lines, 80x24 has not
      this.lineRate = this.system_clock / this.dotpixels;        // results in 15625 standard PAL
      this.frameRate = this.lineRate / this.numscanlines;        // results in 50 Hz standard PAL
      this.cpuSpeed = this.system_clock / this.cpu_divisor;      // CPU speed
      this.cyclesPerLine = (this.cpuSpeed / this.lineRate) / 2;  // how much CPU cycles per single scan line (/2 two pal frames)
   
      if(this.poly88) {
         this.cpuSpeed /= 2;
         this.cyclesPerLine /= 2;
      }
   }

   rom_load(rom: Uint8Array, address: number) {
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
   
         this.wd1791.FLOPPY_8_INCHES = false;
      }
   
      if(this.ROM_CONFIG == "T10") {
         this.rom_load(rom_E000,        0xE000);
         this.rom_load(rom_E400,        0xE400);
         this.rom_load(rom_E800_FDC8,   0xE800);   // 8" FDC
         this.rom_load(rom_EC00_ACI,    0xEC00);
   
         this.videoRenderer.SCREEN_COLUMNS = 64;
         this.videoRenderer.SCREEN_ROWS    = 16;
         this.videoRenderer.SCREEN_COLUMNS_ARR = 64;
   
         this.wd1791.FLOPPY_8_INCHES = true;
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
   
      this.rom_load(new Uint8Array([ 0xC3, 0x00, 0xE0 ]), 0x0000); // JP E000
   
      this.videoRenderer.calculateGeometry();
   }

   zap() {
      for(let t=0;t<this.memory.length;t++) this.memory[t] = (Math.random()*4096) & 0xFF;
      //for(let t=0;t<emulator.memory.length;t++) emulator.memory[t] = 0x76;
      this.initMem();
      let state = this.cpu.getState();
      state.halted = true;
      this.cpu.setState(state);
   }

   power() {
      this.zap();
      this.renderAllLines();
      this.cpu.reset();
      this.sasi.SASI_reset();
   }

   /*
   async load_default_disks() {
      let disk1 = this.wd1791.FLOPPY_8_INCHES ? "GP16_IMD.img" : "disk_2x40x17x128xSS.img";
      let disk2 = this.wd1791.FLOPPY_8_INCHES ? "GP02_IMD.img" : "disk_2x40x17x128xSS.img";
      if(this.poly88) disk1 = "reverse.img";
      let storage = this.browser.storage;

      if(await storage.fileExists(disk1) && await storage.fileExists(disk2)) {
         await load(disk1,1);
         await load(disk2,0);
      }
      else {
         dropdrive = 1; await fetchProgram(`disks/${disk1}`);
         dropdrive = 0; await fetchProgram(`disks/${disk2}`);
      }
      if(this.poly88) {
         paste("\r");
         for(let t=0;t<20;t++) this.renderAllLines();
         paste("BD");
      }

      if(this.ROM_CONFIG == "T20") {
         let hdname = "SA1004_T20.hd";
         if(await storage.fileExists(hdname)) await load(hdname);
         else await fetchProgram(`disks/${hdname}`);
      }
   }
   */

   async getFileOrDefault(imageName: string, defaultName: string) {
      if(await this.browser.storage.fileExists(imageName)) {
         return await this.browser.storage.readFile(imageName);
      } else {
         return await this.browser.fetch(defaultName);
      }
   }

   async attach_media() {
      // attach 8" and 5.25" disk images to WDC1791 controller
      let fd8_0 = await this.getFileOrDefault("WDC1791_8_DRIVE_0.img",   "disks/GP02_IMD.img");
      let fd8_1 = await this.getFileOrDefault("WDC1791_8_DRIVE_1.img",   "disks/GP16_IMD.img");
      let fd5_0 = await this.getFileOrDefault("WDC1791_525_DRIVE_0.img", "disks/disk_2x40x17x128xSS.img");
      let fd5_1 = await this.getFileOrDefault("WDC1791_525_DRIVE_1.img", "disks/disk_2x40x17x128xSS.img");
      this.wd1791.drives[0].floppy = this.wd1791.FLOPPY_8_INCHES ? fd8_0 : fd5_0 ;
      this.wd1791.drives[1].floppy = this.wd1791.FLOPPY_8_INCHES ? fd8_1 : fd5_1 ;

      // attach disk images to SASI controller
      let hd0 = await this.getFileOrDefault("SASI_HD0.hd", "disks/SA1004_T20.hd");
      let hd1 = await this.getFileOrDefault("SASI_FD1.hd", "disks/SA1004_T20.hd");
      let hd2 = await this.getFileOrDefault("SASI_HD2.hd", "disks/SA1004_T20.hd");
      let hd3 = await this.getFileOrDefault("SASI_HD3.hd", "disks/SA1004_T20.hd");
      this.sasi.hard_disks[0] = new HardDisk(hd0, SASI_HDC_MEDIA_SIZE);
      this.sasi.hard_disks[1] = new HardDisk(hd1, SASI_FDC_MEDIA_SIZE);
      this.sasi.hard_disks[2] = new HardDisk(hd2, SASI_HDC_MEDIA_SIZE);
      this.sasi.hard_disks[3] = new HardDisk(hd3, SASI_HDC_MEDIA_SIZE);
   }

   async detach_media() {

      let { writeFile } = this.browser.storage;

      if( this.wd1791.FLOPPY_8_INCHES) await writeFile("WDC1791_8_DRIVE_0.img",   this.wd1791.drives[0].floppy);
      if( this.wd1791.FLOPPY_8_INCHES) await writeFile("WDC1791_8_DRIVE_1.img",   this.wd1791.drives[1].floppy);
      if(!this.wd1791.FLOPPY_8_INCHES) await writeFile("WDC1791_525_DRIVE_0.img", this.wd1791.drives[0].floppy);
      if(!this.wd1791.FLOPPY_8_INCHES) await writeFile("WDC1791_525_DRIVE_1.img", this.wd1791.drives[1].floppy);

      await writeFile("SASI_HD0.hd", this.sasi.hard_disks[0].image);
      await writeFile("SASI_FD1.hd", this.sasi.hard_disks[1].image);
      await writeFile("SASI_HD2.hd", this.sasi.hard_disks[2].image);
      await writeFile("SASI_HD3.hd", this.sasi.hard_disks[3].image);
   }

   async droppedFile(filename: string, bytes: Uint8Array) {

      const ext = getFileExtension(filename);

      /*
      if(ext == ".wav") {
         // WAV files
         console.log("WAV file dropped");
         const info = decodeSync(bytes.buffer);
         emulator.tape.cload(info.channelData[0], info.sampleRate);
         return;
      }

      if(ext == ".img") {
         await drag_drop_disk(outName, bytes);
         await load(outName, dropdrive);
         return;
      }

      if(ext == ".hd") {
         await drag_drop_disk(outName, bytes);
         await load(outName, dropdrive);
         return;
      }

      if(ext == ".bin") {
         await storage.writeFile(outName, bytes)
         await crun(outName, address);
      }
      */

      // CP/M .com
      if(ext == ".com") this.load_com_file(filename, bytes);
   }

   load_com_file(filename:string, bytes: Uint8Array) {
      const cpm_address = 0x0100;

      for(let i=0; i<bytes.length; i++) {
         this.mem_write(cpm_address+i, bytes[i]);
      }

      let pages = Math.ceil(bytes.length/256);
      let command = `SAVE ${pages} ${filename}\r\n\r\n`;
      this.keyboard.paste(command);
   }

   renderAllLines() {
      this.systemTicks(this.cyclesPerLine * this.numscanlines);
   }

   oneFrame(timestamp: number) {
      let stamp = timestamp === undefined ? this.last_timestamp : timestamp;
      let msec = stamp - this.last_timestamp;
      this.last_timestamp = stamp;
   
      let ncycles = this.cpuSpeed * (msec / 1000);
   
      if(msec > this.frameRate*2) ncycles = this.cpuSpeed * (this.frameRate*2 / 1000);
   
      this.systemTicks(ncycles);
   
      this.averageFrameTime = this.averageFrameTime * 0.992 + msec * 0.008;
         
      if(!this.stopped) requestAnimationFrame(this.oneFrameThisBind);      
   }   

   systemTicks(ncycles: number) {
      let endCycle = this.cycles + ncycles;
   
      while(this.cycles < endCycle) {
         if(this.debugBefore !== undefined) this.debugBefore();
         let elapsed = this.cpu.run_instruction();
         if(this.debugAfter !== undefined) this.debugAfter(elapsed);
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
            this.browser.update_halt_led();
         }
      }
   }
   
   // write cassette bits on the audio buffer for n samples with downsampling
   writeAudioSamples(n: number) {
      this.downSampleCounter += (n * this.audio.sampleRate);
      if(this.downSampleCounter >= this.cpuSpeed) {
         let s = 0;
         const st = (this.cassette_bit_out1 && this.cassette_bit_out2 ? 0.75 : this.cassette_bit_out2 ? -0.75 : 0 );
         if(this.tape_monitor) s += st + (this.cassette_bit_in ? 0.5 : 0.0);
         if(this.imsai_soundcard) s += st + (this.cpu.getState().iff1 ? 0.5 : 0.0);
         this.downSampleCounter -= this.cpuSpeed;
         this.audioBuffer[this.audioPtr++] = s;
         if(this.audioPtr > this.audioBufferSize) {
            this.audio.playBuffer(this.audioBuffer);
            this.audioPtr = 0;
         }      
      }      
   }   

   mem_read(address: number) {
      return this.memory[address];
   }
   
   mem_write(address: number, value: number) {
      // TODO replicate video memory pages
      if(address <= 0xCFFF) this.memory[address] = value;
      // warn disabled for T20 firmware
      // else console.warn(`ROM write at address ${hex(address,4)}h value ${hex(value)}h pc=${hex(emulator.cpu.getState().pc,4)}h`);
   }
   
   io_read(ioport: number) {
      const port = ioport & 0xFF;
      //if(port!=0xFF) warn(`read from unknown port ${hex(port)}h`);
      switch(port) {
   
         case 0x6d:
            return ~this.sasi.SASI_read_pins() & 0xFF;
   
         case 0x6c:
            return ~this.sasi.SASI_read_data() & 0xFF;
   
         case 0x3f:
            return this.wd1791.FDC_read_port_3f();
   
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
            return ~this.wd1791.FDC_read(reg) & 0xFF;   // negated because D0-D7 are negated on the 1791
         }
      }
   
      //warn(`read from unknown port ${hex(port)}h`);
      return 0x00;
   }
   
   io_write(ioport: number, value: number) {
      const port = ioport & 0xFF;
   
      //console.log(`io write ${hex(port)} ${hex(value)}`)
      switch(port) {
   
         case 0x3f:
            this.wd1791.FDC_write_port_3f(value);
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
            this.cassette_bit_out1 = (value & (1<<0)) > 0 ? 1 : 0 ;
            this.cassette_bit_out2 = (value & (1<<2)) > 0 ? 1 : 0 ;   // TODO write with shifts
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
           this.wd1791.FDC_write(reg, data);
           return;
         }
      } 
      //warn(`write on unknown port ${hex(port)}h value ${hex(value)}h`);
   }
}

export { GPEmulator, Config };
