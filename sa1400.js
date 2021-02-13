
let SA;

let log_counter = 0;
function log(msg) {
   if(log_counter < 4096) console.log(msg);
   else if(log_counter == 4096) console.log("logging stopped");
   log_counter++;
}

function SASI_reset() {
   SA = {
      STATE:    "UNKNOWN",

      DATA_IN:  0,        // data byte from CPU to SA
      DATA_OUT: 0,        // data byte from SA to CPU

      // output pins from SA to CPU
      BSY:      0,
      CD:       0,
      REQ:      0,
      IO:       0,
      MSG:      0,

      // input pins from CPU to SA
      ACK:      0,
      RST:      0,
      SEL:      0,

      // command
      COMMAND:  [],
      pos:      0,
      lun:      0,
      counter:  0
   };
}

// TODO all timeouts

let sa_ticks = 0;
function SA_tick() {
   sa_ticks++;

   let oldstate = SA.STATE;

   if(SA.RST) {
      SA.BSY = 0;
      SA.MSG = 0;
      SA.CD  = 0;
      SA.REQ = 0;
      SA.IO  = 0;
      SA.COMMAND = [];
      //log("SA1400: performed RESET");

      SA.STATE = "UNSELECTED";
   }
   else if(SA.STATE == "UNKNOWN") {
      // unknown state
   }
   else if(SA.STATE == "UNSELECTED") {
      SA.BSY = 0;
      SA.MSG = 0;
      SA.CD  = 0;
      SA.REQ = 0;
      SA.IO  = 0;
      SA.COMMAND = [];

      // cpu starts the selection procedure
      if(SA.SEL==1) {
         // TODO: why does not GP set D0=1 as required in SASI protocol?
         SA.STATE = "SELECTED";
      }
   }
   else if(SA.STATE == "SELECTED") {
      // controller requests a command
      SA.BSY = 1;   // busy
      SA.MSG = 0;   // no message
      SA.CD  = 1;   // byte is control data
      SA.REQ = 1;   //
      SA.IO  = 0;   // bytes from host to contrller
      SA.STATE = "SELECTED.1";
   }
   else if(SA.STATE == "SELECTED.1") {
      SA.BSY = 1;   // busy
      SA.MSG = 0;   // no message
      SA.CD  = 1;   // byte is control data
      SA.REQ = 1;   // request a command byte
      SA.IO  = 0;   // bytes from host to contrller

      // cpu sends a data byte
      if(SA.ACK == 1) {
         SA.COMMAND.push(SA.DATA_IN);
         //console.log(`----------> data byte received: ${SA.DATA_IN}`);
         SA.STATE = "SELECTED.2";
      }
   }
   else if(SA.STATE == "SELECTED.2") {
      // waits for ACK to be deasserted by the cpu
      if(SA.ACK == 0) {
         let command       = SA.COMMAND.length > 0 ? SA.COMMAND[0] & 0b11111 : -1;
         let command_class = SA.COMMAND.length > 0 ? SA.COMMAND[0] >> 5 : -1;

         if(SA.COMMAND.length == 6 && (command_class==0)) {
            // parse class 0 commands
            if(command == 0) {
               // test drive (no op)
               //log("SA1400: performed COMMAND TEST DRIVE");

               SA.STATE = "STATUS_BYTE";
            }
            else if(command == 1) {
               // recalibrate
               stopped = true;
               throw `command ${command} not handled`;
            }
            else if(command == 2) {
               // request syndrome
               stopped = true;
               throw `command ${command} not handled`;
            }
            else if(command == 3) {
               // request sense
               stopped = true;
               throw `command ${command} not handled`;
            }
            else if(command == 4) {
               // format drive
               SA.STATE = "FORMAT_DRIVE";
            }
            else if(command == 5) {
               // check track format
               stopped = true;
               throw `command ${command} not handled`;
            }
            else if(command == 6) {
               // format track
               stopped = true;
               throw `command ${command} not handled`;
            }
            else if(command == 7) {
               // format bad track
               stopped = true;
               throw `command ${command} not handled`;
            }
            else if(command == 8) {
               // read command
               let addr = (SA.COMMAND[3] << 0) | (SA.COMMAND[2] << 8) | ((SA.COMMAND[1] & 0b11111) << 16);
               let nblocks = SA.COMMAND[4];

               SA.lun     = lun_to_id(SA.COMMAND[1]);
               SA.counter = nblocks * 256;
               SA.pos     = addr * 256;

               SA.STATE = "READ_SECTOR";

               //console.log(`SA1400: reading sector ${addr}`);
            }
            else if(command == 0x0a) {
               // write command
               let addr = (SA.COMMAND[3] << 0) | (SA.COMMAND[2] << 8) | ((SA.COMMAND[1] & 0b11111) << 16);
               let nblocks = SA.COMMAND[4];

               SA.lun     = lun_to_id(SA.COMMAND[1]);
               SA.counter = nblocks * 256;
               SA.pos     = addr * 256;

               SA.STATE = "WRITE_SECTOR";

               //console.log(`SA1400: writing sector ${addr}`);
            }
            else if(command == 0x0b) {
               // seek
               stopped = true;
               throw `command ${command} not handled`;
            }
            else {
               stopped = true;
               throw `class 0 command ${command} not handled`;
            }
         }
         else if(SA.COMMAND.length == 6 && (command_class==7)) {
            stopped = true;
            throw `class 7 commands not handled`;
         }
         else if(SA.COMMAND.length == 10 && command_class == 1) {
            if(command == 0) {
               // copy blocks
               let nblocks = SA.COMMAND[4];

               let addrs = (SA.COMMAND[3] << 0) | (SA.COMMAND[2] << 8) | ((SA.COMMAND[1] & 0b11111) << 16);
               let addrd = (SA.COMMAND[7] << 0) | (SA.COMMAND[6] << 8) | ((SA.COMMAND[5] & 0b11111) << 16);

               let luns   = lun_to_id(SA.COMMAND[1]);
               let lund   = lun_to_id(SA.COMMAND[5]);

               // do the actual copy
               for(let i=0;i<nblocks*256;i++) {
                  hard_disks[lund].image[addrd*256+i] = hard_disks[luns].image[addrs*256+i];
               }

               //console.log(`copying block DSK=${luns} SEC=${addrs} => DSK=${lund} SEC=${addrd} (${nblocks} blocks)`);

               SA.STATE = "STATUS_BYTE";
            }
            else {
               stopped = true;
               throw `class 1 command ${command} not handled`;
            }
         }
         else {
            // command not completed yet, get next byte
            SA.STATE = "SELECTED";
         }
      }
   }
   else if(SA.STATE == "STATUS_BYTE") {
      SA.BSY = 1;
      SA.MSG = 0;
      SA.REQ = 1;      // controller wants to send the status byte
      SA.CD  = 1;      // the data type is a control data
      SA.IO  = 1;      // the data is input for the CPU
      SA.DATA_OUT = 0; // status byte (no error)

      // status byte is received from the cpu
      if(SA.ACK == 1) {
         SA.STATE = "STATUS_BYTE.1";
      }
   }
   else if(SA.STATE == "STATUS_BYTE.1") {
      // waits until cpu finish reading
      if(SA.ACK == 0) {
         SA.STATE = "MESSAGE";
      }
   }
   else if(SA.STATE == "MESSAGE") {
      // a end of message byte is sent from controller on the bus
      SA.BSY = 1;
      SA.MSG = 1;      // this is the message
      SA.CD  = 1;      // the data type is a control data
      SA.REQ = 1;      // controller wants to send the status byte
      SA.IO  = 1;      // the data is input for the CPU
      SA.DATA_OUT = 0; // zero message

      if(SA.ACK == 1) {
         SA.STATE = "MESSAGE.1";
      }
   }
   else if(SA.STATE == "MESSAGE.1") {
      if(SA.ACK == 0) {
         SA.STATE = "UNSELECTED";
      }
   }
   else if(SA.STATE == "READ_SECTOR") {
      // byte is sent from controller to the bus
      if(SA.ACK == 0) {
         let byte = hard_disks[SA.lun].image[SA.pos];
         SA.BSY = 1;
         SA.MSG = 0;
         SA.CD  = 0;               // the data type is data
         SA.REQ = 1;               // controller wants to send the first byte
         SA.IO  = 1;               // the data is input for the CPU
         SA.DATA_OUT = byte;
         SA.STATE = "READ_SECTOR.1";
      }
   }
   else if(SA.STATE == "READ_SECTOR.1") {
      // byte is sent from controller to the bus
      if(SA.ACK == 1) {
         SA.BSY = 1;
         SA.MSG = 0;
         SA.CD  = 0;
         SA.REQ = 0;
         SA.IO  = 1;
         SA.pos++;
         SA.counter--;
         //console.log(`remaining in buffer ${SA.counter}`);
         if(SA.counter == 0) {
            SA.REQ = 1;      // controller wants to send the status byte
            SA.CD  = 1;      // the data type is a control data
            SA.IO  = 1;      // the data is input for the CPU
            SA.DATA_OUT = 0; // status byte (no error)
            SA.STATE = "STATUS_BYTE";
         }
         else SA.STATE = "READ_SECTOR";
      }
   }
   else if(SA.STATE == "WRITE_SECTOR") {
      // byte is sent from cpu controller on the bus
      SA.BSY = 1;
      SA.MSG = 0;
      SA.IO  = 0;               // the data is input for the CPU
      SA.CD  = 0;               // the data type is data
      if(SA.ACK == 1) {
         // write byte on disk
         let byte = SA.DATA_IN;
         hard_disks[SA.lun].image[SA.pos] = byte;
         SA.BSY = 1;
         SA.MSG = 0;
         SA.CD  = 0;               // the data type is data
         SA.REQ = 1;               // controller wants to send the first byte
         SA.IO  = 0;               // the data is input for the CPU
         SA.DATA_OUT = byte;
         SA.STATE = "WRITE_SECTOR.1";
      }
   }
   else if(SA.STATE == "WRITE_SECTOR.1") {
      // byte is sent from cpu to controller
      if(SA.ACK == 0) {
         SA.BSY = 1;
         SA.MSG = 0;
         SA.CD  = 0;
         SA.REQ = 1;
         SA.IO  = 0;
         SA.pos++;
         SA.counter--;
         //console.log(`remaining in buffer ${SA.counter}`);
         if(SA.counter == 0) {
            SA.REQ = 1;      // controller wants to send the status byte
            SA.CD  = 1;      // the data type is a control data
            SA.IO  = 1;      // the data is input for the CPU
            SA.DATA_OUT = 0; // status byte (no error)
            SA.STATE = "STATUS_BYTE";
         }
         else SA.STATE = "WRITE_SECTOR";
      }
   }
   else if(SA.STATE == "FORMAT_DRIVE") {
      let interleave = SA.COMMAND[4];
      SA.lun = lun_to_id(SA.COMMAND[1]);

      console.log(`formatting drive ${SA.lun} with interleave=${interleave}`);

      // wipe all
      hard_disks[SA.lun].image.forEach((e,i)=>hard_disks[SA.lun].image[i] = 0x6C);

      SA.STATE = "STATUS_BYTE";
   }
   else throw `state "${SA.STATE} not handled"`;

   if(oldstate != SA.STATE) {
      //log(`SA state changed to: ${SA.STATE}`);
   }
}

function SASI_read_data() {
   SA_tick();
   let data = SA.DATA_OUT;
   SA.ACK = 1;
   //log(`pins write ACK=${SA.ACK}`);
   SA_tick();
   SA.ACK = 0;
   //log(`pins write ACK=${SA.ACK}`);
   SA_tick();
   return data;
}

function SASI_write_data(value) {
   SA.DATA_IN = value;
   //log(`==================> data write ${hex(value)}`);
   //log(cpu_status());
   SA_tick();
   SA.ACK = 1;
   //log(`pins write ACK=${SA.ACK}`);
   SA_tick();
   SA.ACK = 0;
   //log(`pins write ACK=${SA.ACK}`);
   SA_tick();
   SA_tick();
}

function SASI_read_pins() {
   SA_tick();
   SA_tick();

   let PINS_OUT =
      (SA.BSY << 0) |
      (SA.MSG << 1) |
      (SA.CD  << 2) |
      (SA.REQ << 3) |
      (SA.IO  << 4) ;      // IO=1 data from controller to CPU

   let pins = [];
   if(SA.BSY) pins.push("BSY");
   if(SA.CD)  pins.push("CD");
   if(SA.REQ) pins.push("REQ");
   if(SA.IO)  pins.push("IO");
   if(SA.MSG) pins.push("MSG");

   //log(`read pins ${pins.join(" ")} ($${hex(PINS_OUT)})`);
   //log(cpu_status());
   return PINS_OUT;
}

function SASI_write_pins(value) {

   let oldsel = SA.SEL;

   //SA.ACK = (value >> 9) & 1 ;
   SA.SEL = (value >> 1) & 1 ;
   SA.RST = (value >> 2) & 1 ;

   //log(`pins write ACK=${SA.ACK} RST=${SA.RST} SEL=${SA.SEL} value=0b${value.toString(2)}`);

   //if(oldsel != SA.SEL) log(`------- SEL changed to SEL=${SA.SEL}`);

   SA_tick();
   SA_tick();
   SA_tick();

   SA.SEL = 0 ;
   SA.RST = 0 ;

   SA_tick();
   SA_tick();
   SA_tick();
}

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

function lun_to_id(byte) {
   let LUN = (byte >> 5) & 0b011;

        if(LUN==1) return 0;
   else if(LUN==0) return 1;
   else if(LUN==2) return 2;
   else if(LUN==3) return 3;
}

// the actual hard disks
let hard_disks = [
   new HardDisk(undefined, HDC_MEDIA_SIZE),
   new HardDisk(undefined, FHDC_MEDIA_SIZE),
   new HardDisk(undefined, HDC_MEDIA_SIZE),
   new HardDisk(undefined, HDC_MEDIA_SIZE)
];

