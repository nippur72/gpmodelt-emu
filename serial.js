class Serial
{
   constructor() {
      this.output = [];
      this.recbuf = [];
   }

   receive() {
      if(this.recbuf.length > 0) {
         let ch = this.recbuf[0];
         this.recbuf = this.recbuf.slice(1);
         return ch;
      }
      return 0x00; // receive buffer empty
   }

   receiveStatus() {
      return 4+1;
      //if(this.recbuf.length > 0) return 4+1;
      //else return 0;
   }

   readyToSend(value) {

   }

   send(data) {
      //this.output.push(data);
      printerWrite(data);
   }
}

serial = new Serial();
