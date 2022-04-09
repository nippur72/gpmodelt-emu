// utility functions that are published on the global scope to allow running from console

import { GPEmulator } from "./emulator";
import { hex } from "./utils";

declare global {
   let gp: GPEmulator;
}

function dumpMem(start: number, end: number, rows?: number) {
   if(rows==undefined) rows=16;
   let s="\r\n";
   for(let r=start;r<=end;r+=rows) {
      s+= hex(r, 4) + ": ";
      for(let c=0;c<rows && (r+c)<=end;c++) {
         const byte = gp.mem_read(r+c);
         s+= hex(byte)+" ";
      }
      for(let c=0;c<rows && (r+c)<=end;c++) {
         const byte = gp.mem_read(r+c);
         s+= (byte>32 && byte<127) ? String.fromCharCode(byte) : '.' ;
      }
      s+="\n";
   }
   console.log(s);
}

function dumpBytes(bytes: number[] | Uint8Array, start: number, end: number, rows?: number) {
   if(rows==undefined) rows=16;
   let s="\r\n";
   for(let r=start;r<=end;r+=rows) {
      s+= hex(r, 4) + ": ";
      for(let c=0;c<rows && (r+c)<=end;c++) {
         const byte = bytes[r+c];
         s+= hex(byte)+" ";
      }
      for(let c=0;c<rows && (r+c)<=end;c++) {
         const byte = bytes[r+c];
         s+= (byte>32 && byte<127) ? String.fromCharCode(byte) : '.' ;
      }
      s+="\n";
   }
   console.log(s);
}

function hexDump(memory: number[] | Uint8Array, start: number, end: number, rows: number) {
   let s="";
   for(let r=start;r<end;r+=rows) {
      s+= hex(r, 4) + ": ";
      for(let c=0;c<rows;c++) {
         const byte = memory[r+c];
         s+= hex(byte)+" ";
      }
      for(let c=0;c<rows;c++) {
         const byte = memory[r+c];
         s+= (byte>32 && byte<127) ? String.fromCharCode(byte) : '.' ;
      }
      s+="\n";
   }
   return s;
}

function csave() {
   gp.tape.csave();
}

function cstop() {
   gp.tape.cstop();
}

function goAudio() {
   gp.audio.start();
}

function stopAudio() {
   gp.audio.stop();
}

function audioContextResume() {
   gp.audio.resume();
}

function cpu_status() {
   const state = gp.cpu.getState();
   return `A=${hex(state.a)} BC=${hex(state.b)}${hex(state.c)} DE=${hex(state.d)}${hex(state.e)} HL=${hex(state.h)}${hex(state.l)} IX=${hex(state.ix,4)} IY=${hex(state.iy,4)} SP=${hex(state.sp,4)} PC=${hex(state.pc,4)} S=${state.flags.S}, Z=${state.flags.Z}, Y=${state.flags.Y}, H=${state.flags.H}, X=${state.flags.X}, P=${state.flags.P}, N=${state.flags.N}, C=${state.flags.C}`;
}

function mem_write_word(address: number, word: number) {
   gp.mem_write(address + 0, word & 0xFF);
   gp.mem_write(address + 1, (word & 0xFF00) >> 8);
}

function mem_read_word(address: number) {
   const lo = gp.mem_read(address + 0);
   const hi = gp.mem_read(address + 1);
   return lo+hi*256;
}

/*
async function crun(filename, address) {
   await load(filename, address);
}

async function drag_drop_disk(diskname, bytes) {
   console.log(`dropped disk "${diskname}"`);
   await storage.writeFile(diskname, bytes);
}
*/

function paste(text: string) {
   gp.keyboard.paste(text);
}

function stop() {
   gp.stopped = true;
   console.log("emulation stopped");
}

function go() {
   gp.stopped = false;
   gp.oneFrame(0);
   console.log("emulation resumed");
}

function info() {
   const average = gp.averageFrameTime;
   console.log(`frame rate: average ${Math.round(average*10)/10} ms (${Math.round(1000/average)} Hz)`);
}

function dumpStack() {
   const sp = gp.cpu.getState().sp;

   for(let t=sp;t<0xC000;t+=2) {
      const word = mem_read_word(t);
      console.log(`${hex(t,4)}: ${hex(word,4)}  (${word})`);
   }
}

// TODO make it connect with ATDT

// *************************************************************************************
// connects to bbs.sblendorio.eu
// requires TERM.COM
import { BBS } from "./libemu/bbs";
async function bbs() {
   let modem = new BBS();
   modem.debug = false;

   modem.onreceive = (data) => data.forEach(e=>gp.serial.receive_from_external(e));
   gp.serial.on_send_to_external = (data) => modem.send([data]);

   await modem.connect("wss://bbs.sblendorio.eu:8082","bbs");
}

export function publishGlobal(emulator: GPEmulator) {
   (window as any).gp = emulator;

   (window as any).dumpStack = dumpStack;
   (window as any).dumpMem = dumpMem;
   (window as any).dumpBytes = dumpBytes;
   (window as any).hexDump = hexDump;
   (window as any).csave = csave;
   (window as any).cstop = cstop;
   (window as any).cpu_status = cpu_status;
   (window as any).paste = paste;
   (window as any).info = info;

   (window as any).mem_write_word = mem_write_word;
   (window as any).mem_read_word = mem_read_word;
   (window as any).mem_write = (address:number, data:number) => emulator.mem_write(address, data);
   (window as any).mem_read = (address:number) => emulator.mem_read(address);

   /*
   // from filesistem.js
   window.dir      = ()   => this.dir();
   window.remove   = (fn) => this.remove(fn);
   window.download = (fn) => this.download(fn);
   window.upload   = (fn) => this.upload(fn);
   */
}
