import { hex } from "./utils";

// which type of DMA is currently executing
const FDC_DMA_NONE         = 0;
const FDC_DMA_READ_ADDRESS = 1;
const FDC_DMA_READ_SECTOR  = 2;
const FDC_DMA_WRITE_SECTOR = 3;
const FDC_DMA_READ_TRACK   = 3;
const FDC_DMA_WRITE_TRACK  = 4;

// commands
const FDC_COMMAND_TYPE_I          = 0;
const FDC_COMMAND_READ_ADDRESS    = 1;
const FDC_COMMAND_READ_SECTOR     = 2;
const FDC_COMMAND_READ_TRACK      = 3;
const FDC_COMMAND_WRITE_SECTOR    = 4;
const FDC_COMMAND_WRITE_TRACK     = 5;
const FDC_COMMAND_FORCE_INTERRUPT = 6;

// 3f interface outside registers
let FDC_drive_number = 2;        // selected drive number
let FDC_side = 0;                // selected side

// 1791 internal registers
let FDC_track = 0;               // selected track
let FDC_sector = 0;              // selected sector
let FDC_data = 0;                // I/O data byte
let FDC_status_byte = 0;         // controller status byte
let FDC_sector_ptr = 0;          // pointer within the sector
let FDC_dma_op = FDC_DMA_NONE;   // dma operation being executed

// 1791 service pins
let FDC_HLD      = 0;
let FDC_INTREQ   = 0;

// status register bits which are assembled to form a status byte; depend on command type
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

let FDC_side_descs = [ "S0", "S1" ];
let FDC_drive_number_descs = [ "0 (LEFT)", "1 (RIGHT)", "D2", "D3" ];

let warnings = 0;
function warn(msg: string) {
   warnings++;
   if(warnings < 10000) {
      console.log(msg);
   }
}
// *************************************************************************************

// WD1791 floppy disk controller
class WD7191 {
   FLOPPY_8_INCHES: boolean;

   // flags to debug all disk activity
   debug_write_track      : boolean = false;
   debug_read_track       : boolean = false;
   debug_write_sector     : boolean = false;
   debug_write_sector_dma : boolean = false;
   debug_read_sector      : boolean = false;
   debug_read_sector_dma  : boolean = false;
   debug_read_address     : boolean = false;
   debug_read_address_dma : boolean = false;
   debug_read_status      : boolean = false;
   debug_read_3f          : boolean = false;

   FDC_NSIDES: number;
   FDC_NTRACKS: number;
   FDC_NSECTORS: number;
   FDC_SECTORSIZE: number;
   FDC_FIRSTSECTOR: number;
   FDC_MEDIA_SIZE: number;

   drives: Drive[];   // the actual floppy disks inserted in the drives

   constructor(FLOPPY_8_INCHES: boolean) {
      this.FLOPPY_8_INCHES = FLOPPY_8_INCHES;

      this.FDC_NSIDES      = FLOPPY_8_INCHES ? 2   : 2;
      this.FDC_NTRACKS     = FLOPPY_8_INCHES ? 77  : 40;
      this.FDC_NSECTORS    = FLOPPY_8_INCHES ? 26  : 17;     // 18 on the "new" format
      this.FDC_SECTORSIZE  = FLOPPY_8_INCHES ? 128 : 128;
      this.FDC_FIRSTSECTOR = FLOPPY_8_INCHES ? 1   : 0;

      this.FDC_MEDIA_SIZE  = this.FDC_SECTORSIZE * this.FDC_NSECTORS * this.FDC_NSIDES * this.FDC_NTRACKS;

      this.drives = [ new Drive(this.FDC_MEDIA_SIZE), new Drive(this.FDC_MEDIA_SIZE) ];
   }

   // data is assumed to be stored on the media:
   // track 0 side 0 [ sectors 0-26 ], track 0 side 1 [ sectors 0-26 ], ...

   FDC_getpos(side: number, track: number, sector: number) {

      let sec = sector - this.FDC_FIRSTSECTOR;

      if(sec<0) {
         console.warn(`sector ${sec}`)
         sec=0;
      }

      let sid = side == 0 ? 0 : 1;

      let pos = track * this.FDC_NSIDES * this.FDC_SECTORSIZE * this.FDC_NSECTORS;
      pos += sid * this.FDC_SECTORSIZE * this.FDC_NSECTORS;
      pos += sec * this.FDC_SECTORSIZE;

      return pos;
   }

   FDC_read_port_3f(): number {
      let byte = (FDC_drive_number        << 0)  |
                 (FDC_side                << 3)  |
                 (FDC_HLD                 << 5)  |
                 (FDC_INTREQ              << 6)  |
                 (FDC_STATUS_DATA_REQUEST << 7);

      if(this.debug_read_3f) console.log(`read from drive select: ret=${hex(byte)}h drive number=${FDC_drive_number} side=${FDC_side} INTREQ=${FDC_INTREQ} DATAREQ=${FDC_STATUS_DATA_REQUEST}`);

      return byte;
   }

   FDC_write_port_3f(value: number): void {
      let DR_SEL_0 = (value & 0b001) >> 0;
      let DR_SEL_1 = (value & 0b010) >> 1;
      let DR_SEL_2 = (value & 0b100) >> 2;
      let side = (value & 0b1000) >> 3;

      //console.log(`DR_SEL_0=${DR_SEL_0} DR_SEL_1=${DR_SEL_1} DR_SEL_2=${DR_SEL_2}`);

      // DDEN is supported only on the 5.25 machine
      // let DDEN = (value >> 6) & 1;
      // console.log(`*************** ${DDEN}`);

      //if(drive_number != FDC_drive_number) console.log(`**** drive number changed to "${FDC_drive_number_descs[drive_number]}"`);
      //if(side != FDC_side) console.log(`**** side changed to "${FDC_side_descs[side]}"`);

      FDC_drive_number = DR_SEL_0 ? 0 : DR_SEL_1 ? 1 : DR_SEL_2 ? 2 : 2;
      FDC_side = side;

      //console.log(`write to drive select: drive number=${FDC_drive_number} side=${FDC_side} ${cpu_status()}`);
      //console.log(`drive select: drive number=${FDC_drive_number} side=${FDC_side}`);
   }

   FDC_read(port: number): number {
      switch(port) {
         case 0x00:
            // read status register
            FDC_INTREQ = 0;  // reading the status registers clears INTREQ
            if(this.debug_read_status) console.log(`read FDC status = ${hex(FDC_status_byte)}h`);
            return FDC_status_byte;

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

            let drvn = FDC_drive_number;

            let pos = this.FDC_getpos(side, FDC_track, FDC_sector) + FDC_sector_ptr;

            // read sector transfer
            if(FDC_dma_op === FDC_DMA_READ_SECTOR) {

               if(this.debug_read_sector_dma && FDC_sector_ptr == 0)   console.log(`sector start read`);
               if(this.debug_read_sector_dma && FDC_sector_ptr == 127) console.log(`sector end read`);

               //if(FDC_sector_ptr == 0) console.log(`sector start read drvn=${drvn} pos=${pos}`);

               if(pos>this.drives[drvn].floppy.length-1) {
                  console.warn(`read beyond disk`);
               }
               FDC_data = this.drives[drvn].floppy[pos];
               FDC_sector_ptr++;

               if(FDC_sector_ptr < this.FDC_SECTORSIZE) {
                  FDC_STATUS_DATA_REQUEST = 1;   // there is still data to read
                  FDC_STATUS_BUSY = 1;           // and we are still busy
               }
               else {
                  FDC_STATUS_DATA_REQUEST = 0;    // no more data
                  FDC_STATUS_BUSY = 0;            // we are no longer busy
                  FDC_INTREQ      = 1;            // and the READ command terminated
                  FDC_dma_op = FDC_DMA_NONE;         // reading ended
               }
               this.FDC_update_status(FDC_COMMAND_READ_SECTOR);
            }
            // read address transfer
            else if(FDC_dma_op === FDC_DMA_READ_ADDRESS) {
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
                  FDC_dma_op = FDC_DMA_NONE;         // reading ended
                  FDC_sector = FDC_track;         // track address goes into sector register (data sheet page 13)
               }
               this.FDC_update_status(FDC_COMMAND_READ_ADDRESS);

               if(this.debug_read_address_dma) console.log(`read FDC READ ADDRESS byte index=${FDC_sector_ptr-1} data=${hex(FDC_data)}h`);
            }

            return FDC_data;

         default:
            throw "wrong FDC port";
      }
   }

   FDC_write(port: number, value: number): void {
      switch(port) {
         case 0x00:
            // command port
            FDC_INTREQ = 0;      // writing to command registers clears INTREQ

            // parse commands
            //console.warn(`DC command ${hex(value)}h`);
            this.FDC_parse_command(value);
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
            let drvn = FDC_drive_number;

            // write sector transfer
            if(FDC_dma_op === FDC_DMA_WRITE_SECTOR) {
               let pos = this.FDC_getpos(side, FDC_track, FDC_sector) + FDC_sector_ptr;

               if(this.debug_write_sector_dma && FDC_sector_ptr == 0)                       console.log(`sector start write`);
               if(this.debug_write_sector_dma && FDC_sector_ptr == this.FDC_SECTORSIZE - 1) console.log(`sector end write`);

               if(pos > this.drives[drvn].floppy.length-1) {
                  console.warn(`write beyond disk`);
               }
               this.drives[drvn].floppy[pos] = FDC_data;
               FDC_sector_ptr++;

               if(FDC_sector_ptr < this.FDC_SECTORSIZE) {
                  FDC_STATUS_DATA_REQUEST = 1;   // there is still data to write
                  FDC_STATUS_BUSY = 1;           // and we are still busy
               }
               else {
                  FDC_STATUS_DATA_REQUEST = 0;    // no more data
                  FDC_STATUS_BUSY = 0;            // we are no longer busy
                  FDC_INTREQ      = 1;            // and the READ command terminated
                  FDC_dma_op = FDC_DMA_NONE;         // reading ended
               }
               this.FDC_update_status(FDC_COMMAND_WRITE_SECTOR);
            }
            else if(FDC_dma_op === FDC_DMA_WRITE_TRACK) {
               let pos = this.FDC_getpos(side, FDC_track, 1) + FDC_sector_ptr;

               if(this.debug_write_sector_dma && FDC_sector_ptr == 0)                                           console.log(`track start write`);
               if(this.debug_write_sector_dma && FDC_sector_ptr == this.FDC_NSECTORS * this.FDC_SECTORSIZE - 1) console.log(`track end write`);

               if(pos > this.drives[drvn].floppy.length-1) {
                  console.warn(`write beyond disk`);
               }
               this.drives[drvn].floppy[pos] = FDC_data;
               FDC_sector_ptr++;

               if(FDC_sector_ptr < this.FDC_NSECTORS * this.FDC_SECTORSIZE) {
                  FDC_STATUS_DATA_REQUEST = 1;   // there is still data to write
                  FDC_STATUS_BUSY = 1;           // and we are still busy
               }
               else {
                  FDC_STATUS_DATA_REQUEST = 0;    // no more data
                  FDC_STATUS_BUSY = 0;            // we are no longer busy
                  FDC_INTREQ      = 1;            // and the READ command terminated
                  FDC_dma_op = FDC_DMA_NONE;      // reading ended
               }
               this.FDC_update_status(FDC_COMMAND_WRITE_TRACK);
            }
            return;
      }
   }

   // updates the status register as documented in table 6
   // page 26 of the data sheet
   FDC_update_status(command: number) {
      // column is the datasheet table 6 column index 0..5

      // automatically updates the track 0 bit
      FDC_STATUS_TRACK_0 = FDC_track === 0 ? 1 : 0;

      if(command === FDC_COMMAND_TYPE_I) {
         // type I commands
         FDC_status_byte =
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
         FDC_status_byte =
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
         FDC_status_byte =
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
         FDC_status_byte =
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
         FDC_status_byte =
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
         FDC_status_byte =
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
         FDC_status_byte =
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

   FDC_parse_command(cmd: number) {

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

         this.FDC_update_status(FDC_COMMAND_TYPE_I);
         return;
      }

      // SEEK command
      if((cmd >> 4) === 0b0001) {
         // TODO V,h bits ignored
         //console.log(`FDC SEEK from track ${FDC_track} to ${FDC_data} with V=${V} h=${h} @@@ ${cpu_status()}`);
         //console.log(`FDC SEEK from track ${FDC_track} to ${FDC_data}`);

         FDC_track = FDC_data;      // does the seek from current track to desidered track

         if(FDC_track >= this.FDC_NTRACKS) {
            FDC_STATUS_SEEK_ERROR = 1;   // track out of range
            console.warn(`track ${FDC_track} out of range `);
         }

         FDC_INTREQ = 1;            // command terminated
         FDC_STATUS_BUSY = 0;       // no longer busy

         this.FDC_update_status(FDC_COMMAND_TYPE_I);
         return;
      }

      // STEP IN command
      if((cmd & 0b11100000) === 0b01000000) {
         // TODO V,h bits ignored
         //console.log(`FDC STEP IN at track ${FDC_track}`);

         if(u === 1) FDC_track++    // increment track register if u bit is 1

         if(FDC_track >= this.FDC_NTRACKS) {
            FDC_STATUS_SEEK_ERROR = 1;   // track out of range
            console.warn(`track ${FDC_track} out of range `);
         }

         FDC_INTREQ = 1;            // command terminated
         FDC_STATUS_BUSY = 0;       // no longer busy

         this.FDC_update_status(FDC_COMMAND_TYPE_I);
         return;
      }

      // WRITE SECTOR command
      if((cmd & 0b11100000) === 0b10100000) {
         // TODO m,F1,F2,E,a0 bits ignored
         //console.log(`FDC READ SECTOR track ${FDC_track} sec ${FDC_sector} with m=${m} S=${S} C=${C} E=${E} @@@ ${cpu_status()}`);
         //if(wd1791.debug_write_sector) console.log(`FDC WRITE SECTOR track ${FDC_track} sec ${FDC_sector} drive=${FDC_drive_number_descs[FDC_drive_number]} side=${FDC_side_descs[FDC_side]}`);

         // if(this.debug_write_sector) console.log(`FDC WRITE SECTOR track ${FDC_track} sec ${FDC_sector} drive=${FDC_drive_number_descs[FDC_drive_number]} side=${FDC_side_descs[FDC_side]} t=${mem_read(0xbfda)} s=${mem_read(0xBFDB)}`);
         if(this.debug_write_sector) console.log(`FDC WRITE SECTOR track ${FDC_track} sec ${FDC_sector} drive=${FDC_drive_number_descs[FDC_drive_number]} side=${FDC_side_descs[FDC_side]}`);

         // sector out of range
         //if( ((FDC_sector<1 || FDC_sector>FDC_NSECTORS) && FLOPPY_8_INCHES) || (FDC_sector>=FDC_NSECTORS && !FLOPPY_8_INCHES)) {
         if(FDC_sector<this.FDC_FIRSTSECTOR || FDC_sector>=(this.FDC_NSECTORS+this.FDC_FIRSTSECTOR)) {
            FDC_STATUS_RNF = 1;
            FDC_INTREQ = 1;
            FDC_STATUS_BUSY = 0;
            this.FDC_update_status(FDC_COMMAND_WRITE_SECTOR);
            console.warn(`sector ${FDC_sector} out of range in write sector`);
            return;
         }

         FDC_STATUS_BUSY = 1;            // marks as busy
         FDC_sector_ptr = 0;             // starts writing from byte 0
         FDC_dma_op = FDC_DMA_WRITE_SECTOR; // enable writing
         FDC_STATUS_DATA_REQUEST = 1;    // asks for a byte to be sent
         this.FDC_update_status(FDC_COMMAND_WRITE_SECTOR);

         return;
      }

      // WRITE TRACK command
      if((cmd & 0b11110000) === 0b11110000) {
         // TODO m,F1,F2,E,a0 bits ignored
         //console.log(`FDC READ SECTOR track ${FDC_track} sec ${FDC_sector} with m=${m} S=${S} C=${C} E=${E} @@@ ${cpu_status()}`);
         if(this.debug_write_track) console.log(`FDC WRITE TRACK track ${FDC_track}`);

         // TODO gestire errore

         FDC_STATUS_BUSY = 1;            // marks as busy
         FDC_sector_ptr = 0;             // starts writing from byte 0
         FDC_dma_op = FDC_DMA_WRITE_TRACK;  // enable writing
         FDC_STATUS_DATA_REQUEST = 1;    // asks for a byte to be sent

         this.FDC_update_status(FDC_COMMAND_WRITE_TRACK);

         return;
      }

      // READ SECTOR command
      if((cmd & 0b11100001) === 0b10000000) {
         // TODO m,F1,F2,E bits ignored
         //console.log(`FDC READ SECTOR track ${FDC_track} sec ${FDC_sector} with m=${m} S=${S} C=${C} E=${E} @@@ ${cpu_status()}`);
         if(this.debug_read_sector) console.log(`FDC READ SECTOR track ${FDC_track} sec ${FDC_sector} drive=${FDC_drive_number_descs[FDC_drive_number]} side=${FDC_side_descs[FDC_side]}`);

         // sector out of range TODO write function for checking
         //if( ((FDC_sector<1 || FDC_sector>FDC_NSECTORS) && FLOPPY_8_INCHES) || (FDC_sector>=FDC_NSECTORS && !FLOPPY_8_INCHES)) {
         if(FDC_sector < this.FDC_FIRSTSECTOR || FDC_sector >= (this.FDC_NSECTORS + this.FDC_FIRSTSECTOR)) {
            FDC_STATUS_RNF = 1;
            FDC_INTREQ = 1;
            FDC_STATUS_BUSY = 0;
            this.FDC_update_status(FDC_COMMAND_READ_SECTOR);
            console.warn(`sector ${FDC_sector} out of range in read sector`);
            return;
         }

         FDC_STATUS_BUSY = 1;           // marks as busy
         FDC_sector_ptr = 0;            // starts reading from byte 0
         FDC_dma_op = FDC_DMA_READ_SECTOR; // enable reading
         FDC_STATUS_DATA_REQUEST = 1;   // byte is ready

         // // simula un settore non trovato
         // if(FDC_track == 3 && FDC_sector == 6) {
         //    FDC_STATUS_BUSY = 0;
         //    FDC_STATUS_DATA_REQUEST = 0;
         //    FDC_STATUS_RNF = 1;
         //    FDC_INTREQ = 1;
         //    FDC_update_status(FDC_COMMAND_READ_SECTOR);
         //    return;
         // }

         this.FDC_update_status(FDC_COMMAND_READ_SECTOR);
         return;
      }

      // READ ADDRESS command
      if((cmd & 0b11111011) === 0b11000000) {
         // TODO E bit ignored
         //console.warn(`FDC READ ADDRESS track ${FDC_track} sec ${FDC_sector} with E=${E} @@@ ${cpu_status()}`);
         if(this.debug_read_address) console.log(`FDC READ ADDRESS track ${FDC_track} sec ${FDC_sector}`);

         // sector out of range
         // check disabled to make it work with T20

         // if(FDC_sector<FDC_FIRSTSECTOR || FDC_sector>=(FDC_NSECTORS+FDC_FIRSTSECTOR)) {
         //    FDC_STATUS_RNF = 1;
         //    FDC_INTREQ = 1;
         //    FDC_STATUS_BUSY = 0;
         //    FDC_update_status(FDC_COMMAND_READ_ADDRESS);
         //    console.warn(`sector ${FDC_sector} out of range in read address`);
         //    return;
         // }

         FDC_STATUS_BUSY = 1;            // marks as busy
         FDC_sector_ptr = 0;             // starts sending first of 6 bytes
         FDC_dma_op = FDC_DMA_READ_ADDRESS; // enable reading
         FDC_STATUS_DATA_REQUEST = 1;    // byte is ready

         this.FDC_update_status(FDC_COMMAND_READ_ADDRESS);
         return;
      }

      // FORCE INTERRUPT command
      if((cmd & 0b11110000) === 0b11010000) {
         // TODO I3-I0 ignored
         FDC_STATUS_BUSY = 0;         // terminate any command
         FDC_dma_op = FDC_DMA_NONE;      // and any dma transfer
         FDC_STATUS_DATA_REQUEST = 0; //

         this.FDC_update_status(FDC_COMMAND_FORCE_INTERRUPT);
         return;
      }

      console.warn(`unknown FDC command ${hex(cmd)}h`);
   }
}

class Drive {
   floppy: Uint8Array;

   constructor(size: number) {
      this.floppy = new Uint8Array(size);
   }
}

/*
class Drive {
   floppy: Uint8Array;

   constructor(image?: Uint8Array) {
      this.floppy = image === undefined ? new Uint8Array(wd1791.FDC_MEDIA_SIZE) : this.resize(image);
   }

   resize(image: Uint8Array) {
      const new_image = new Uint8Array(wd1791.FDC_MEDIA_SIZE);
      image.forEach((e,i)=>new_image[i]=e);
      return new_image;
   }
}
*/

/*
function dump_disk(side, track, sector) {
   let pos = wd1791.FDC_getpos(side, track, sector);
   let bytes = drives[0].floppy.slice(pos,pos+128);
   //bytes = bytes.map(b=>~b & 0xFF);
   dumpBytes(bytes, 0, 127);
}
*/

export { WD7191 };
