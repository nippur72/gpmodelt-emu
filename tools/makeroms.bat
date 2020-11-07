call node bin2js -i ..\roms\DT49-48_U1.BIN              -o ..\roms\rom.E000.js         -n rom_E000
call node bin2js -i ..\roms\ROM_MT16_U2.BIN             -o ..\roms\rom.E400.js         -n rom_E400
call node bin2js -i ..\roms\FDC8-8_U3.BIN               -o ..\roms\rom.E800_FDC8.js    -n rom_E800_FDC8
call node bin2js -i ..\roms\ROM-U3.BIN                  -o ..\roms\rom.E800_FDC525.js  -n rom_E800_FDC525
call node bin2js -i ..\roms\ACI_15-48_U4.BIN            -o ..\roms\rom.EC00.js         -n rom_EC00_ACI
call node bin2js -i ..\roms\GCE_M1.U3                   -o ..\roms\rom.GCE_M1_U3.js    -n rom_GCE_M1_U3
call node bin2js -i ..\roms\GCE_M2.U4                   -o ..\roms\rom.GCE_M2_U4.js    -n rom_GCE_M2_U4
call node bin2js -i ..\roms\G-CAR-A_U7.BIN              -o ..\roms\rom.GCAR_A_U7       -n rom_GCAR_A_U7
call node bin2js -i ..\roms\G-CAR-B_U8.BIN              -o ..\roms\rom.GCAR_B_87       -n rom_GCAR_B_U8
rem call node bin2js -i ..\roms\machine2\U1-MON24.2.bin     -o ..\roms\rom.MON24_2         -n rom_MON24_2
rem call node bin2js -i ..\roms\machine2\U2-SYS2K-482.bin   -o ..\roms\rom.SYS2K_482       -n rom_SYS2K_482
rem call node bin2js -i ..\roms\machine2\U3-RIG02-U.BIN     -o ..\roms\rom.RIG02_U         -n rom_RIG02_U
call node bin2js -i ..\roms\GPMON007.bin                -o ..\roms\rom.GPMON007.js     -n rom_GPMON007

