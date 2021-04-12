
let storage = new BrowserStorage("gpmodelt");

async function load(filename, p) {   
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
   const bytes = await storage.readFile(fileName);
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
   
   await storage.writeFile(filename, bytes);

   console.log(`saved "${filename}" ${bytes.length} bytes from ${hex(start,4)}h to ${hex(end,4)}h`);
}

async function save_disk(diskname, drive) {      
   if(drive === undefined) drive = 0;
   if(drive < 0 || drive >1) {
      console.log("wrong drive number");
      return;
   }
   const bytes = drives[drive].floppy;
   await storage.writeFile(diskname, bytes);
   console.log(`disk in drive ${FDC_drive_number_descs[drive]} saved as "${diskname}" (${bytes.length} bytes)`);
}

let dropdrive = 0;
async function load_disk(diskname, drive) {   
   if(drive === undefined) drive = 0;
   if(drive < 0 || drive >1) {
      console.log(`wrong drive number ${drive}`);
      return false;
   }
   const bytes = await storage.readFile(diskname);
   drives[drive].floppy = bytes;
   console.log(`disk in drive ${FDC_drive_number_descs[drive]} has been loaded with "${diskname}" (${bytes.length} bytes)`);
   return true;
}

async function load_hd(hdname) {
   const bytes = await storage.readFile(hdname);
   hard_disks[0] = new HardDisk(bytes, HDC_MEDIA_SIZE);
   console.log(`hard disk has been loaded with "${hdname}" (${bytes.length} bytes)`);
   return true;
}

async function save_hd(hdname, lun) {
   const bytes = hard_disks[lun].image;
   await storage.writeFile(hdname, bytes);
   console.log(`hard disk ${lun} saved as "${hdname}" (${bytes.length} bytes)`);
}
