const fs = require('fs');
const getpos = require("./fdc-pos").FDC_getpos_geometry;
const { invert } = require("./fdc-pos");

let geometry = {
    NSIDES:     1,
    NTRACKS:    40,
    NSECTORS:   18,
    SECTORSIZE: 128
};

let disksize = geometry.NSIDES * geometry.NTRACKS * geometry.NSECTORS * geometry.SECTORSIZE;

const disk = new Uint8Array(disksize).fill(0xE5);

let boot_loader = fs.readFileSync("../docs/bootloaders/GP16_IMD.dsk.boot.bin");
let ccp = fs.readFileSync("../docs/ccp/GP16_IMD.dsk.side0.ccp.bin");

// patcha bootloader
boot_loader[0x10]  = 1;                       // al posto di 2    ==> CCP start sector number
boot_loader[0x31]  = geometry.NSECTORS;       // al posto di 27   ==> max number of sector + 1
boot_loader[0x36]  = 0;                       // al posto di 1    ==> first number of sector

// patcha DPB nel CCP/BIOS
ccp[0xBB01-0xA400]    = geometry.NSECTORS+1;  // al posto di 27
ccp[0xBAC2-0xA400+0]  = geometry.NSECTORS;    // al posto di 26
ccp[0xBAC2-0xA400+5]  = 80;                   // al posto di 242  ==> max number of blocks
ccp[0xBAC2-0xA400+13] = 4;                    // al posto di 2    ==> start track for cpm directory

// soluzione con disabilitazione della SKEW TABLE
ccp[0xBC49-0xA400+0] = 0xC5;    // PUSH BC
ccp[0xBC49-0xA400+1] = 0xE1;    // POP  HL
ccp[0xBC49-0xA400+2] = 0xC9;    // RET

/*
// soluzione vecchia con INC/DEC
// cambia le "CALL E806" in "CALL BD80"
ccp[0xBAEA-0xA400+0] = 0x80;
ccp[0xBAEA-0xA400+1] = 0xBD;
ccp[0xBCE8-0xA400+0] = 0x80;
ccp[0xBCE8-0xA400+1] = 0xBD;

// installa la routine a BD80
ccp[0xBD80-0xA400+0] = 0x0D;    // DEC C
ccp[0xBD80-0xA400+1] = 0xCD;    // CALL E806
ccp[0xBD80-0xA400+2] = 0x06;    //
ccp[0xBD80-0xA400+3] = 0xE8;    //
ccp[0xBD80-0xA400+4] = 0x0C;    // INC C
ccp[0xBD80-0xA400+5] = 0xC9;    // RET
*/

fs.writeFileSync("ccp.patched.bin", ccp);

// negate
boot_loader = invert(boot_loader);
ccp = invert(ccp);

// scrive sulla faccia 0
write_seq("boot", boot_loader, disk, 0, 1, 0, geometry);
write_seq("ccp",  ccp,         disk, 0, 2, 0, geometry);

fs.writeFileSync("disk_525_40x18x128.img", disk);
fs.writeFileSync("disk_525_40x18x128.dsk", disk);


// ***************************

function write_seq(what, source, disk, start_track, start_sector, start_side, geometry) {
    for(let t=0; t<source.length; t+=geometry.SECTORSIZE) {
        let pos = getpos(start_side, start_track, start_sector, geometry);

        console.log(`writing ${what} at track ${start_track} sector ${start_sector} side ${start_side}`);
        for(let i=0; i<geometry.SECTORSIZE; i++) {
            disk[pos+i] = source[t+i];
        }

        start_sector++;
        if(start_sector > geometry.NSECTORS) {
            start_sector = 1;
            start_track++;
        }
    }
}

/*
function write_seq(what, source, disk, start_track, start_sector, start_side, geometry) {
    for(let t=0; t<source.length; t+=geometry.SECTORSIZE) {
        let pos = getpos(start_side, start_track, start_sector, geometry);

        console.log(`writing ${what} at track ${start_track} sector ${start_sector} side ${start_side}`);
        for(let i=0; i<geometry.SECTORSIZE; i++) {
            disk[pos+i] = source[t+i];
        }

        start_sector++;
        if(start_sector > geometry.NSECTORS) {
            start_sector = 1;
            start_track++;
        }
    }
}
*/
