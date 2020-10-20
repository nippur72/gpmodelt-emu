const fs = require('fs');

let image = fs.readFileSync("GP02_IMD.img");

//let truncated = image.slice(0, 16384);

let inverted = image.map(e=>(~e & 0xFF));

fs.writeFileSync("GP02_IMD.inverted.bin", inverted);

