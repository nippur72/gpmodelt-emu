import { Config } from "./emulator";

// TODO make it more type safe
function getQueryStringObject(options: any) {
   let a = window.location.search.split("&");
   let o = a.reduce((o, v) =>{
      var kv = v.split("=");
      const key = kv[0].replace("?", "");
      let value: string|boolean = kv[1];
           if(value === "true") value = true;
      else if(value === "false") value = false;
      o[key] = value;
      return o;
   }, options);
   return o;
}

/*

Accepted querystring commands:

config=T08|T10|T20|POLY88
   T08: 64x16 with 2 x 5.25" disk drives (A:/B:,C:/D:)
   T10: 64x16 with 2 x 8" disk drives (A:/B:,C:/D:)
   T20: 80x25 with: 1 HDD SASI (A:), 1 FLOPPY SASI, 1 FLOPPY 8"

*/

export function getConfigFromQueryString(): Config {

   let config: Config = {
      model: "T20"
   };

   let options = getQueryStringObject({});

   /*
   if(options.load !== undefined) {
      let [name, address] = options.load.split(",");

      if(address !== undefined) address = parseInt(address, 16);

      setTimeout(()=>fetchProgram(name, address), 1000);
   }
   */

   let model = options.model == undefined ? "T20" : options.model.toUpperCase();

        if(model == "T20")    config.model = "T20";
   else if(model == "T05")    config.model = "T05";
   else if(model == "T08")    config.model = "T08";
   else if(model == "T10")    config.model = "T10";
   else if(model == "POLY88") config.model = "POLY88";
   // else if(model == "CHILDZ") config.model = "CHILDZ";

   /*
   if(options.bt !== undefined ||
      options.bb !== undefined ||
      options.bh !== undefined ||
      options.aspect !== undefined
   ) {
      if(options.bt     !== undefined) border_top       = Number(options.bt);
      if(options.bb     !== undefined) border_bottom    = Number(options.bb);
      if(options.bh     !== undefined) border_h         = Number(options.bh);
      if(options.aspect !== undefined) emulator.aspect  = Number(options.aspect);
      emulator.videoRenderer.calculateGeometry();
      onResize();
   }
   */

   return config;
}
