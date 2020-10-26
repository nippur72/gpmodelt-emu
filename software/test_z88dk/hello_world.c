//#pragma output nostreams      // No stdio disc files
//#pragma output nofileio       // No fileio at all
#pragma output noprotectmsdos // strip the MS-DOS protection header
#pragma output noredir        // do not insert the file redirection option while parsing the command line arguments (useless if “nostreams” is set)
#pragma output nogfxglobals   // No global variables for graphics (required to make the graphics library work on the TIKI-100)

#include <stdio.h>

#define REVERSE_ON()  "\x16""00"
#define REVERSE_OFF() "\x16""80"

int main() {
    printf("*** HELLO WORLD! ***\r\n\r\n");
    printf("From General Processor Model T\r\n\r\n");
    printf("and " REVERSE_ON() " Z88DK " REVERSE_OFF() " C Compiler\r\n\r\n");
}

