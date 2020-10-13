function mem_read(address) {
   return memory[address];
}

function mem_write(address, value) {
   // TODO replicate video memory pages
   if(address <= 0xCFFF) memory[address] = value;
}

function io_read(ioport) {  
   const port = ioport & 0xFF;
   switch(port) {
      case 0xff:
         // keyboard
         return keyboard_read();

      case 0x77:
         // ACI + video sync pins
         // VSYNC necessita bit 3 posto a 0, bit 2 posto a 1
         return 0b00000100;
   }
   console.warn(`read from unknown port ${hex(port)}h`);
   return 0x00;
}

let ser_counter = 0;
let ser_data = 0;

function io_write(port, value) {    
   // console.log(`io write ${hex(port)} ${hex(value)}`)  
   switch(port & 0xFF) {
      case 0x77:
         cassette_bit_out1 = (value & (1<<0)) > 0;
         cassette_bit_out2 = (value & (1<<2)) > 0;
         return;     
   } 
   console.warn(`write on unknown port ${hex(port)}h value ${hex(value)}h`);
}
