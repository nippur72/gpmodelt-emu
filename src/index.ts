import { GPEmulator } from "./emulator";
import { getConfigFromQueryString } from "./options";
import { publishGlobal } from "./console";

import { createElement } from "react";
import { createRoot } from "react-dom/client";
import { initializeIcons } from "@fluentui/react";

import { Gui } from "./gui";

async function main() {
   let config = getConfigFromQueryString();

   let emulator = new GPEmulator();
   emulator.configure(config.model);

   //emulator.browser.onResize();   // force recalc of geometry
   emulator.power();              // reset memory
   emulator.audio.start();        // starts audio
   emulator.oneFrame(0);          // starts drawing frames

   await emulator.attach_media();

   publishGlobal(emulator);

   // Register icons and pull the fonts from the default SharePoint cdn.
   initializeIcons();
    const mountNode = document.getElementById("mountnode");
    if (mountNode) {
       const root = createRoot(mountNode);
       root.render(createElement(Gui));
    }
}

main();


