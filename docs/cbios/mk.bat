yaza bios_all.asm --define:FLOPPY_525=0 --define:DOUBLE_SIDE=0 --lst:bios.floppy.8.SS.lst   --output:bios.floppy.8.SS.bin
yaza bios_all.asm --define:FLOPPY_525=0 --define:DOUBLE_SIDE=1 --lst:bios.floppy.8.DS.lst   --output:bios.floppy.8.DS.bin
yaza bios_all.asm --define:FLOPPY_525=1 --define:DOUBLE_SIDE=0 --lst:bios.floppy.525.SS.lst --output:bios.floppy.525.SS.bin
yaza bios_all.asm --define:FLOPPY_525=1 --define:DOUBLE_SIDE=1 --lst:bios.floppy.525.DS.lst --output:bios.floppy.525.DS.bin



