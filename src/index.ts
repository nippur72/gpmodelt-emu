/*
   <script type="text/javascript" src="node_modules/@nippur72/libemu/FileSaver.js"></script>
   <script type="text/javascript" src="node_modules/@nippur72/libemu/idb-keyval-iife.min.js"></script>
   <script type="text/javascript" src="node_modules/@nippur72/libemu/wav-decoder.js"></script>
   <script type="text/javascript" src="node_modules/@nippur72/libemu/wav-encoder.js"></script>
   <script type="text/javascript" src="node_modules/@nippur72/libemu/Z80.js"></script>
   <script type="text/javascript" src="node_modules/@nippur72/libemu/printer.js"></script>
   <script type="text/javascript" src="node_modules/@nippur72/libemu/bytes.js"></script>
   <script type="text/javascript" src="node_modules/@nippur72/libemu/filesystem.js"></script>
   <script type="text/javascript" src="node_modules/@nippur72/libemu/bbs.js"></script>
   <script type="text/javascript" src="node_modules/@nippur72/libemu/audio.js"></script>
*/

import { GPEmulator } from "./emulator";
import { getQueryStringConfig } from "./options";
import { publishGlobal } from "./console";

import { createElement } from "react";
import { render } from "react-dom";
import { initializeIcons } from "@fluentui/react";

import { Gui } from "./gui";

async function main() {
   let config = getQueryStringConfig();

   let emulator = new GPEmulator(config);

   emulator.browser.onResize();   // force recalc of geometry
   emulator.systemConfig();       // calculate cpu speed
   emulator.power();              // reset memory
   emulator.audio.start();        // starts audio
   emulator.oneFrame(0);          // starts drawing frames

   await emulator.attach_media();

   publishGlobal(emulator);

   // Register icons and pull the fonts from the default SharePoint cdn.
   initializeIcons();
   const mountNode = document.getElementById("mountnode");
   render(createElement(Gui), mountNode);
}

main();


