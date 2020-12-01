const fs = require('fs');
const { FDC_getpos: getpos, FDC_getpos_geometry, emptydisk } = require("./fdc-pos");

// read all disks
let disk_path = "../software";
let disk_names = fs.readdirSync(disk_path).filter(fn=>fn.match(/GP.*img$/g));

//disk_names.forEach(dn=>extract_boot(dn));
//disk_names.forEach(dn=>extract_ccp(dn, 0));
//disk_names.forEach(dn=>extract_ccp(dn, 1));
//disk_names.forEach(dn=>extract_side_1(dn));
//extract_boot_rig("../docs/rig","sa1004_extracted_xor_FF.bin");

extract_ccp_rig("../docs/rig","sa1004_extracted_xor_FF.bin");

function extract_ccp_rig(disk_path, disk_name) {
    let disk = fs.readFileSync(`${disk_path}/${disk_name}`);

    let ccp_and_bios = disk.slice(256,256+0x1a*256);
    let ccp  = ccp_and_bios.slice(0,(0xBA00-0xA400));
    let bios = ccp_and_bios.slice((0xBA00-0xA400));

    let ccp_name = `${disk_path}/rig.ccp.bin`;
    let bios_name = `${disk_path}/rig.bios.bin`;

    fs.writeFileSync(ccp_name,  ccp);
    fs.writeFileSync(bios_name, bios);

    console.log(`extracted ${ccp_name} from ${disk_name}`);
    console.log(`extracted ${bios_name} from ${disk_name}`);
}

function extract_side_1(disk_name) {
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

    let source_name = `${disk_path}/${disk_name}`;
    let dest_name = `${disk_path}/${disk_name}.side1.SS.img`;
    let source_disk = fs.readFileSync(source_name);
    let dest_disk = emptydisk(geometry);

    for(let t=0;t<geometry.NTRACKS;t++) {
        for(let s=1;s<=geometry.NSECTORS;s++) {
            let pos_source = FDC_getpos_geometry(1,t,s,geometry);
            let pos_dest = FDC_getpos_geometry(0,t,s,geometry);

            // copy sector
            for(i=0;i<geometry.SECTORSIZE;i++) {
                dest_disk[pos_dest+i] = source_disk[pos_source+i];
            }
        }
    }

    // write
    fs.writeFileSync(dest_name, dest_disk);
}

function extract_boot(disk_name) {
    let disk = fs.readFileSync(`${disk_path}/${disk_name}`);

    let boot_sector = disk.slice(0,128).map(e=>(~e & 0xFF));
    let boot_name = `${disk_name}.boot.bin`;

    fs.writeFileSync(boot_name, boot_sector);

    console.log(`extracted ${boot_name} from ${disk_name}`);
}

function extract_ccp(disk_name, side) {
    let disk = fs.readFileSync(`${disk_path}/${disk_name}`);

    let ccp = [];

    let t=0; s=2;
    let howmany = 26*2-1; // from A400 to near BFFF
    for(let ns=0; ns<howmany; ns++) {
        let start = getpos(side, t, s);
        let sector = disk.slice(start,start+128).map(e=>(~e & 0xFF));
        sector.forEach(b=>ccp.push(b));

        s=s+1;
        if(s==27) {
            s=1;
            t++;
        }
    }

    let ccp_name = `../docs/ccp/${disk_name}.side${side}.ccp.bin`;
    fs.writeFileSync(ccp_name, new Uint8Array(ccp));
    console.log(`extracted ${ccp_name} from ${disk_name} side ${side}`);

    let cbios = ccp.slice(0x1600,0x197f);
    let cbios_name = `../docs/ccp/${disk_name}.side${side}.cbios.bin`;
    fs.writeFileSync(cbios_name, new Uint8Array(cbios));
    console.log(`extracted ${cbios_name} from ${disk_name} side ${side}`);
}

