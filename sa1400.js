let HDC_MEDIA_SIZE = 256 * 256 * 26 * 4;

// data is assumed to be stored on the media:
// track 0 side 0 [ sectors 0-26 ], track 0 side 1 [ sectors 0-26 ], ...

function HDC_getpos(sector) {
   let pos = sector * 256;
   return pos;
}

let HDC_STATE_READY = 0;
let HD_CMD_1 = 1;
let HD_CMD_2 = 2;
let HD_CMD_3 = 3;
let HD_CMD_4 = 4;
let HD_CMD_5 = 5;

let HDC_state = HDC_STATE_READY;

let HDC_data_buf = [];
let HDC_cmd_buf  = [];

function HDC_read(port) {
   switch(port) {
      case 0x6c:
         warn(`port 6C read`);
         break;

      case 0x6d:
         if(HDC_state == HDC_STATE_READY) {
            warn(`HDC state is ready returning BIT 1 ON `);
            return 1;
         }
         else if(HDC_state == HD_CMD_2) {
            warn(`HDC state is cmd2 returning BIT 0 OFF`);
            return 0x00;
         }
         else if(HDC_state == HD_CMD_3) {
            warn(`HDC state is CMD3 returning 0b010`);
            return 0b010;
         }
         else if(HDC_state == HD_CMD_5) {
            warn(`HDC state is CMD5 returning 0b010 ${cpu_status()}`);
            return 0b010;
         }
         else {
            warn(`port 6D read`);
         }
         break;
   }
}

function HDC_write(port, value) {
   switch(port) {
      case 0x6c:
         HDC_cmd_buf.push(value);
         if(HDC_state === HDC_STATE_READY && value === 0xFE) {
            HDC_state = HD_CMD_1;
            HDC_cmd_buf = [];
            HDC_data_buf = [];
            warn("HDC: start command received");
         }
         else if(HDC_state === HD_CMD_3 && HDC_cmd_buf.length === 6) {
            HDC_state = HD_CMD_4;
            //HDC_cmd_buf = [];
            //HDC_data_buf = [];
            warn("HDC: start command COMPLETE");
         }
         else {
            console.log(`port 6C write ${hex(value)}`);
         }
         return;

      case 0x6d:
         HDC_data_buf.push(value);
         warn(`port 6D write ${hex(value)} data=${HDC_data_buf.map(e=>hex(e)).join(",")} cmd=${HDC_cmd_buf.map(e=>hex(e)).join(",")} state=${HDC_state}`);

         let tail = HDC_data_buf.slice(-2);
         if(tail.length > 0) {
            if(tail[0] === 0xFC && tail[1] === 0xFE) {
               HDC_state = HDC_STATE_READY;
               HDC_data_buf = [];
               warn("HDC: restore command received transition to READY");
            }
            else if(HDC_state === HD_CMD_1 && tail[0] === 0xEE && tail[1] === 0xEA) {
               HDC_state = HD_CMD_2;
               HDC_data_buf = [];
               warn("HDC: transition from CMD_1 to CMD_2");
            }
            else if(HDC_state === HD_CMD_2 && tail[0] === 0xEE) {
               HDC_state = HD_CMD_3;
               HDC_data_buf = [];
               warn("HDC: transition from CMD_2 to CMD_3");
            }
            else if(HDC_state === HD_CMD_3) {
               //HDC_state = HD_CMD_4;
               //HDC_cmd_buf = [];
               warn("HDC: CMD3 command received");
            }
            else if(HDC_state === HD_CMD_4 && value === 0xFE) {
               HDC_state = HD_CMD_5;
               warn(`HDC: transition from CMD_4 to CMD_5 ${cpu_status()}`);
            }
         }

         return;
   }
}

/***************/

class HardDisk {
   constructor(image) {
      this.track = 80;
      this.floppy = image === undefined ? new Uint8Array(FDC_MEDIA_SIZE) : this.resize(image);
   }

   resize(image) {
      const new_image = new Uint8Array(FDC_MEDIA_SIZE);
      image.forEach((e,i)=>new_image[i]=e);
      return new_image;
   }
}

// the actual hard disk
const hard_disk = new HardDisk();

/*
function dump_disk(side, track, sector) {
   let pos = FDC_getpos(side, track, sector);
   let bytes = drives[0].floppy.slice(pos,pos+128);
   //bytes = bytes.map(b=>~b & 0xFF);
   dumpBytes(bytes, 0, 127);
}
*/
