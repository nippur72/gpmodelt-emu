/*
class KeyboardBuffer {
   constructor() {
      this.buffer = [];
      this.active = false;
   }

   isEmpty() {
      return this.buffer.length == 0;
   }

   read() {
      if(this.isEmpty()) {
         return 0;
      } else {
         let c = this.buffer[0];
         this.buffer = this.buffer.slice(1);
         return c;
      }
   }

   write(c) {
      this.buffer.push(c);
   }
}

const keyboard_buffer = new KeyboardBuffer();
keyboard_buffer.active = false;
*/