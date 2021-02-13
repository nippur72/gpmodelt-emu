const fs = require('fs');
const getpos = require("./fdc-pos").FDC_getpos_geometry;
const { invert, emptydisk } = require("./fdc-pos");

make_cpm_disk(true, false);
make_cpm_disk(true, true);
make_cpm_disk(false, false);
make_cpm_disk(false, true);

console.log("done");

// ***************************

function make_cpm_disk(floppy8, double_side) {
    let geometry = get_geometry(floppy8, double_side);
    let disk = emptydisk(geometry);
    let boot_loader = get_bootloader(geometry);
    let ccp = get_ccp();
    let bios = get_bios(geometry);

    // verify sizes
    if(boot_loader.length != 128) throw `invalid boot sector size of ${boot_loader.length} != 128`;
    if(ccp.length != 0x1600) throw `invalid ccp size of ${ccp.length} != ${0x1600}`;
    if(bios.length > 0x37F) throw `invalid bios size of ${bios.length} <= ${0x37f} (max is $BD7F)`;

    // join ccp and bios system
    let cpm = [ ...ccp, ...bios ];

    // negate for WDC1791 data lines
    boot_loader = invert(boot_loader);
    cpm = invert(cpm);

    let fname = `disk_${geometry.NSIDES}x${geometry.NTRACKS}x${geometry.NSECTORS}x${geometry.SECTORSIZE}x${geometry.DOUBLESIDE?"DS":"SS"}`;
    console.log(fname);

    // write to disk on side 0
    write_seq("boot", boot_loader, disk, 0, 1, 0, geometry);
    write_seq("ccp",  cpm,         disk, 0, 2, 0, geometry);

    fs.writeFileSync(`${fname}.img`, disk);
}

function get_geometry(floppy8, double_side) {
    let geometry = floppy8 ?
    {
        TYPE8:       true,
        TYPE525:     false,
        NSIDES:      2,
        NTRACKS:     77,
        NSECTORS:    26,
        SECTORSIZE:  128,
        FIRSTSECTOR: 1,
        DOUBLESIDE:  false
    }
    :{
        TYPE8:       false,
        TYPE525:     true,
        NSIDES:      2,
        NTRACKS:     40,
        NSECTORS:    17,
        SECTORSIZE:  128,
        FIRSTSECTOR: 0,
        DOUBLESIDE:  true
    };
    geometry.DOUBLESIDE = double_side;
    return geometry;
}

function get_bootloader(geometry) {
    let boot_loader_name = geometry.TYPE8 ? "boot_loader.floppy.8.alt.bin" : "boot_loader.floppy.525.alt.bin";
    let boot_loader = fs.readFileSync(`../docs/bootloaders/${boot_loader_name}`);
    return boot_loader;
}

function get_ccp() {
    let ccp = fs.readFileSync("../docs/ccp/disks/GP16_IMD.img.side0.ccp.bin");

    // estrae solo parte ccp+bdos senza bios
    ccp = ccp.slice(0,0xBA00-0xA400);

    // let calkins = fs.readFileSync("../docs/ccp/CPM22.calkins.bin");
    // ccp.set(calkins);
    return ccp;
}

function get_bios(geometry) {
    let biosname;

         if(geometry.TYPE8   && !geometry.DOUBLESIDE) biosname = "bios.floppy.8.SS.bin";
    else if(geometry.TYPE8   &&  geometry.DOUBLESIDE) biosname = "bios.floppy.8.DS.bin";
    else if(geometry.TYPE525 && !geometry.DOUBLESIDE) biosname = "bios.floppy.525.SS.bin";
    else if(geometry.TYPE525 &&  geometry.DOUBLESIDE) biosname = "bios.floppy.525.DS.bin";
    else throw "invalid geometry";

    let bios = fs.readFileSync(`../docs/cbios/${biosname}`);

    // trim bios
    bios = bios.slice(0, 0xBD7F - 0xBA00);

    return bios;
}

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

