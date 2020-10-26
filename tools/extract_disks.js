const fs = require('fs');
const { FDC_getpos: getpos } = require("./fdc-pos");

// read all disks
let disk_path = "../software";
let disk_names = fs.readdirSync(disk_path).filter(fn=>fn.match(/GP.*dsk$/g));

//disk_names.forEach(dn=>extract_boot(dn));

disk_names.forEach(dn=>extract_ccp(dn, 0));
disk_names.forEach(dn=>extract_ccp(dn, 1));

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
    let howmany = 55; // 55 => 7168 files that fits from A400 to BFFF
    for(let ns=0; ns<=howmany; ns++) {
        let start = getpos(side, t, s);
        let sector = disk.slice(start,start+128).map(e=>(~e & 0xFF));
        sector.forEach(b=>ccp.push(b));

        s=s+1;
        if(s==27) {
            s=1;
            t++;
        }
    }

    let ccp_name = `${disk_name}.side${side}.ccp.bin`;

    fs.writeFileSync(ccp_name, new Uint8Array(ccp));

    console.log(`extracted ${ccp_name} from ${disk_name} side ${side}`);
}

