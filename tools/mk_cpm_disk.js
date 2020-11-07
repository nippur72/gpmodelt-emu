const fs = require('fs');
const getpos = require("./fdc-pos").FDC_getpos_geometry;
const { invert, emptydisk } = require("./fdc-pos");


// 5.25
let geometry = {
    TYPE8:       false,
    TYPE525:     true,
    NSIDES:      2,
    NTRACKS:     40,
    NSECTORS:    18,
    SECTORSIZE:  128,
    FIRSTSECTOR: 0,
    DOUBLESIDE:  true
};


/*
// 8"
let geometry = {
    TYPE8:       true,
    TYPE525:     false,
    NSIDES:      2,
    NTRACKS:     77,
    NSECTORS:    26,
    SECTORSIZE:  128,
    FIRSTSECTOR: 1,
    DOUBLESIDE:  false
};
*/

const disk = emptydisk(geometry);

let boot_loader_name = geometry.TYPE8 ? "boot_loader.floppy.8.SS.bin" : "boot_loader.floppy.525.SS.bin";
let boot_loader = fs.readFileSync(`../docs/bootloaders/${boot_loader_name}`);

let ccp = fs.readFileSync("../docs/ccp/disks/GP16_IMD.img.side0.ccp.bin");
let calkins = fs.readFileSync("../docs/ccp/CPM22.calkins.bin");

let biosname = geometry.TYPE8 ? "bios.floppy.8.SS.bin" : "bios.floppy.525.SS.bin";
let bios = fs.readFileSync(`../docs/cbios/${biosname}`);

// usa CCP Calkins
if(false) ccp.set(calkins);

// write new bios
for(let t=0; t<bios.length && (t+0xBA00-0xA400)<ccp.length ; t++) {
    ccp[t+0xBA00-0xA400] = bios[t];
}

// fs.writeFileSync("ccp.patched.bin", ccp);

// negate
boot_loader = invert(boot_loader);
ccp = invert(ccp);

// scrive sulla faccia 0
write_seq("boot", boot_loader, disk, 0, 1, 0, geometry);
write_seq("ccp",  ccp,         disk, 0, 2, 0, geometry);

let fname = `disk_${geometry.NSIDES}x${geometry.NTRACKS}x${geometry.NSECTORS}x${geometry.SECTORSIZE}x${geometry.DOUBLESIDE?"DS":"SS"}`;

fs.writeFileSync(`${fname}.img`, disk);

console.log("done");

// ***************************

function write_seq(what, source, disk, start_track, start_sector, start_side, geometry) {
    for(let t=0; t<source.length; t+=geometry.SECTORSIZE) {
        let pos = getpos(start_side, start_track, start_sector, geometry);

        //console.log(`writing ${what} at track ${start_track} sector ${start_sector} side ${start_side}`);
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

