/* BBS - connect to a WebSocket tunneled BBS

   Basic usage:

      let modem = new BBS();

      modem.onreceive = (data) => {
         console.log(data);
         modem.disconnect();
      }

      await modem.connect();
      modem.sendText("hello");
      modem.send([1,2,3]);
      modem.disconnect();
*/

// wstcp -t bbs.sblendorio.eu -p 23 -w 8080 -n bbs

class BBS {
   connected: boolean = false;                          // connected status
   ws_connection: WebSocket | undefined = undefined;    // the WebSocket connection
   onreceive: ((data: Uint8Array)=>void) | undefined;   // user defined callback when data is received
   debug: boolean = false;                              // debug flag

   async connect(url: string, protocol: string) {
      return new Promise((resolve,reject)=>{
         if(url === undefined) url = "wss://bbs.sblendorio.eu:8080";
         if(protocol === undefined) protocol = "bbs";

         if(this.connected) {
            if(this.debug) console.log("BBS: already connected");
            reject("already connected");
         }

         // create the WebSocket connection
         this.ws_connection = new WebSocket(url, protocol);
         this.ws_connection.onerror = (err) => this.onerror(err);
         this.ws_connection.onclose = () => this.onclose();
         this.ws_connection.onmessage = (e) => this.onmessage(e);
         this.ws_connection.onopen = () => {
            this.connected = true;
            if(this.debug) console.log("websocket: connected");
            resolve("connected");
         }
      });
   }

   onerror(err: Event) {
      if(this.debug) console.log('websocket: connection error');
      this.connected = false;
   }

   onclose() {
      if(this.debug) console.log('websocket: disconnected');
      this.connected = false;
   }

   // function called when bytes are received from the WebSocket
   async onmessage(e: MessageEvent) {
      if(!this.connected) return;

      if (typeof e.data === 'string') {
         if(this.debug) console.log("Received string: '" + e.data + "'");
      }
      else {
         // note: this fails on FireFox 83 due to Blob.arrayBuffer()
         // promise: the "await" results in bytes decoded
         // but with wrong timestamp order. Solved with patch-arrayBuffer.js
         let data = await e.data.arrayBuffer();
         let bytes = new Uint8Array(data);
         if(this.onreceive !== undefined) {
            this.onreceive(bytes);
         }
         if(this.debug) console.log(`websocket: received ${bytes.length} bytes`, this.array2String(bytes));
      }
   }

   send(data: number[]) {
      if(!this.connected || this.ws_connection === undefined) {
         if(this.debug) console.log("websocket: can't send because not connected");
         return;
      }

      let bytes = new Uint8Array(data);
      if(this.ws_connection.readyState === this.ws_connection.OPEN) {
         //console.log(`transmitting ${bytes.length} bytes`);
         this.ws_connection.send(bytes);
         if(this.debug) console.log(`websocket: sent ${bytes.length} bytes`, this.array2String(bytes));
      }
      else {
         if(this.debug) console.log("websocket: can't send because disconnected");
      }
   }

   sendText(text: string) {
      this.send(this.string2Array(text));
   }

   disconnect() {
      if(this.ws_connection !== undefined) {
         this.ws_connection.close();
      }
   }

   string2Array(str: string): number[] {
      let arr = [];
      for(let t=0; t<str.length; t++)
         arr.push(str.charCodeAt(t) & 0xFF);
      return arr;
   }

   array2String(data: number[]|Uint8Array): string {
      let str = "";
      for(var index=0; index<data.length; index++)
         str += String.fromCharCode(data[index]);
      return str;
   }
}

export { BBS };