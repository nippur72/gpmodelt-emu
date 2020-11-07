/*
cd ..\docs\ccp\525
yaza doubleside.asm
node ..\..\..\tools\bin2js.js -i doubleside.bin -o doubleside.bin.js -n dsroutine --export
cd ..\..\..\tools
node mk_525_disk.js
cd ..\docs\ccp\525
..\..\..\..\..\z80\yazd\yazd.exe --addr:0xA400 --xref --lst --lowercase --mwr ccp.patched.bin > ccp.patched.asm
cd ..\..\..\tools
*/

const fs = require('fs');
const getpos = require("./fdc-pos").FDC_getpos_geometry;
const { invert, emptydisk } = require("./fdc-pos");

/*
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
*/

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

const disk = emptydisk(geometry);

let boot_loader = fs.readFileSync("../docs/bootloaders/GP16_IMD.img.boot.bin");
let ccp = fs.readFileSync("../docs/ccp/GP16_IMD.img.side0.ccp.bin");
let calkins = fs.readFileSync("../docs/ccp/CPM22.calkins.bin");

// patcha bootloader
if(geometry.TYPE525)
{
    boot_loader[0x10]  = geometry.FIRSTSECTOR + 1;                  // al posto di 2    ==> CCP start sector number
    boot_loader[0x0c]  = 0x34;                                      // al posto di 0x34 ==> numero di settori da leggere
    boot_loader[0x31]  = geometry.FIRSTSECTOR + geometry.NSECTORS;  // al posto di 27   ==> max number of sector + 1
    boot_loader[0x36]  = geometry.FIRSTSECTOR;                      // al posto di 1    ==> first sector starts from
}

// usa CCP Calkins
if(true) ccp.set(calkins);

// usa CCP da i8080 emulatore online
if(false) {
    let cpm48com = fs.readFileSync("../docs/ccp/cpm48.com.i8080.bin");
    for(let t=0;t<5632;t++) ccp[t] = cpm48com[t];
}

// patcha routine WBOOT
if(geometry.TYPE525)
{
    ccp[0xBAE1-0xA400] = geometry.FIRSTSECTOR + 1;                  // al posto di 2    ==> CCP start sector number
    ccp[0xBB01-0xA400] = geometry.FIRSTSECTOR + geometry.NSECTORS;  // al posto di 27   ==> max number of sector
    ccp[0xBB05-0xA400] = geometry.FIRSTSECTOR;                      // al posto di 1    ==> first sector starts from
}

// patcha DPB nel CCP/BIOS
if(geometry.TYPE525)
{
    let nblocks;
         if(geometry.NTRACKS==77 && !geometry.DOUBLESIDE) nblocks = 242;
    else if(geometry.NTRACKS==77 &&  geometry.DOUBLESIDE) nblocks = 242*2-10;
    else if(geometry.NTRACKS==40 && !geometry.DOUBLESIDE) nblocks = 80;
    else if(geometry.NTRACKS==40 &&  geometry.DOUBLESIDE) nblocks = 170;
    else throw `invalid configuration`;
    console.log(nblocks);
    ccp[0xBAC2-0xA400+0]  = geometry.NSECTORS;               // al posto di 26
    ccp[0xBAC2-0xA400+5]  = nblocks;                         // al posto di 242  ==> max number of blocks
    ccp[0xBAC2-0xA400+13] = geometry.TYPE8 ? 2 : 4;          // al posto di 2    ==> start track for cpm directory
}

// soluzione con disabilitazione della SKEW TABLE
if(geometry.TYPE525)
{
    ccp[0xBC49-0xA400+0] = 0xC5;    // PUSH BC
    ccp[0xBC49-0xA400+1] = 0xE1;    // POP  HL
    ccp[0xBC49-0xA400+2] = 0xC9;    // RET
}

// *** abilitazione della doppia faccia ***
if(geometry.DOUBLESIDE && geometry.TYPE525)
{
    // riduzione del numero dei dischi da 4 a 2
    ccp[0xBC2E-0xA400+0] = 0x02;                            // al posto di 04h    ==> max number of logical units

    // devia con un JP $BEA5
    ccp[0xBCD4-0xA400+0] = 0xC3;
    ccp[0xBCD4-0xA400+1] = 0x31;
    ccp[0xBCD4-0xA400+2] = 0xBF;

    // ripulisce a partire da BD80 fino a BDFF
    for(let t=0xBD80;t<0xBF7F;t++) ccp[t-0xA400+2] = 0x76;

    // inserisce routine a BF31
    const routine = require("../docs/ccp/525/doubleside.bin.js");
    routine.forEach((b,i)=>ccp[0xBF31-0xA400+i]=b);
}

if(true)
{
    // modifica messaggio del prompt
    let Message;                                           //  34567890123456789012
    if(geometry.TYPE525 && !geometry.DOUBLESIDE) Message = '\r\nCPM 2.2 48k 5.25"SS\r\n\xA0';
    if(geometry.TYPE525 &&  geometry.DOUBLESIDE) Message = '\r\nCPM 2.2 48k 5.25"DS\r\n\xA0';
    if(geometry.TYPE8   && !geometry.DOUBLESIDE) Message = '\r\nCPM 2.2 48k 8" SS\r\n\xA0';
    if(geometry.TYPE8   &&  geometry.DOUBLESIDE) Message = '\r\nCPM 2.2 48k 8" DS\r\n\xA0';
    //Message = '\r\nVER 1242\r\n\xA0';
    for(let t=0;t<Message.length;t++) {
        ccp[0xBB50-0xA400+t] = Message.charCodeAt(t);
    }

    // patcha "Inizio Lavoro"
    ccp[0xBD6F-0xA400] = 128+8;
}

// patcha bug funzione READER RDR:
if(true)
{
    ccp[0xBBCC-0xA400] = 0b00001100;
    ccp[0xBBCE-0xA400] = 0b00000100;
}

fs.writeFileSync("../docs/ccp/525/ccp.patched.bin", ccp);

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

