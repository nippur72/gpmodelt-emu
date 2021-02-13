const STORAGE_KEY = "gpmodelt";

const idb = idbKeyval;
const store = new idb.Store(STORAGE_KEY, STORAGE_KEY);

async function dir() {
   const keys = await idb.keys(store);
   console.log(keys);   
   keys.forEach(async fn=>{
      const file = await readFile(fn);
      const length = file.length;
      console.log(`${fn} (${length} bytes)`);
   });
}

async function files(pattern) {
   let keys = await idb.keys(store);
   keys = keys.filter(fn=>fn.match(pattern));
   return keys;
}

async function fileExists(filename) {
   return await idb.get(filename, store) !== undefined;
}

async function readFile(fileName) {
   const bytes = await idb.get(fileName, store);   
   return bytes;
}

async function writeFile(fileName, bytes) {  
   await idb.set(fileName, bytes, store);   
}

async function removeFile(fileName) {
   await idb.del(fileName, store);   
}

// *******************************************************************************************

/*
function getStore() {
   const store = window.localStorage.getItem(STORAGE_KEY);
   if(store === undefined || store === null) return {};
   let ob = {};
   try 
   {
      ob = JSON.parse(store);
   }
   catch(ex) 
   {
   }
   return ob;
}

function setStore(store) {
   window.localStorage.setItem(STORAGE_KEY, JSON.stringify(store));
}
*/

async function load(filename, p) {   
   if(!await fileExists(filename)) {
      console.log(`file "${filename}" not found`);
      return false;
   }
   
   const ext = getFileExtension(filename);

        if(ext === ".bin") return await load_file(filename, p);
   else if(ext === ".com") return await load_file(filename, p);
   else if(ext === ".img") return await load_disk(filename, p);
   else if(ext === ".hd")  return await load_hd(filename);
   else {
      console.log(`extension "${ext}" not supported`);
      return false;
   }
}

async function save(filename, p1, p2) {
   const ext = getFileExtension(filename);

        if(ext == ".bin") await save_file(filename, p1, p2);
   else if(ext == ".com") await save_file(filename, p1, p2);
   else if(ext == ".img") await save_disk(filename, p1);
   else if(ext == ".hd")  await save_hd(filename, p1);
   else console.log(`extension "${ext}" not supported`);
}

function loadBytes(bytes, address, fileName) {
   const startAddress = (address === undefined) ? 0x0100 : address;
   const end = startAddress + bytes.length - 1;

   for(let i=0,t=startAddress;t<=end;i++,t++) {
      mem_write(t, bytes[i]);
   }   

   if(fileName === undefined) fileName = "autoload";
   console.log(`loaded "${fileName}" ${bytes.length} bytes from ${hex(startAddress,4)}h to ${hex(end,4)}h`);
}

async function load_file(fileName, address) {   
   const bytes = await readFile(fileName);
   loadBytes(bytes, address, fileName);
   return true;
}

async function save_file(filename, start, end) {
   //if(start === undefined) start = mem_read_word(0x8041);
   //if(end === undefined) end = mem_read_word(0x83E9)-1;

   const prg = [];
   for(let i=0,t=start; t<=end; i++,t++) {
      prg.push(mem_read(t));
   }
   const bytes = new Uint8Array(prg);
   
   await writeFile(filename, bytes);

   console.log(`saved "${filename}" ${bytes.length} bytes from ${hex(start,4)}h to ${hex(end,4)}h`);
}

async function save_disk(diskname, drive) {      
   if(drive === undefined) drive = 0;
   if(drive < 0 || drive >1) {
      console.log("wrong drive number");
      return;
   }
   const bytes = drives[drive].floppy;
   await writeFile(diskname, bytes);
   console.log(`disk in drive ${FDC_drive_number_descs[drive]} saved as "${diskname}" (${bytes.length} bytes)`);
}

let dropdrive = 0;
async function load_disk(diskname, drive) {   
   if(drive === undefined) drive = 0;
   if(drive < 0 || drive >1) {
      console.log(`wrong drive number ${drive}`);
      return false;
   }
   const bytes = await readFile(diskname);
   drives[drive].floppy = bytes;
   console.log(`disk in drive ${FDC_drive_number_descs[drive]} has been loaded with "${diskname}" (${bytes.length} bytes)`);
   return true;
}

async function load_hd(hdname) {
   const bytes = await readFile(hdname);
   hard_disks[0] = new HardDisk(bytes, HDC_MEDIA_SIZE);
   console.log(`hard disk has been loaded with "${hdname}" (${bytes.length} bytes)`);
   return true;
}

async function save_hd(hdname, lun) {
   const bytes = hard_disks[lun].image;
   await writeFile(hdname, bytes);
   console.log(`hard disk ${lun} saved as "${hdname}" (${bytes.length} bytes)`);
}

async function remove(filename) {   
   if(await fileExists(filename)) {
      await removeFile(filename);
      console.log(`removed "${filename}"`);
   }
   else {
      console.log(`file "${filename}" not found`);
   }
}

async function download(fileName) {   
   if(!await fileExists(fileName)) {
      console.log(`file "${fileName}" not found`);
      return;
   }
   const bytes = await readFile(fileName);
   let blob = new Blob([bytes], {type: "application/octet-stream"});   
   saveAs(blob, fileName);
   console.log(`downloaded "${fileName}"`);
}

async function dsave(fileName, p1, p2) {
   await save(fileName, p1, p2);
   download(fileName);
}

function upload(fileName) {
   throw "not impemented";
}

function getFileExtension(fileName) {
   let s = fileName.toLowerCase().split(".");
   if(s.length == 1) return "";
   return "." + s[s.length-1];
}
