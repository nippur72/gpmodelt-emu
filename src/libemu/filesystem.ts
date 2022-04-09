import { createStore, get, set, del, keys, UseStore } from "idb-keyval";
import { saveAs } from "file-saver";

class BrowserStorage
{
   STORAGE_KEY: string;
   store: UseStore;

   constructor(key: string) {
      this.STORAGE_KEY = key;
      this.store = createStore(this.STORAGE_KEY, this.STORAGE_KEY);
   }

   // ===================== private methods ============================================

   async readFile(fileName: string): Promise<Uint8Array> {
      const bytes = await get<number[]>(fileName, this.store);
      if(bytes !== undefined) return new Uint8Array(bytes);
      throw `${fileName} not found`;
   }

   async writeFile(fileName: string, bytes: Uint8Array) {
      await set(fileName, bytes, this.store);
   }

   async removeFile(fileName: string) {
      await del(fileName, this.store);
   }

   async fileExists(fileName: string) {
      return await get(fileName, this.store) !== undefined;
   }

   // ===================== command line commands ======================================

   async dir() {
      const fileNames: string[] = await keys(this.store);
      fileNames.forEach(async fn=>{
         const file = await this.readFile(fn);
         const length = file.length;
         console.log(`${fn} (${length} bytes)`);
      });
   }

   async remove(filename: string) {
      if(await this.fileExists(filename)) {
         await this.removeFile(filename);
         console.log(`removed "${filename}"`);
      }
      else {
         console.log(`file "${filename}" not found`);
      }
   }

   async download(fileName: string) {
      if(!await this.fileExists(fileName)) {
         console.log(`file "${fileName}" not found`);
         return;
      }
      const bytes = await this.readFile(fileName);
      let blob = new Blob([bytes], {type: "application/octet-stream"});
      saveAs(blob, fileName);
      console.log(`downloaded "${fileName}"`);
   }

   async upload(fileName: string) {
      throw "not impemented";
   }
}

export { BrowserStorage };

