/**** utility functions ****/

// ********************************* UTILS WRAPPERS ************************************

export function hex(value: number, size?: number) {
   if(size === undefined) size = 2;
   let s = "0000" + value.toString(16);
   return s.substr(s.length - size);
}

export function bin(value: number, size?: number) {
   if(size === undefined) size = 8;
   let s = "0000000000000000" + value.toString(2);
   return s.substr(s.length - size);
}

export function set(value: number, bitmask: number) {
   return value | bitmask; 
}

export function reset(value: number, bitmask: number) {
   return value & (0xFF ^ bitmask);
}

/*
function saveState() {
   const saveObject = {
      memory: Array.from(emulator.memory),
      cpu: emulator.cpu.getState()  
   };   

   window.localStorage.setItem(`childzemu_state`, JSON.stringify(saveObject));
}

function restoreState() {   
   try
   {
      let s = window.localStorage.getItem(`childzemu_state`);

      if(s === null) return;   

      s = JSON.parse(s);      
      
      copyArray( s.memory, memory);
      emulator.cpu.setState(s.cpu);
   }
   catch(error)
   {

   }
}
*/

let debugBefore: (()=>void) | undefined = undefined;
let debugAfter: ((elapsed: number)=>void) | undefined = undefined;

export function bit(value: number, pos: number) {
   return (value & (1<<pos))>0 ? 1 : 0;
} 

export function not_bit(value: number, pos: number) {
   return (value & (1<<pos))>0 ? 0 : 1;
} 

export function endsWith(s: string, value: string) {
   return s.substr(-value.length) === value;
}

import { saveAs } from "file-saver";
export function downloadBytes(fileName: string, buffer: Uint8Array) {
   let blob = new Blob([buffer], {type: "application/octet-stream"});
   saveAs(blob, fileName);
   console.log(`downloaded "${fileName}"`);
}

