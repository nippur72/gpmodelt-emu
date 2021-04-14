function mem_read(address) {
   return memory[address];
}

function mem_write(address, value) {
   // TODO replicate video memory pages
   if(address <= 0xCFFF) memory[address] = value;
   // warn disabled for T20 firmware
   // else console.warn(`ROM write at address ${hex(address,4)}h value ${hex(value)}h pc=${hex(cpu.getState().pc,4)}h`);
}

function io_read(ioport) {  
   const port = ioport & 0xFF;
   //if(port!=0xFF) warn(`read from unknown port ${hex(port)}h`);
   switch(port) {

      case 0x6d:
         return ~SASI_read_pins() & 0xFF;

      case 0x6c:
         return ~SASI_read_data() & 0xFF;

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

      case 0x78:
         // serial data read
         return serial.cpu_read_data();

      case 0x7a:
         // serial status, always ready
         return serial.cpu_read_status();

      case 0xc0:
      case 0xe8:
         return keyboard_read();

      case 0xBC:
      case 0xBD:
      case 0xBE:
      case 0xBF: {
         let reg  = port - 0xBC;
         return ~FDC_read(reg) & 0xFF;   // negated because D0-D7 are negated on the 1791
      }
   }

   //warn(`read from unknown port ${hex(port)}h`);
   return 0x00;
}

function io_write(ioport, value) {    
   const port = ioport & 0xFF;

   //console.log(`io write ${hex(port)} ${hex(value)}`)
   switch(port) {

      case 0x3f:
         FDC_write_port_3f(value);
         return;

      case 0x5c:
         // parallel printer
         printerWrite(value);
         return;

      case 0x6d:
         return SASI_write_pins(~value & 0xFF);

      case 0x6c:
         return SASI_write_data(~value & 0xFF);

      case 0x5e:
      case 0x5f:
         // paralle printer config, ignored
         return;

      case 0x77:
         // ACI port
         cassette_bit_out1 = (value & (1<<0)) > 0;
         cassette_bit_out2 = (value & (1<<2)) > 0;
         return;

      case 0x78:
         // serial data
         serial.cpu_write_data(value);
         return;

      case 0x7a:
         // serial command, ignored
         serial.cpu_write_command(value);
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
   //warn(`write on unknown port ${hex(port)}h value ${hex(value)}h`);
}

