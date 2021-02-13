// handles interaction between browser and emulation 

function onResize(e) {
   const canvas = document.getElementById("canvas");

   if(window.innerWidth > (window.innerHeight*aspect))
   {
      canvas.style.width  = `${aspect*100}vmin`;
      canvas.style.height = "100vmin";
   }
   else if(window.innerWidth > window.innerHeight)
   {
      canvas.style.width  = "100vmax";
      canvas.style.height = `${(1/aspect)*100}vmax`;
   }
   else
   {
      canvas.style.width  = "100vmin";
      canvas.style.height = `${(1/aspect)*100}vmin`;
   }
   
   canvas.style.borderRadius = "4rem";

   const trueHeight = canvas.offsetHeight
   hide_scanlines = (trueHeight < 512);
   buildPalette();
}

function goFullScreen() 
{
        if(canvas.webkitRequestFullscreen !== undefined) canvas.webkitRequestFullscreen();
   else if(canvas.mozRequestFullScreen !== undefined) canvas.mozRequestFullScreen();      
   onResize();
}

window.addEventListener("resize", onResize);
window.addEventListener("dblclick", goFullScreen);

onResize();

// **** save state on close ****

window.onbeforeunload = function(e) {
   saveState();   
 };

// **** visibility change ****

window.addEventListener("visibilitychange", function() {
   if(document.visibilityState === "hidden")
   {
      stopped = true;
      stopAudio();
   }
   else if(document.visibilityState === "visible")
   {
      stopped = false;
      oneFrame();
      goAudio();
   }
});

// **** drag & drop ****

const dropZone = document.getElementById('screen');

// Optional.   Show the copy icon when dragging over.  Seems to only work for chrome.
dropZone.addEventListener('dragover', function(e) {
   e.stopPropagation();
   e.preventDefault();
   e.dataTransfer.dropEffect = 'copy';
});

// Get file data on drop
dropZone.addEventListener('drop', e => {
   audioContextResume();

   e.stopPropagation();
   e.preventDefault();
   const files = e.dataTransfer.files; // Array of all files

   for(let i=0, file; file=files[i]; i++) {                   
      const reader = new FileReader();      
      reader.onload = e2 => droppedFile(file.name, new Uint8Array(e2.target.result));
      reader.readAsArrayBuffer(file); 
   }
});

async function droppedFile(outName, bytes, address) {

   const ext = getFileExtension(outName);

   if(ext == ".wav") {
      // WAV files
      //console.log("WAV file dropped");
      const info = decodeSync(bytes.buffer);
      tapeSampleRate = info.sampleRate;
      //console.log(info.channelData);
      tapeBuffer = info.channelData[0];
      tapeLen = tapeBuffer.length;
      tapePtr = 0;
      tapeHighPtr = 0;
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
      await writeFile(outName, bytes)
      await crun(outName, address);
   }

   // CP/M .com
   if(ext == ".com") {
      await writeFile(outName, bytes)
      await crun(outName, address);
      let pages = Math.ceil(bytes.length/256);
      paste(`SAVE ${pages} ${outName}\r\n\r\n`);
   }
}

// **** welcome message ****

function welcome() {
}

function getQueryStringObject(options) {
   let a = window.location.search.split("&");
   let o = a.reduce((o, v) =>{
      var kv = v.split("=");
      const key = kv[0].replace("?", "");
      let value = kv[1];
           if(value === "true") value = true;
      else if(value === "false") value = false;
      o[key] = value;
      return o;
   }, options);
   return o;
}

function parseQueryStringCommands() {
   options = getQueryStringObject(options);

   if(options.load !== undefined) {
      let [name, address] = options.load.split(",");  

      if(address !== undefined) address = parseInt(address, 16);

      setTimeout(()=>fetchProgram(name, address), 1000);
   }

   let rom = options.config == undefined ? "t20" : options.config.toLowerCase();
        if(rom == "t20") ROM_CONFIG = "T20";
   else if(rom == "t08") ROM_CONFIG = "T08";
   else if(rom == "t10") ROM_CONFIG = "T10";

   if(options.poly88 !== undefined) {
      poly88 = options.poly88;
      ROM_CONFIG = "T10";
   }

   if(options.bt !== undefined || 
      options.bb !== undefined || 
      options.bh !== undefined || 
      options.aspect !== undefined
   ) {
      if(options.bt     !== undefined) border_top    = Number(options.bt); 
      if(options.bb     !== undefined) border_bottom = Number(options.bb);
      if(options.bh     !== undefined) border_h      = Number(options.bh);
      if(options.aspect !== undefined) aspect        = Number(options.aspect);
      calculateGeometry();
      onResize();
   }
}

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

function rewind_tape() {   
   tapePtr = 0;
   tapeHighPtr = 0;
}

function stop_tape() {   
   tapePtr = tapeLen;   
}

let haltD = false;
function update_halt_led() {
   // slow down updates
   if(frames % 20 != 0) return;

   // update HALT status
   let halt = cpu.getState().halted;
   if(haltD != halt) {
      const element = document.getElementById("halt");
      element.style.display = halt ? "block" : "none";
   }
   haltD = halt;
}
