let debug_write_track      = false;
let debug_read_track       = false;
let debug_write_sector     = false;
let debug_write_sector_dma = false;
let debug_read_sector      = false;
let debug_read_sector_dma  = false;
let debug_read_address     = false;
let debug_read_address_dma = false;
let debug_read_status      = false;
let debug_read_3f          = false;

let FLOPPY_8_INCHES = true;

// 3f interface outside registers
let FDC_drive_number = 3;
let FDC_side = 0;

let FDC_side_descs = [ "S0", "S1" ];
let FDC_drive_number_descs = [ "D0", "D1", "D2", "D3" ];

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
let FDC_DMA_READ_TRACK   = 3;
let FDC_DMA_WRITE_TRACK  = 4;

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

let FDC_COMMAND_TYPE_I          = 0;
let FDC_COMMAND_READ_ADDRESS    = 1;
let FDC_COMMAND_READ_SECTOR     = 2;
let FDC_COMMAND_READ_TRACK      = 3;
let FDC_COMMAND_WRITE_SECTOR    = 4;
let FDC_COMMAND_WRITE_TRACK     = 5;
let FDC_COMMAND_FORCE_INTERRUPT = 6;

let FDC_NSIDES     = FLOPPY_8_INCHES ? 2   : 2;
let FDC_NTRACKS    = FLOPPY_8_INCHES ? 77  : 40;
let FDC_NSECTORS   = FLOPPY_8_INCHES ? 26  : 18;
let FDC_SECTORSIZE = FLOPPY_8_INCHES ? 128 : 128;
let FDC_MEDIA_SIZE = FDC_SECTORSIZE * FDC_NSECTORS * FDC_NSIDES * FDC_NTRACKS;

// data is assumed to be stored on the media:
// track 0 side 0 [ sectors 0-26 ], track 0 side 1 [ sectors 0-26 ], ...

function FDC_getpos(side, track, sector) {

   let sec = FLOPPY_8_INCHES ? sector-1 : sector;

   if(sec<0) {
      console.warn(`sector ${sec}`)
      sec=0;
   }

   let sid = side == 0 ? 0 : 1;

   let pos = track * FDC_NSIDES * FDC_SECTORSIZE * FDC_NSECTORS;
   pos += sid * FDC_SECTORSIZE * FDC_NSECTORS;
   pos += sec * FDC_SECTORSIZE;

   return pos;
}

let warnings = 0;
function warn(msg) {
   warnings++;
   if(warnings < 10000) {
      console.log(msg);
   }
}

function FDC_read_port_3f() {
   let byte = (FDC_drive_number        << 0)  |
              (FDC_side                << 3)  |
              (FDC_HLD                 << 5)  |
              (FDC_INTREQ              << 6)  |
              (FDC_STATUS_DATA_REQUEST << 7);

   if(debug_read_3f) console.log(`read from drive select: ret=${hex(byte)}h drive number=${FDC_drive_number} side=${FDC_side} INTREQ=${FDC_INTREQ} DATAREQ=${FDC_STATUS_DATA_REQUEST}`);

   return byte;
}

function FDC_write_port_3f(value) {
   let drive_number = value & 0b11;
   let side = (value & 0b1000) >> 3;

   // DDEN is supported only on the 5.25 machine
   // let DDEN = (value >> 6) & 1;
   // console.log(`*************** ${DDEN}`);

   //if(drive_number != FDC_drive_number) console.log(`**** drive number changed to "${FDC_drive_number_descs[drive_number]}"`);
   //if(side != FDC_side) console.log(`**** side changed to "${FDC_side_descs[side]}"`);

   FDC_drive_number = drive_number;
   FDC_side = side;

   //console.log(`write to drive select: drive number=${FDC_drive_number} side=${FDC_side} ${cpu_status()}`);
   //console.log(`drive select: drive number=${FDC_drive_number} side=${FDC_side}`);
}

function FDC_read(port) {
   switch(port) {
      case 0x00:
         // read status register
         FDC_INTREQ = 0;  // reading the status registers clears INTREQ
         if(debug_read_status) console.log(`read FDC status = ${hex(FDC_status)}h`);
         return FDC_status;

      case 0x01:
         // read track register
         //console.warn(`read FDC track register}`);
         return FDC_track;

      case 0x02:
         // read sector register
         //console.warn(`read FDC sector register}`);
         return FDC_sector;

      case 0x03:
         // read data register

         // let side = FDC_drive_number == 1 || FDC_drive_number == 3 ? 1 : 0;

         let side = FDC_side == 0 ? 1 : 0;

         let drvn = FDC_drive_number == 2 ? 0 : 1;
         let pos = FDC_getpos(side, FDC_track, FDC_sector) + FDC_sector_ptr;

         // read sector transfer
         if(FDC_dma === FDC_DMA_READ_SECTOR) {

            if(debug_read_sector_dma && FDC_sector_ptr == 0)   console.log(`sector start read`);
            if(debug_read_sector_dma && FDC_sector_ptr == 127) console.log(`sector end read`);

            //if(FDC_sector_ptr == 0) console.log(`sector start read drvn=${drvn} pos=${pos}`);

            if(pos>drives[drvn].floppy.length-1) {
               console.warn(`read beyond disk`);
            }
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
         }
         // read address transfer
         else if(FDC_dma === FDC_DMA_READ_ADDRESS) {
                 if(FDC_sector_ptr === 0) FDC_data = 0;                  // dummy data, track address
            else if(FDC_sector_ptr === 1) FDC_data = 0;                  // dummy data, side number
            else if(FDC_sector_ptr === 2) FDC_data = 0;                  // dummy data, sector address
            else if(FDC_sector_ptr === 3) FDC_data = 0;                  // dummy data, sector length 0=128 bytes
            else if(FDC_sector_ptr === 4) FDC_data = 0x00;               // dummy data, CRC 1 (fake)
            else if(FDC_sector_ptr === 5) FDC_data = 0x00;               // dummy data, CRC 2 (fake)

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

            if(debug_read_address_dma) console.log(`read FDC READ ADDRESS byte index=${FDC_sector_ptr-1} data=${hex(FDC_data)}h`);
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
         //console.warn(`DC command ${hex(value)}h`);
         FDC_parse_command(value);
         return;

      case 0x01:
         // track port
         FDC_track = value;
         //console.log(`set FDC track = ${hex(value)}h`);
         return;

      case 0x02:
         // sector port
         FDC_sector = value;
         //console.log(`set FDC sector = ${hex(value)}h`);
         return;

      case 0x03:
         // data port
         FDC_data = value;
         // write data register

         let side = FDC_side == 0 ? 1 : 0;
         let drvn = FDC_drive_number == 2 ? 0 : 1;

         // write sector transfer
         if(FDC_dma === FDC_DMA_WRITE_SECTOR) {
            let pos = FDC_getpos(side, FDC_track, FDC_sector) + FDC_sector_ptr;

            if(debug_write_sector_dma && FDC_sector_ptr == 0)                  console.log(`sector start write`);
            if(debug_write_sector_dma && FDC_sector_ptr == FDC_SECTORSIZE - 1) console.log(`sector end write`);

            if(pos>drives[drvn].floppy.length-1) {
               console.warn(`write beyond disk`);
            }
            drives[drvn].floppy[pos] = FDC_data;
            FDC_sector_ptr++;

            if(FDC_sector_ptr < FDC_SECTORSIZE) {
               FDC_STATUS_DATA_REQUEST = 1;   // there is still data to write
               FDC_STATUS_BUSY = 1;           // and we are still busy
            }
            else {
               FDC_STATUS_DATA_REQUEST = 0;    // no more data
               FDC_STATUS_BUSY = 0;            // we are no longer busy
               FDC_INTREQ      = 1;            // and the READ command terminated
               FDC_dma = FDC_DMA_NONE;         // reading ended
            }
            FDC_update_status(FDC_COMMAND_WRITE_SECTOR);
         }
         else if(FDC_dma === FDC_DMA_WRITE_TRACK) {
            let pos = FDC_getpos(side, FDC_track, 1) + FDC_sector_ptr;

            if(debug_write_sector_dma && FDC_sector_ptr == 0)                                 console.log(`track start write`);
            if(debug_write_sector_dma && FDC_sector_ptr == FDC_NSECTORS * FDC_SECTORSIZE - 1) console.log(`track end write`);

            if(pos>drives[drvn].floppy.length-1) {
               console.warn(`write beyond disk`);
            }
            drives[drvn].floppy[pos] = FDC_data;
            FDC_sector_ptr++;

            if(FDC_sector_ptr < FDC_NSECTORS * FDC_SECTORSIZE) {
               FDC_STATUS_DATA_REQUEST = 1;   // there is still data to write
               FDC_STATUS_BUSY = 1;           // and we are still busy
            }
            else {
               FDC_STATUS_DATA_REQUEST = 0;    // no more data
               FDC_STATUS_BUSY = 0;            // we are no longer busy
               FDC_INTREQ      = 1;            // and the READ command terminated
               FDC_dma = FDC_DMA_NONE;         // reading ended
            }
            FDC_update_status(FDC_COMMAND_WRITE_TRACK);
         }

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
   else if(command === FDC_COMMAND_FORCE_INTERRUPT) {
      // force interrupt works as TYPE I
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
   else throw `invalid command ${command}`;
}

function FDC_parse_command(cmd) {

   // type I flags
   let V = (cmd >> 2) & 1;  // verify bit
   let h = (cmd >> 3) & 1;  // HLD bit
   let u = (cmd >> 4) & 1;  // update track bit

   // type II & III flags
   let C  = (cmd >> 1) & 1;  // F1 bit aka "enable side select compare"
   let E  = (cmd >> 2) & 1;  // E bit (15 ms delay)
   let S  = (cmd >> 3) & 1;  // F2 bit aka "side to compare"
   let m  = (cmd >> 4) & 1;  // m (multiple sectors read/write) bit
   let a0 = (cmd >> 0) & 1;  // a0 data address mark 1=F8, 0=FB

   // RESTORE command
   if((cmd >> 4) === 0b0000) {
      // TODO V,h bits ignored
      //console.log(`FDC RESTORE with V=${V} h=${h} @@@ ${cpu_status()}`);
      //console.log(`FDC RESTORE`);
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
      //console.log(`FDC SEEK from track ${FDC_track} to ${FDC_data}`);

      FDC_track = FDC_data;      // does the seek from current track to desidered track

      if(FDC_track >= FDC_NTRACKS) {
         FDC_STATUS_SEEK_ERROR = 1;   // track out of range
         console.warn(`track ${FDC_track} out of range `);
      }

      FDC_INTREQ = 1;            // command terminated
      FDC_STATUS_BUSY = 0;       // no longer busy

      FDC_update_status(FDC_COMMAND_TYPE_I);
      return;
   }

   // STEP IN command
   if((cmd & 0b11100000) === 0b01000000) {
      // TODO V,h bits ignored
      //console.log(`FDC STEP IN at track ${FDC_track}`);

      if(u === 1) FDC_track++    // increment track register if u bit is 1

      if(FDC_track >= FDC_NTRACKS) {
         FDC_STATUS_SEEK_ERROR = 1;   // track out of range
         console.warn(`track ${FDC_track} out of range `);
      }

      FDC_INTREQ = 1;            // command terminated
      FDC_STATUS_BUSY = 0;       // no longer busy

      FDC_update_status(FDC_COMMAND_TYPE_I);
      return;
   }

   // WRITE SECTOR command
   if((cmd & 0b11100000) === 0b10100000) {
      // TODO m,F1,F2,E,a0 bits ignored
      //console.log(`FDC READ SECTOR track ${FDC_track} sec ${FDC_sector} with m=${m} S=${S} C=${C} E=${E} @@@ ${cpu_status()}`);
      //if(debug_write_sector) console.log(`FDC WRITE SECTOR track ${FDC_track} sec ${FDC_sector} drive=${FDC_drive_number_descs[FDC_drive_number]} side=${FDC_side_descs[FDC_side]}`);

      if(debug_write_sector) console.log(`FDC WRITE SECTOR track ${FDC_track} sec ${FDC_sector} drive=${FDC_drive_number_descs[FDC_drive_number]} side=${FDC_side_descs[FDC_side]} t=${mem_read(0xbfda)} s=${mem_read(0xBFDB)}`);

      // sector out of range
      if( ((FDC_sector<1 || FDC_sector>FDC_NSECTORS) && FLOPPY_8_INCHES) || (FDC_sector>=FDC_NSECTORS && !FLOPPY_8_INCHES)) {
         FDC_STATUS_RNF = 1;
         FDC_INTREQ = 1;
         FDC_STATUS_BUSY = 0;
         FDC_update_status(FDC_COMMAND_WRITE_SECTOR);
         console.warn(`sector ${FDC_sector} out of range `);
         return;
      }

      FDC_STATUS_BUSY = 1;            // marks as busy
      FDC_sector_ptr = 0;             // starts writing from byte 0
      FDC_dma = FDC_DMA_WRITE_SECTOR; // enable writing
      FDC_STATUS_DATA_REQUEST = 1;    // asks for a byte to be sent
      FDC_update_status(FDC_COMMAND_WRITE_SECTOR);

      return;
   }

   // WRITE TRACK command
   if((cmd & 0b11110000) === 0b11110000) {
      // TODO m,F1,F2,E,a0 bits ignored
      //console.log(`FDC READ SECTOR track ${FDC_track} sec ${FDC_sector} with m=${m} S=${S} C=${C} E=${E} @@@ ${cpu_status()}`);
      if(debug_write_track) console.log(`FDC WRITE TRACK track ${FDC_track}`);

      // TODO gestire errore

      FDC_STATUS_BUSY = 1;            // marks as busy
      FDC_sector_ptr = 0;             // starts writing from byte 0
      FDC_dma = FDC_DMA_WRITE_TRACK;  // enable writing
      FDC_STATUS_DATA_REQUEST = 1;    // asks for a byte to be sent

      FDC_update_status(FDC_COMMAND_WRITE_TRACK);

      return;
   }

   // READ SECTOR command
   if((cmd & 0b11100001) === 0b10000000) {
      // TODO m,F1,F2,E bits ignored
      //console.log(`FDC READ SECTOR track ${FDC_track} sec ${FDC_sector} with m=${m} S=${S} C=${C} E=${E} @@@ ${cpu_status()}`);
      if(debug_read_sector) console.log(`FDC READ SECTOR track ${FDC_track} sec ${FDC_sector} drive=${FDC_drive_number_descs[FDC_drive_number]} side=${FDC_side_descs[FDC_side]}`);

      // sector out of range
      if( ((FDC_sector<1 || FDC_sector>FDC_NSECTORS) && FLOPPY_8_INCHES) || (FDC_sector>=FDC_NSECTORS && !FLOPPY_8_INCHES)) {
         FDC_STATUS_RNF = 1;
         FDC_INTREQ = 1;
         FDC_STATUS_BUSY = 0;
         FDC_update_status(FDC_COMMAND_READ_SECTOR);
         console.warn(`sector ${FDC_sector} out of range `);
         return;
      }

      FDC_STATUS_BUSY = 1;           // marks as busy
      FDC_sector_ptr = 0;            // starts reading from byte 0
      FDC_dma = FDC_DMA_READ_SECTOR; // enable reading
      FDC_STATUS_DATA_REQUEST = 1;   // byte is ready

      /*
      // simula un settore non trovato
      if(FDC_track == 3 && FDC_sector == 6) {
         FDC_STATUS_BUSY = 0;
         FDC_STATUS_DATA_REQUEST = 0;
         FDC_STATUS_RNF = 1;
         FDC_INTREQ = 1;
         FDC_update_status(FDC_COMMAND_READ_SECTOR);
         return;
      }
      */

      FDC_update_status(FDC_COMMAND_READ_SECTOR);

      return;
   }

   // READ ADDRESS command
   if((cmd & 0b11111011) === 0b11000000) {
      // TODO E bit ignored
      //console.warn(`FDC READ ADDRESS track ${FDC_track} sec ${FDC_sector} with E=${E} @@@ ${cpu_status()}`);
      if(debug_read_address) console.log(`FDC READ ADDRESS track ${FDC_track} sec ${FDC_sector}`);

      // sector out of range
      if( ((FDC_sector<1 || FDC_sector>FDC_NSECTORS) && FLOPPY_8_INCHES) || (FDC_sector>=FDC_NSECTORS && !FLOPPY_8_INCHES)) {
         FDC_STATUS_RNF = 1;
         FDC_INTREQ = 1;
         FDC_STATUS_BUSY = 0;
         FDC_update_status(FDC_COMMAND_READ_ADDRESS);
         console.warn(`sector ${FDC_sector} out of range `);
         return;
      }

      FDC_STATUS_BUSY = 1;            // marks as busy
      FDC_sector_ptr = 0;             // starts sending first of 6 bytes
      FDC_dma = FDC_DMA_READ_ADDRESS; // enable reading
      FDC_STATUS_DATA_REQUEST = 1;    // byte is ready

      FDC_update_status(FDC_COMMAND_READ_ADDRESS);

      return;
   }

   // FORCE INTERRUPT command
   if((cmd & 0b11110000) === 0b11010000) {
      // TODO I3-I0 ignored
      FDC_STATUS_BUSY = 0;         // terminate any command
      FDC_dma = FDC_DMA_NONE;      // and any dma transfer
      FDC_STATUS_DATA_REQUEST = 0; //

      FDC_update_status(FDC_COMMAND_FORCE_INTERRUPT);

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

async function load_default_disks() {
   //if(!await fileExists("GP01_IMD.img")) await fetchProgramAll("GP01_IMD.img");
   //if(!await fileExists("GP02_IMD.img")) await fetchProgramAll("GP02_IMD.img");
   //if(!await fileExists("GP03_IMD.img")) await fetchProgramAll("GP03_IMD.img");
   //if(!await fileExists("GP04_IMD.img")) await fetchProgramAll("GP04_IMD.img");
   //if(!await fileExists("GP05_IMD.img")) await fetchProgramAll("GP05_IMD.img");
   //if(!await fileExists("GP06_IMD.img")) await fetchProgramAll("GP06_IMD.img");
   //if(!await fileExists("GP07_IMD.img")) await fetchProgramAll("GP07_IMD.img");
   //if(!await fileExists("GP08_IMD.img")) await fetchProgramAll("GP08_IMD.img");
   //if(!await fileExists("GP09_IMD.img")) await fetchProgramAll("GP09_IMD.img");
   //if(!await fileExists("GP10_IMD.img")) await fetchProgramAll("GP10_IMD.img");
   //if(!await fileExists("GP11_IMD.img")) await fetchProgramAll("GP11_IMD.img");
   //if(!await fileExists("GP12_IMD.img")) await fetchProgramAll("GP12_IMD.img");
   //if(!await fileExists("GP13_IMD.img")) await fetchProgramAll("GP13_IMD.img");
   //if(!await fileExists("GP14_IMD.img")) await fetchProgramAll("GP14_IMD.img");
   //if(!await fileExists("GP15_IMD.img")) await fetchProgramAll("GP15_IMD.img");
   //if(!await fileExists("GP16_IMD.img")) await fetchProgramAll("GP16_IMD.img");
   //if(!await fileExists("GP17_IMD.img")) await fetchProgramAll("GP17_IMD.img");
   //if(!await fileExists("GP18_IMD.img")) await fetchProgramAll("GP18_IMD.img");
   //if(!await fileExists("GP19_IMD.img")) await fetchProgramAll("GP19_IMD.img");
   //if(!await fileExists("GP20_IMD.img")) await fetchProgramAll("GP20_IMD.img");
   //if(!await fileExists("GP21_IMD.img")) await fetchProgramAll("GP21_IMD.img");
   //if(!await fileExists("GP22_IMD.img")) await fetchProgramAll("GP22_IMD.img");
   //if(!await fileExists("GP23_IMD.img")) await fetchProgramAll("GP23_IMD.img");

   if(FLOPPY_8_INCHES) {
      let disk1 = "GP16_IMD.img";
      let disk2 = "GP02_IMD.img";
      if(!(await load(disk1,1) && await load(disk2,2))) {
         dropdrive = 1; await fetchProgram(`disks/${disk1}`);
         dropdrive = 2; await fetchProgram(`disks/${disk2}`);
      }
   }
}

async function start_cpm() {
   paste("\nBD");
}

function dump_disk(side, track, sector) {
   let pos = FDC_getpos(side, track, sector);
   let bytes = drives[0].floppy.slice(pos,pos+128);
   //bytes = bytes.map(b=>~b & 0xFF);
   dumpBytes(bytes, 0, 127);
}

