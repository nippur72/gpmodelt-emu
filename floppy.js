// 3f interface outside registers
let FDC_drive_number = 0;
let FDC_side = 0;

// 1791 internal registers
let FDC_track = 0;
let FDC_sector = 0;
let FDC_data = 0;
let FDC_status = 0;

let FDC_sector_ptr = 0;

let FDC_DMA_NONE         = 0;
let FDC_DMA_READ_ADDRESS = 1;
let FDC_DMA_READ_SECTOR  = 2;
let FDC_DMA_WRITE_SECTOR = 3;

let FDC_dma = FDC_DMA_NONE;

// 1791 service pins
let FDC_HLD      = 0;
let FDC_INTREQ   = 0;

// status register bits
let FDC_STATUS_NOT_READY       = 0;  // bit 7
let FDC_STATUS_WRITE_PROTECTED = 0;  // bit 6
let FDC_STATUS_HEAD_LOADED     = 0;  // bit 5 for type I commands
let FDC_STATUS_RECORD_TYPE     = 0;  // bit 5 for read sector command
let FDC_STATUS_WRITE_FAULT     = 0;  // bit 5 for write track/sector commands
let FDC_STATUS_SEEK_ERROR      = 0;  // bit 4 for type I commands
let FDC_STATUS_RNF             = 0;  // bit 4 for read track/sector/address commands
let FDC_STATUS_CRC_ERROR       = 0;  // bit 3 for read sector/address or write sector commands
let FDC_STATUS_TRACK_0         = 0;  // bit 2 for type I commands
let FDC_STATUS_LOST_DATA       = 0;  // bit 2 for read/write commands
let FDC_STATUS_INDEX           = 0;  // bit 1 for type I commands
let FDC_STATUS_DATA_REQUEST    = 0;  // bit 1 for read/write commands
let FDC_STATUS_BUSY            = 0;  // bit 0 for all commands

let FDC_COMMAND_TYPE_I       = 0;
let FDC_COMMAND_READ_ADDRESS = 1;
let FDC_COMMAND_READ_SECTOR  = 2;
let FDC_COMMAND_READ_TRACK   = 3;
let FDC_COMMAND_WRITE_SECTOR = 4;
let FDC_COMMAND_WRITE_TRACK  = 5;

let FDC_NSIDES     = 2;
let FDC_NTRACKS    = 77;
let FDC_NSECTORS   = 26;
let FDC_SECTORSIZE = 128;
let FDC_MEDIA_SIZE = FDC_SECTORSIZE * FDC_NSECTORS * FDC_NSIDES * FDC_NTRACKS;

// data is assumed to be stored on the media:
// track 0 side 0 [ sectors 0-26 ], track 0 side 1 [ sectors 0-26 ], ...

function FDC_getpos(side, track, sector) {

   let s = sector -1;
   if(s<0) s=0;

   let pos = track * FDC_NSIDES * FDC_SECTORSIZE * FDC_NSECTORS;
   pos += side * FDC_SECTORSIZE * FDC_NSECTORS;
   pos += s * FDC_SECTORSIZE;

   return pos;
}

function FDC_read(port) {
   switch(port) {
      case 0x00:
         // read status register
         FDC_INTREQ = 0;  // reading the status registers clears INTREQ
         console.log(`read FDC status = ${hex(FDC_status)}h`);
         return FDC_status;

      case 0x01:
         // read track register
         console.warn(`read FDC track register}`);
         return FDC_track;

      case 0x02:
         // read sector register
         console.warn(`read FDC sector register}`);
         return FDC_sector;

      case 0x03:
         // read data register

         let side = FDC_drive_number == 1 || FDC_drive_number == 3 ? 1 : 0;
         let drvn = FDC_drive_number == 0 || FDC_drive_number == 1 ? 0 : 1;
         let pos = FDC_getpos(side, FDC_track, FDC_sector) + FDC_sector_ptr;

         // read sector transfer
         if(FDC_dma === FDC_DMA_READ_SECTOR) {

            if(FDC_sector_ptr == 0)   console.log(`sector start read`);
            if(FDC_sector_ptr == 127) console.log(`sector end read`);

            FDC_data = drives[drvn].floppy[pos];
            FDC_sector_ptr++;

            if(FDC_sector_ptr < FDC_SECTORSIZE) {
               FDC_STATUS_DATA_REQUEST = 1;   // there is still data to read
               FDC_STATUS_BUSY = 1;           // and we are still busy
            }
            else {
               FDC_STATUS_DATA_REQUEST = 0;    // no more data
               FDC_STATUS_BUSY = 0;            // we are no longer busy
               FDC_INTREQ      = 1;            // and the READ command terminated
               FDC_dma = FDC_DMA_NONE;         // reading ended
            }
            FDC_update_status(FDC_COMMAND_READ_SECTOR);
            //console.log(`read FDC READ ADDRESS byte index=${FDC_sector_ptr-1} data=${hex(~FDC_data & 0xff)}h`);
         }
         // read address transfer
         else if(FDC_dma === FDC_DMA_READ_ADDRESS) {
                 if(FDC_sector_ptr === 0) FDC_data = 0;           // track address
            else if(FDC_sector_ptr === 1) FDC_data = 0;           // side number
            else if(FDC_sector_ptr === 2) FDC_data = 0;           // sector address
            else if(FDC_sector_ptr === 3) FDC_data = 0;           // sector length 0=128 bytes
            else if(FDC_sector_ptr === 4) FDC_data = 0x00;        // CRC 1 (fake)
            else if(FDC_sector_ptr === 5) FDC_data = 0x00;        // CRC 2 (fake)

            FDC_sector_ptr++;

            FDC_STATUS_CRC_ERROR = 0;

            if(FDC_sector_ptr != 6) {
               FDC_STATUS_DATA_REQUEST = 1;   // there are still bytes to read
               FDC_STATUS_BUSY = 1;           // and we are still busy
            }
            else {
               FDC_STATUS_DATA_REQUEST = 0;    // no more bytes
               FDC_STATUS_BUSY = 0;            // we are no longer busy
               FDC_INTREQ      = 1;            // and the READ command terminated
               FDC_dma = FDC_DMA_NONE;         // reading ended
               FDC_sector = FDC_track;         // track address goes into sector register (data sheet page 13)
            }
            FDC_update_status(FDC_COMMAND_READ_ADDRESS);

            console.log(`read FDC READ ADDRESS byte index=${FDC_sector_ptr-1} data=${hex(FDC_data)}h`);
         }

         return FDC_data;
   }
}


function FDC_write(port, value) {
   switch(port) {
      case 0x00:
         // command port
         FDC_INTREQ = 0;      // writing to command registers clears INTREQ

         // parse commands
         FDC_parse_command(value);
         return;

      case 0x01:
         // track port
         FDC_track = value;
         //console.log(`set FDC track = ${hex(value)}h ${cpu_status()}`);
         return;

      case 0x02:
         // sector port
         FDC_sector = value;
         //console.warn(`set FDC sector = ${hex(value)}h ${cpu_status()}`);
         return;

      case 0x03:
         // data port
         FDC_data = value;
         //console.log(`FDC data = ${hex(value)}h ${cpu_status()}`);
         return;
   }
}

// updates the status register as documented in table 6
// page 26 of the data sheet
function FDC_update_status(command) {
   // column is the datasheet table 6 column index 0..5

   // automatically updates the track 0 bit
   FDC_STATUS_TRACK_0 = FDC_track === 0 ? 1 : 0;

   if(command === FDC_COMMAND_TYPE_I) {
      // type I commands
      FDC_status =
         (FDC_STATUS_NOT_READY       << 7) |
         (FDC_STATUS_WRITE_PROTECTED << 6) |
         (FDC_STATUS_HEAD_LOADED     << 5) |
         (FDC_STATUS_SEEK_ERROR      << 4) |
         (FDC_STATUS_CRC_ERROR       << 3) |
         (FDC_STATUS_TRACK_0         << 2) |
         (FDC_STATUS_INDEX           << 1) |
         (FDC_STATUS_BUSY            << 0) ;
   }
   else if(command === FDC_COMMAND_READ_ADDRESS) {
      // read address command
      FDC_status =
         (FDC_STATUS_NOT_READY       << 7) |
         (0                          << 6) |
         (0                          << 5) |
         (FDC_STATUS_RNF             << 4) |
         (FDC_STATUS_CRC_ERROR       << 3) |
         (FDC_STATUS_LOST_DATA       << 2) |
         (FDC_STATUS_DATA_REQUEST    << 1) |
         (FDC_STATUS_BUSY            << 0) ;
   }
   else if(command === FDC_COMMAND_READ_SECTOR) {
      // read sector command
      FDC_status =
         (FDC_STATUS_NOT_READY       << 7) |
         (0                          << 6) |
         (FDC_STATUS_RECORD_TYPE     << 5) |
         (FDC_STATUS_RNF             << 4) |
         (FDC_STATUS_CRC_ERROR       << 3) |
         (FDC_STATUS_LOST_DATA       << 2) |
         (FDC_STATUS_DATA_REQUEST    << 1) |
         (FDC_STATUS_BUSY            << 0) ;
   }
   else if(command === FDC_COMMAND_READ_TRACK) {
      // read track command
      FDC_status =
         (FDC_STATUS_NOT_READY       << 7) |
         (0                          << 6) |
         (0                          << 5) |
         (0                          << 4) |
         (0                          << 3) |
         (FDC_STATUS_LOST_DATA       << 2) |
         (FDC_STATUS_DATA_REQUEST    << 1) |
         (FDC_STATUS_BUSY            << 0) ;
   }
   else if(command === FDC_COMMAND_WRITE_SECTOR) {
      // write sector command
      FDC_status =
         (FDC_STATUS_NOT_READY       << 7) |
         (FDC_STATUS_WRITE_PROTECTED << 6) |
         (FDC_STATUS_WRITE_FAULT     << 5) |
         (FDC_STATUS_RNF             << 4) |
         (FDC_STATUS_CRC_ERROR       << 3) |
         (FDC_STATUS_LOST_DATA       << 2) |
         (FDC_STATUS_DATA_REQUEST    << 1) |
         (FDC_STATUS_BUSY            << 0) ;
   }
   else if(command === FDC_COMMAND_WRITE_TRACK) {
      // write track command
      FDC_status =
         (FDC_STATUS_NOT_READY       << 7) |
         (FDC_STATUS_WRITE_PROTECTED << 6) |
         (FDC_STATUS_WRITE_FAULT     << 5) |
         (0                          << 4) |
         (0                          << 3) |
         (FDC_STATUS_LOST_DATA       << 2) |
         (FDC_STATUS_DATA_REQUEST    << 1) |
         (FDC_STATUS_BUSY            << 0) ;
   }
   else throw `invalid command ${command}`;
}

function FDC_parse_command(cmd) {

   // type I flags
   let V = (cmd >> 2) & 1;  // verify bit
   let h = (cmd >> 3) & 1;  // HLD bit

   // type II & III flags
   let C = (cmd >> 1) & 1;  // F1 bit aka "enable side select compare"
   let E = (cmd >> 2) & 1;  // E bit (15 ms delay)
   let S = (cmd >> 3) & 1;  // F2 bit aka "side to compare"
   let m = (cmd >> 4) & 1;  // m (multiple sectors read/write) bit

   // RESTORE command
   if((cmd >> 4) === 0b0000) {
      // TODO V,h bits ignored
      //console.log(`FDC RESTORE with V=${V} h=${h} @@@ ${cpu_status()}`);
      console.log(`FDC RESTORE`);
      FDC_track = 0;             // goes to track 0
      FDC_INTREQ = 1;            // command terminated
      FDC_STATUS_BUSY = 0;       // no longer busy

      FDC_update_status(FDC_COMMAND_TYPE_I);
      return;
   }

   // SEEK command
   if((cmd >> 4) === 0b0001) {
      // TODO V,h bits ignored
      //console.log(`FDC SEEK from track ${FDC_track} to ${FDC_data} with V=${V} h=${h} @@@ ${cpu_status()}`);
      console.log(`FDC SEEK from track ${FDC_track} to ${FDC_data}`);

      FDC_track = FDC_data;      // does the seek from current track to desidered track
      FDC_INTREQ = 1;            // command terminated
      FDC_STATUS_BUSY = 0;       // no longer busy

      FDC_update_status(FDC_COMMAND_TYPE_I);
      return;
   }

   // READ SECTOR command
   if((cmd & 0b11100001) === 0b10000000) {
      // TODO m,F1,F2,E bits ignored
      //console.log(`FDC READ SECTOR track ${FDC_track} sec ${FDC_sector} with m=${m} S=${S} C=${C} E=${E} @@@ ${cpu_status()}`);
      console.log(`FDC READ SECTOR track ${FDC_track} sec ${FDC_sector} with m=${m}`);

      FDC_STATUS_BUSY = 1;           // marks as busy
      FDC_sector_ptr = 0;            // starts reading from byte 0
      FDC_dma = FDC_DMA_READ_SECTOR; // enable reading
      FDC_STATUS_DATA_REQUEST = 1;   // byte is ready

      FDC_update_status(FDC_COMMAND_READ_SECTOR);

      return;
   }

   // READ ADDRESS command
   if((cmd & 0b11111011) === 0b11000000) {
      // TODO E bit ignored
      //console.warn(`FDC READ ADDRESS track ${FDC_track} sec ${FDC_sector} with E=${E} @@@ ${cpu_status()}`);
      console.warn(`FDC READ ADDRESS track ${FDC_track} sec ${FDC_sector}`);

      FDC_STATUS_BUSY = 1;            // marks as busy
      FDC_sector_ptr = 0;             // starts sending first of 6 bytes
      FDC_dma = FDC_DMA_READ_ADDRESS; // enable reading
      FDC_STATUS_DATA_REQUEST = 1;    // byte is ready

      FDC_update_status(FDC_COMMAND_READ_ADDRESS);

      return;
   }

   console.warn(`unknown FDC command ${hex(cmd)}h ${cpu_status()}`);
}

/***************/

class Drive {
   constructor(drive_num, image) {
      this.drive_num = drive_num;
      this.track = 80;
      this.track_offset = 0;
      this.floppy = image === undefined ? new Uint8Array(FDC_MEDIA_SIZE) : this.resize(image);
      this.write_enabled = 0;
   }

   resize(image) {
      const new_image = new Uint8Array(FDC_MEDIA_SIZE);
      image.forEach((e,i)=>new_image[i]=e);
      return new_image;
   }
}

// the actual floppy disks inserted in the drives
const drives = [ new Drive(0), new Drive(1) ];


