const fs = require('fs');

const { invert, write, emptydisk } = require("../../tools/fdc-pos");

let geometry = {
   NSIDES:     1,
   NTRACKS:    35,
   NSECTORS:   16,
   SECTORSIZE: 128
};

let bootsect = invert(fs.readFileSync("read_all_sec.bin"));
let disk     = emptydisk(geometry);

// fills with a pattern in the first two bytes of each sector
fill_with_pattern(disk, geometry);

// write the custom boot loader
write({
   disk,
   source: bootsect,
   side: 0,
   track: 0,
   sector: 1,
   geometry
});

let fname = `TEST_${geometry.NTRACKS}x${geometry.NSECTORS}x${geometry.SECTORSIZE}.img`;
fs.writeFileSync(fname, disk);

// *******************

function fill_with_pattern(disk, geometry) {
   for(let t=0; t<geometry.NTRACKS; t++) {
      for(let s=1; s<=geometry.NSECTORS; s++) {
         let source = new Uint8Array(invert([ s, t ]));
         write({
            disk,
            source,
            side: 0,
            track: t,
            sector: s,
            geometry
         });
      }
   }
}

