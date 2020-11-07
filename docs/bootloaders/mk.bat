yaza boot_loader.asm --define:FLOPPY_525=0 --define:BOOT_MESSAGE=0 --output:boot_loader.floppy.8.bin
yaza boot_loader.asm --define:FLOPPY_525=0 --define:BOOT_MESSAGE=1 --output:boot_loader.floppy.8.alt.bin
yaza boot_loader.asm --define:FLOPPY_525=1 --define:BOOT_MESSAGE=0 --output:boot_loader.floppy.525.bin
yaza boot_loader.asm --define:FLOPPY_525=1 --define:BOOT_MESSAGE=1 --output:boot_loader.floppy.525.alt.bin







