const fs = require('fs');
const getpos = require("./fdc-pos").FDC_getpos_geometry;

let geometry = {
    NSIDES:     1,
    NTRACKS:    40,
    NSECTORS:   10,
    SECTORSIZE: 256
};

let disksize = geometry.NSIDES * geometry.NTRACKS * geometry.NSECTORS * geometry.SECTORSIZE;

const disk = new Uint8Array(disksize).fill(0xE5);

let boot_loader = fs.readFileSync("../docs/bootloaders/GP16_IMD.dsk.boot.bin");
let ccp = fs.readFileSync("../docs/ccp/GP16_IMD.dsk.side0.ccp.bin");

// patcha bootloader
boot_loader[0x31]  = geometry.NSECTORS+1;  // al posto di 27

// patcha DPB nel CCP/BIOS
ccp[0xBB01-0xA400]    = geometry.NSECTORS+1;  // al posto di 27
ccp[0xBAC2-0xA400+0]  = geometry.NSECTORS;    // al posto di 26
ccp[0xBAC2-0xA400+5]  = 71;                   // al posto di 242
ccp[0xBAC2-0xA400+13] = 4;                    // al posto di 2

// negate
boot_loader = boot_loader.map(b=>~b & 0xFF);
ccp = ccp.map(b=>~b & 0xFF);

write_seq("boot", boot_loader, disk, 0, 1, 0, geometry);
write_seq("ccp",  ccp,         disk, 0, 2, 0, geometry);

write_seq("boot", boot_loader, disk, 0, 1, 1, geometry);
write_seq("ccp",  ccp,         disk, 0, 2, 1, geometry);

fs.writeFileSync("disk_525.dsk", disk);

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

