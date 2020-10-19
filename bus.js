function mem_read(address) {
   return memory[address];
}

function mem_write(address, value) {
   // TODO replicate video memory pages
   if(address <= 0xCFFF) memory[address] = value;
}

let warnings = 0;

function io_read(ioport) {  
   const port = ioport & 0xFF;
   switch(port) {

      case 0x3f:
         let byte = FDC_drive_number                |
                    ((FDC_side^1)            << 2)  |
                    (FDC_HLD                 << 5)  |
                    (FDC_INTREQ              << 6)  |
                    (FDC_STATUS_DATA_REQUEST << 7);

         warnings++;
         if(warnings < 1000) {
            // console.log(`read from drive select: ret=${hex(byte)}h drive number=${FDC_drive_number} side=${FDC_side} INTREQ=${FDC_INTREQ} DATAREQ=${FDC_STATUS_DATA_REQUEST}`);
         }

         return byte;

      case 0xff:
      case 0xd8:
         // keyboard
         return keyboard_read();

      case 0x77:
         // ACI + video sync pins
         // VSYNC necessita bit 3 posto a 0, bit 2 posto a 1
         return 0b00000100 | (cassette_bit_in << 1);

      case 0xBC:
      case 0xBD:
      case 0xBE:
      case 0xBF: {
         let reg  = port - 0xBC;
         return ~FDC_read(reg) & 0xFF;   // negated because D0-D7 are negated on the 1791
      }
   }
   warnings++;
   if(warnings < 1000) {
      console.warn(`read from unknown port ${hex(port)}h`);
   }
   return 0x00;
}

let ser_counter = 0;
let ser_data = 0;

function io_write(ioport, value) {    
   const port = ioport & 0xFF;

   // console.log(`io write ${hex(port)} ${hex(value)}`)  
   switch(port) {
      case 0x3f:
         // scheda FDC
         FDC_drive_number = value & 0b11;
         FDC_side = ((value & 0b100) >> 2) ^ 1;
         //console.log(`write to drive select: drive number=${FDC_drive_number} side=${FDC_side} ${cpu_status()}`);
         console.log(`drive select: drive number=${FDC_drive_number} side=${FDC_side}`);
         return;

      case 0x77:
         // ACI port
         cassette_bit_out1 = (value & (1<<0)) > 0;
         cassette_bit_out2 = (value & (1<<2)) > 0;
         return;

      case 0xBC:
      case 0xBD:
      case 0xBE:
      case 0xBF: {
        let reg  = port - 0xBC;
        let data = ~value & 0xFF;      // negated because D0-D7 are negated on the 1791
        FDC_write(reg, data);
        return;
      }
   } 
   warnings++;
   if(warnings < 1000) {
      console.warn(`write on unknown port ${hex(port)}h value ${hex(value)}h`);
   }
}

