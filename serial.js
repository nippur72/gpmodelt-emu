class Serial
{
   constructor() {
      this.output = [];
      this.recbuf = [];
   }

   cpu_read_data() {
      if(this.recbuf.length > 0) {
         let ch = this.recbuf[0];
         this.recbuf = this.recbuf.slice(1);
         return ch;
      } else {
         return 0x00; // receive buffer empty
      }
   }

   cpu_read_status() {
      if(this.recbuf.length > 0) {
         return 8+1;
      }
      else {
         return 8;
      }
   }

   cpu_write_data(data) {
      //this.output.push(data);
      printerWrite(data);
   }

   cpu_write_command(command) {
      // ignored
   }
}

serial = new Serial();
