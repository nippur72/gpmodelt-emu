function mem_read(address) {
   return memory[address];
}

function mem_write(address, value) {
   // TODO replicate video memory pages
   if(address <= 0xCFFF) memory[address] = value;
   //if(address < 0xb000) console.log(`POKE &h${hex(address,4)}, &h${hex(value)} pc=${hex(cpu.getState().pc,4)}`);
}

function io_read(ioport) {  
   const port = ioport & 0xFF;
   switch(port) {

      case 0x3f:
         return FDC_read_port_3f();

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

   warn(`read from unknown port ${hex(port)}h`);

   return 0x00;
}

let ser_counter = 0;
let ser_data = 0;

function io_write(ioport, value) {    
   const port = ioport & 0xFF;

   //console.log(`io write ${hex(port)} ${hex(value)}`)
   switch(port) {
      case 0x3f:
         FDC_write_port_3f(value);
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
   warn(`write on unknown port ${hex(port)}h value ${hex(value)}h`);
}

