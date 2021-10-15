
/*
let log_counter = 0;
function log(msg) {
   if(log_counter < 4096) console.log(msg);
   else if(log_counter == 4096) console.log("logging stopped");
   log_counter++;
}
*/

// =====================================================================================
/*

CPU HOST INTERFACE, values negated (ON=0, OFF=1)

port $6D: DATA BIT I/O (negated)

port $6C write (controller input)
==================
-
ACK    ON=cpu is sending byte on the BUS, or acknowledge the REQ from controller
RST
-
SEL    selects the controller interface
-
-
-

port $6c read (controller output):
===================
0 BSY   ** VERIFICATO ** ON=controller owns the bus, CPU must deassert SEL
1 -     (some error?)
2 -
3 MSG   ON=status byte transferred.
4 -
5 CD    ON=trasmit of status bytes; OFF=transmito of data bytes
6 REQ   ON=request to send to CPU; byte is on the bus, waiting for ACK
7 IO    ON=data from controller to CPU; OFF=CPU to controller


STATUS BYTE
===========
0  PARITY ERROR
1  ERROR
2
3
4
5  LUN
6  LUN
7


5.1 CONTROLLER SELECTION SEQUENCE (CONTROLLER SIDE)

1) BSY is normally 0                               ; after reset
2) wait for SEL==1 && ((DATA_IN & 1) == 1)         ; cpu selects controller
3) BSY = 1;                                        ; controller responds with busy
4) wait for SEL==0 && ((DATA_IN & 1) == 0)         ; cpu acknowledge the selection complete
5) selection is now complete

5.2 COMMAND TRANSFER SEQUENCE (CONTROLLER SIDE)

1) controller must me selected
2) REQ = 1;                                        ; controller requires a command after select
3) wait for ACK==1
4) read the data byte in DATA_IN                   ; bytes of command_descriptor_block[i]
5) REQ = 0;
6) wait for ACK==0
7) repeat to step 1 collecting all the bytes

5.3 DATA TRANSFER SEQUENCE (CONTROLLER SIDE)



CLASS 0 COMMANDS
00 TEST DRIVE READY
01 RECALIBRATE (SEEK TO 0)
02 REQUEST SYNDROM (for error correction)
03 REQUEST SENSE
04 FORMAT DRIVE
05 CHECK DRIVE FORMAT
06 FORMAT TRACK
07 FORMAT BAD TRACK
08 READ SECTORS
09 ?
0A WRITE SECTORS
0B SEEK

CLASS 1 COMMANDS
(not implemented)

CLASS 7 COMMANDS
00 RAM DIAGNOSTIC
01 WRITE ECC
02 READ SECTOR ID
03 DIAGNOSTIC
*/

let HDC_MEDIA_SIZE = 256 * 256 * 32 * 4;
let FHDC_MEDIA_SIZE = 32 * 256 * 77 * 2;

class HardDisk {
   constructor(image, size) {
      this.image = image === undefined ? new Uint8Array(size).fill(0xE5) : this.resize(image, size);
   }

   resize(image, size) {
      const new_image = new Uint8Array(size);
      image.forEach((e,i)=>new_image[i]=e);
      return new_image;
   }
}

class SASI_CONTROLLER {
   constructor() {
      this.SASI_reset();

      // TODO all timeouts
      this.sa_ticks = 0;

      // the actual hard disks
      this.hard_disks = [
         new HardDisk(undefined, HDC_MEDIA_SIZE),
         new HardDisk(undefined, FHDC_MEDIA_SIZE),
         new HardDisk(undefined, HDC_MEDIA_SIZE),
         new HardDisk(undefined, HDC_MEDIA_SIZE)
      ];
   }

   lun_to_id(byte) {
      let LUN = (byte >> 5) & 0b011;

           if(LUN==1) return 0;
      else if(LUN==0) return 1;
      else if(LUN==2) return 2;
      else if(LUN==3) return 3;
   }

   SASI_reset() {
      this.STATE = "UNKNOWN";

      this.DATA_IN  = 0;        // data byte from CPU to SA
      this.DATA_OUT = 0;        // data byte from SA to CPU

      // output pins from SA to CPU
      this.BSY = 0;
      this.CD  = 0;
      this.REQ = 0;
      this.IO  = 0;
      this.MSG = 0;

      // input pins from CPU to SA
      this.ACK = 0;
      this.RST = 0;
      this.SEL = 0;

      // command
      this.COMMAND = [];
      this.pos = 0;
      this.lun = 0;
      this.counter = 0;
   }

   SA_tick() {
      this.sa_ticks++;

      let oldstate = this.STATE;

      if(this.RST) {
         this.BSY = 0;
         this.MSG = 0;
         this.CD  = 0;
         this.REQ = 0;
         this.IO  = 0;
         this.COMMAND = [];
         //log("SA1400: performed RESET");

         this.STATE = "UNSELECTED";
      }
      else if(this.STATE == "UNKNOWN") {
         // unknown state
      }
      else if(this.STATE == "UNSELECTED") {
         this.BSY = 0;
         this.MSG = 0;
         this.CD  = 0;
         this.REQ = 0;
         this.IO  = 0;
         this.COMMAND = [];

         // cpu starts the selection procedure
         if(this.SEL==1) {
            // TODO: why does not GP set D0=1 as required in SASI protocol?
            this.STATE = "SELECTED";
         }
      }
      else if(this.STATE == "SELECTED") {
         // controller requests a command
         this.BSY = 1;   // busy
         this.MSG = 0;   // no message
         this.CD  = 1;   // byte is control data
         this.REQ = 1;   //
         this.IO  = 0;   // bytes from host to contrller
         this.STATE = "SELECTED.1";
      }
      else if(this.STATE == "SELECTED.1") {
         this.BSY = 1;   // busy
         this.MSG = 0;   // no message
         this.CD  = 1;   // byte is control data
         this.REQ = 1;   // request a command byte
         this.IO  = 0;   // bytes from host to contrller

         // cpu sends a data byte
         if(this.ACK == 1) {
            this.COMMAND.push(this.DATA_IN);
            //console.log(`----------> data byte received: ${this.DATA_IN}`);
            this.STATE = "SELECTED.2";
         }
      }
      else if(this.STATE == "SELECTED.2") {
         // waits for ACK to be deasserted by the cpu
         if(this.ACK == 0) {
            let command       = this.COMMAND.length > 0 ? this.COMMAND[0] & 0b11111 : -1;
            let command_class = this.COMMAND.length > 0 ? this.COMMAND[0] >> 5 : -1;

            if(this.COMMAND.length == 6 && (command_class==0)) {
               // parse class 0 commands
               if(command == 0) {
                  // test drive (no op)
                  //log("SA1400: performed COMMAND TEST DRIVE");

                  this.STATE = "STATUS_BYTE";
               }
               else if(command == 1) {
                  // recalibrate
                  emulator.stopped = true;
                  throw `command ${command} not handled`;
               }
               else if(command == 2) {
                  // request syndrome
                  emulator.stopped = true;
                  throw `command ${command} not handled`;
               }
               else if(command == 3) {
                  // request sense
                  emulator.stopped = true;
                  throw `command ${command} not handled`;
               }
               else if(command == 4) {
                  // format drive
                  this.STATE = "FORMAT_DRIVE";
               }
               else if(command == 5) {
                  // check track format
                  emulator.stopped = true;
                  throw `command ${command} not handled`;
               }
               else if(command == 6) {
                  // format track
                  emulator.stopped = true;
                  throw `command ${command} not handled`;
               }
               else if(command == 7) {
                  // format bad track
                  emulator.stopped = true;
                  throw `command ${command} not handled`;
               }
               else if(command == 8) {
                  // read command
                  let addr = (this.COMMAND[3] << 0) | (this.COMMAND[2] << 8) | ((this.COMMAND[1] & 0b11111) << 16);
                  let nblocks = this.COMMAND[4];

                  this.lun     = this.lun_to_id(this.COMMAND[1]);
                  this.counter = nblocks * 256;
                  this.pos     = addr * 256;

                  this.STATE = "READ_SECTOR";

                  //console.log(`SA1400: reading sector ${addr}`);
               }
               else if(command == 0x0a) {
                  // write command
                  let addr = (this.COMMAND[3] << 0) | (this.COMMAND[2] << 8) | ((this.COMMAND[1] & 0b11111) << 16);
                  let nblocks = this.COMMAND[4];

                  this.lun     = this.lun_to_id(this.COMMAND[1]);
                  this.counter = nblocks * 256;
                  this.pos     = addr * 256;

                  this.STATE = "WRITE_SECTOR";

                  //console.log(`SA1400: writing sector ${addr}`);
               }
               else if(command == 0x0b) {
                  // seek
                  emulator.stopped = true;
                  throw `command ${command} not handled`;
               }
               else {
                  emulator.stopped = true;
                  throw `class 0 command ${command} not handled`;
               }
            }
            else if(this.COMMAND.length == 6 && (command_class==7)) {
               emulator.stopped = true;
               throw `class 7 commands not handled`;
            }
            else if(this.COMMAND.length == 10 && command_class == 1) {
               if(command == 0) {
                  // copy blocks
                  let nblocks = this.COMMAND[4];

                  let addrs = (this.COMMAND[3] << 0) | (this.COMMAND[2] << 8) | ((this.COMMAND[1] & 0b11111) << 16);
                  let addrd = (this.COMMAND[7] << 0) | (this.COMMAND[6] << 8) | ((this.COMMAND[5] & 0b11111) << 16);

                  let luns   = this.lun_to_id(this.COMMAND[1]);
                  let lund   = this.lun_to_id(this.COMMAND[5]);

                  // do the actual copy
                  for(let i=0;i<nblocks*256;i++) {
                     this.hard_disks[lund].image[addrd*256+i] = this.hard_disks[luns].image[addrs*256+i];
                  }

                  //console.log(`copying block DSK=${luns} SEC=${addrs} => DSK=${lund} SEC=${addrd} (${nblocks} blocks)`);

                  this.STATE = "STATUS_BYTE";
               }
               else {
                  emulator.stopped = true;
                  throw `class 1 command ${command} not handled`;
               }
            }
            else {
               // command not completed yet, get next byte
               this.STATE = "SELECTED";
            }
         }
      }
      else if(this.STATE == "STATUS_BYTE") {
         this.BSY = 1;
         this.MSG = 0;
         this.REQ = 1;      // controller wants to send the status byte
         this.CD  = 1;      // the data type is a control data
         this.IO  = 1;      // the data is input for the CPU
         this.DATA_OUT = 0; // status byte (no error)

         // status byte is received from the cpu
         if(this.ACK == 1) {
            this.STATE = "STATUS_BYTE.1";
         }
      }
      else if(this.STATE == "STATUS_BYTE.1") {
         // waits until cpu finish reading
         if(this.ACK == 0) {
            this.STATE = "MESSAGE";
         }
      }
      else if(this.STATE == "MESSAGE") {
         // a end of message byte is sent from controller on the bus
         this.BSY = 1;
         this.MSG = 1;      // this is the message
         this.CD  = 1;      // the data type is a control data
         this.REQ = 1;      // controller wants to send the status byte
         this.IO  = 1;      // the data is input for the CPU
         this.DATA_OUT = 0; // zero message

         if(this.ACK == 1) {
            this.STATE = "MESSAGE.1";
         }
      }
      else if(this.STATE == "MESSAGE.1") {
         if(this.ACK == 0) {
            this.STATE = "UNSELECTED";
         }
      }
      else if(this.STATE == "READ_SECTOR") {
         // byte is sent from controller to the bus
         if(this.ACK == 0) {
            let byte = this.hard_disks[this.lun].image[this.pos];
            this.BSY = 1;
            this.MSG = 0;
            this.CD  = 0;               // the data type is data
            this.REQ = 1;               // controller wants to send the first byte
            this.IO  = 1;               // the data is input for the CPU
            this.DATA_OUT = byte;
            this.STATE = "READ_SECTOR.1";
         }
      }
      else if(this.STATE == "READ_SECTOR.1") {
         // byte is sent from controller to the bus
         if(this.ACK == 1) {
            this.BSY = 1;
            this.MSG = 0;
            this.CD  = 0;
            this.REQ = 0;
            this.IO  = 1;
            this.pos++;
            this.counter--;
            //console.log(`remaining in buffer ${this.counter}`);
            if(this.counter == 0) {
               this.REQ = 1;      // controller wants to send the status byte
               this.CD  = 1;      // the data type is a control data
               this.IO  = 1;      // the data is input for the CPU
               this.DATA_OUT = 0; // status byte (no error)
               this.STATE = "STATUS_BYTE";
            }
            else this.STATE = "READ_SECTOR";
         }
      }
      else if(this.STATE == "WRITE_SECTOR") {
         // byte is sent from cpu controller on the bus
         this.BSY = 1;
         this.MSG = 0;
         this.IO  = 0;               // the data is input for the CPU
         this.CD  = 0;               // the data type is data
         if(this.ACK == 1) {
            // write byte on disk
            let byte = this.DATA_IN;
            this.hard_disks[this.lun].image[this.pos] = byte;
            this.BSY = 1;
            this.MSG = 0;
            this.CD  = 0;               // the data type is data
            this.REQ = 1;               // controller wants to send the first byte
            this.IO  = 0;               // the data is input for the CPU
            this.DATA_OUT = byte;
            this.STATE = "WRITE_SECTOR.1";
         }
      }
      else if(this.STATE == "WRITE_SECTOR.1") {
         // byte is sent from cpu to controller
         if(this.ACK == 0) {
            this.BSY = 1;
            this.MSG = 0;
            this.CD  = 0;
            this.REQ = 1;
            this.IO  = 0;
            this.pos++;
            this.counter--;
            //console.log(`remaining in buffer ${this.counter}`);
            if(this.counter == 0) {
               this.REQ = 1;      // controller wants to send the status byte
               this.CD  = 1;      // the data type is a control data
               this.IO  = 1;      // the data is input for the CPU
               this.DATA_OUT = 0; // status byte (no error)
               this.STATE = "STATUS_BYTE";
            }
            else this.STATE = "WRITE_SECTOR";
         }
      }
      else if(this.STATE == "FORMAT_DRIVE") {
         let interleave = this.COMMAND[4];
         this.lun = this.lun_to_id(this.COMMAND[1]);

         console.log(`formatting drive ${this.lun} with interleave=${interleave}`);

         // wipe all
         this.hard_disks[this.lun].image.forEach((e,i)=>this.hard_disks[this.lun].image[i] = 0x6C);

         this.STATE = "STATUS_BYTE";
      }
      else throw `state "${this.STATE} not handled"`;

      if(oldstate != this.STATE) {
         //log(`SA state changed to: ${this.STATE}`);
      }
   }

   SASI_read_data() {
      this.SA_tick();
      let data = this.DATA_OUT;
      this.ACK = 1;
      //log(`pins write ACK=${this.ACK}`);
      this.SA_tick();
      this.ACK = 0;
      //log(`pins write ACK=${this.ACK}`);
      this.SA_tick();
      return data;
   }

   SASI_write_data(value) {
      this.DATA_IN = value;
      //log(`==================> data write ${hex(value)}`);
      //log(cpu_status());
      this.SA_tick();
      this.ACK = 1;
      //log(`pins write ACK=${this.ACK}`);
      this.SA_tick();
      this.ACK = 0;
      //log(`pins write ACK=${this.ACK}`);
      this.SA_tick();
      this.SA_tick();
   }

   SASI_read_pins() {
      this.SA_tick();
      this.SA_tick();

      let PINS_OUT =
         (this.BSY << 0) |
         (this.MSG << 1) |
         (this.CD  << 2) |
         (this.REQ << 3) |
         (this.IO  << 4) ;      // IO=1 data from controller to CPU

      /*
      let pins = [];
      if(this.BSY) pins.push("BSY");
      if(this.CD)  pins.push("CD");
      if(this.REQ) pins.push("REQ");
      if(this.IO)  pins.push("IO");
      if(this.MSG) pins.push("MSG");
      */

      //log(`read pins ${pins.join(" ")} ($${hex(PINS_OUT)})`);
      //log(cpu_status());
      return PINS_OUT;
   }

   SASI_write_pins(value) {

      let oldsel = this.SEL;

      //this.ACK = (value >> 9) & 1 ;
      this.SEL = (value >> 1) & 1 ;
      this.RST = (value >> 2) & 1 ;

      //log(`pins write ACK=${this.ACK} RST=${this.RST} SEL=${this.SEL} value=0b${value.toString(2)}`);

      //if(oldsel != this.SEL) log(`------- SEL changed to SEL=${this.SEL}`);

      this.SA_tick();
      this.SA_tick();
      this.SA_tick();

      this.SEL = 0 ;
      this.RST = 0 ;

      this.SA_tick();
      this.SA_tick();
      this.SA_tick();
   }
}

