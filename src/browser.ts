// handles interaction between browser and emulator

import { GPEmulator } from "./emulator";
import { BrowserStorage } from "./libemu/filesystem";

class BrowserDriver {
   emulator: GPEmulator;

   storage = new BrowserStorage("gpmodelt");

   haltD: boolean = false;

   constructor(emulator: GPEmulator) {
      this.emulator = emulator;

      window.addEventListener("resize", this.onResize.bind(this));
      window.addEventListener("dblclick", this.goFullScreen.bind(this));

      // disabled features
      // window.addEventListener("visibilitychange", this.visibilitychange.bind(this));
      // window.onbeforeunload = (e)=> saveState();

      const dropZone = document.getElementById('screen');
      if(dropZone) {
         dropZone.addEventListener('dragover', this.dragover.bind(this));
         dropZone.addEventListener('drop', this.drop.bind(this));
      }
   }

   // show the copy icon when dragging over (only work for chrome?)
   dragover(e: DragEvent) {
      e.stopPropagation();
      e.preventDefault();
      if(e.dataTransfer) e.dataTransfer.dropEffect = 'copy';
   }

   // Get file data on drop
   drop(e: DragEvent) {
      e.stopPropagation();
      e.preventDefault();

      this.emulator.audio.resume();

      if(!e.dataTransfer) return;

      const files = e.dataTransfer.files; // Array of all files

      for(let i=0; i<files.length; i++) {
         const file = files[i];
         const reader = new FileReader();
         reader.onload = e2 => {
            const data = new Uint8Array(e2!.target!.result as any); // TODO fix
            this.emulator.droppedFile(file.name, data);
         };

         reader.readAsArrayBuffer(file);
      }
   }

   update_halt_led() {
      // slow down updates
      if(this.emulator.frames % 20 != 0) return;

      // update HALT status
      let halt = this.emulator.cpu.getState().halted;
      if(this.haltD != halt) {
         const element = document.getElementById("halt");
         if(element) {
            element.style.display = halt ? "block" : "none";
         }
      }
      this.haltD = halt;
   }

   onResize() {
      const canvas = document.getElementById("canvas");
      if(!canvas) return;

      if(window.innerWidth > (window.innerHeight * this.emulator.aspect))
      {
         canvas.style.width  = `${this.emulator.aspect*100}vmin`;
         canvas.style.height = "100vmin";
      }
      else if(window.innerWidth > window.innerHeight)
      {
         canvas.style.width  = "100vmax";
         canvas.style.height = `${(1/this.emulator.aspect)*100}vmax`;
      }
      else
      {
         canvas.style.width  = "100vmin";
         canvas.style.height = `${(1/this.emulator.aspect)*100}vmin`;
      }

      canvas.style.borderRadius = "4rem";

      // disabled: used to remove scanlines if screen was too small
      //const trueHeight = canvas.offsetHeight
      //this.emulator.videoRenderer.hide_scanlines = (trueHeight < 512);
      //this.emulator.videoRenderer.palette.buildPalette();
   }

   goFullScreen() {
      const canvas = document.getElementById("canvas");
      if(!canvas) return;
      canvas.requestFullscreen();
      this.onResize();
   }

   // stop emulation when not visible
   visibilitychange() {
      if(document.visibilityState === "hidden")
      {
         this.emulator.stopped = true;
         this.emulator.audio.stop();
      }
      else if(document.visibilityState === "visible")
      {
         this.emulator.stopped = false;
         this.emulator.oneFrame(0);
         this.emulator.audio.start();
      }
   }

   async fetch(name: string)
   {
      const fname = `software/${name}`;
      const response = await fetch(fname);
      if(response.status === 404) throw `${fname} not found`;
      const bytes = new Uint8Array(await response.arrayBuffer());
      return bytes;
   }
}

// **** drag & drop ****

/*
async function droppedFile(outName, bytes, address?) {

   const ext = getFileExtension(outName);

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

   // CP/M .com
   if(ext == ".com") {
      await storage.writeFile(outName, bytes)
      await crun(outName, address);
      let pages = Math.ceil(bytes.length/256);
      paste(`SAVE ${pages} ${outName}\r\n\r\n`);
   }
}
*/

/*
async function fetchProgram(name, address)
{
   try
   {
      const response = await fetch(`software/${name}`);
      if(response.status === 404) return false;
      const bytes = new Uint8Array(await response.arrayBuffer());
      await droppedFile(name, bytes, address);
      return true;
   }
   catch(err)
   {
      return false;      
   }
}
*/


export { BrowserDriver };

