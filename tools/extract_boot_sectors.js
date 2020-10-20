const fs = require('fs');
const getpos = require("./fdc-pos");

// read all disks
let disk_path = "../software";
let disk_names = fs.readdirSync(disk_path).filter(fn=>fn.match(/GP.*dsk$/g));

disk_names.forEach(dn=>extract_boot(dn));

function extract_boot(disk_name) {
    let disk = fs.readFileSync(`${disk_path}/${disk_name}`);

    let boot_sector = disk.slice(0,128).map(e=>(~e & 0xFF));
    let boot_name = `${disk_name}.boot.bin`;

    fs.writeFileSync(boot_name, boot_sector);

    console.log(`extracted ${boot_name} from ${disk_name}`);
}






