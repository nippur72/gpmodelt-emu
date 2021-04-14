#include <stdio.h>
#include <stdlib.h>
#include <cpm.h>

typedef unsigned char byte;
typedef unsigned int word;

/*
porta 78h: read/write data

porta 7Ah
    read: bit 0 => data is ready to be read
          bit 3 => data can be written to output

*/

__sfr __at 0x78 serial_data;
__sfr __at 0x7a serial_status;

byte serial_in_ready() {
   return (serial_status & 1);
}

byte serial_out_ready() {
   return (serial_status & 8) != 0;
}

// CONST (function 2)
// Returns 0 if no character is ready, 0FFh if one is.
byte CONST() {
   return bios(2,0,0);
}

byte CONIN() {
   return bios(3,0,0);
}

void main(int argc, char *argv[]) {
   printf("Press ^C to return to CP/M\r\n");
   while(1) {
      while(serial_in_ready()) {
         byte c = serial_data;
         if(c==0) continue;  // NULL
         if(c==7) continue;  // BELL
         printf("%c",c);
      }
      if(CONST()) {
         byte c = CONIN();
         if(c==3) break;     // CTRL+C exits
         while(!serial_out_ready());
         serial_data = c;
      }
   }
   printf("Goodbye!\r\n");
}
