let FDC_NSIDES     = 2;
let FDC_NTRACKS    = 77;
let FDC_NSECTORS   = 26;
let FDC_SECTORSIZE = 128;
let FDC_MEDIA_SIZE = FDC_SECTORSIZE * FDC_NSECTORS * FDC_NSIDES * FDC_NTRACKS;

// data is assumed to be stored on the media:
// track 0 side 0 [ sectors 0-26 ], track 0 side 1 [ sectors 0-26 ], ...

function FDC_getpos(side, track, sector) {

   let s = sector -1;
   if(s<0) s=0;

   let pos = track * FDC_NSIDES * FDC_SECTORSIZE * FDC_NSECTORS;
   pos += side * FDC_SECTORSIZE * FDC_NSECTORS;
   pos += s * FDC_SECTORSIZE;

   return pos;
}

function FDC_getpos_geometry(side, track, sector, geometry) {

   let s = sector -1;
   if(s<0) s=0;

   let pos = track * geometry.NSIDES * geometry.SECTORSIZE * geometry.NSECTORS;
   pos += side * geometry.SECTORSIZE * geometry.NSECTORS;
   pos += s * geometry.SECTORSIZE;

   return pos;
}

module.exports = { FDC_getpos, FDC_getpos_geometry };

