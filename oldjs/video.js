class VideoRenderer {
   constructor() {
      this.video_ram = 0xC000;       // video page address in RAM

      this.palette = new Palette();

      this.foreground_color = 10;
      this.background_color = 8;
      this.border_color     = 8;

      this.raster_y = 0;        // 0 to TOTAL SCANLINES (0-311) 
      
      this.canvas = undefined; 
      this.canvasContext = undefined;
      this.imageData = undefined;
      this.bmp = undefined;

      this.SCREEN_COLUMNS     = 80;
      this.SCREEN_ROWS        = 24;
      this.SCREEN_COLUMNS_ARR = 128;

      this.TEXT_W = undefined;
      this.TEXT_H = undefined;

      this.BORDER_V = undefined;
      this.BORDER_V_BOTTOM = undefined;
      this.BORDER_H = undefined;

      this.DOUBLE_SCANLINES = 2;

      this.SCREEN_W = undefined;
      this.SCREEN_H = undefined;
   }

   calculateGeometry() {

      this.TEXT_W = this.SCREEN_COLUMNS * 8;
      this.TEXT_H = this.SCREEN_ROWS    * 13;
   
      this.BORDER_V        = 10;
      this.BORDER_V_BOTTOM = 10;
      this.BORDER_H = 15;
      this.SCREEN_W = this.BORDER_H + this.TEXT_W + this.BORDER_H;
      this.SCREEN_H = this.BORDER_V + this.TEXT_H + this.BORDER_V_BOTTOM;
      this.DOUBLE_SCANLINES = 2;
      //TOTAL_SCANLINES = this.BORDER_V + this.TEXT_H + this.BORDER_V_BOTTOM; // must be 312
   
      // canvas is the outer canvas where the aspect ratio is corrected
      this.canvas = document.getElementById("canvas");
      this.canvas.width = this.SCREEN_W;
      this.canvas.height = this.SCREEN_H * this.DOUBLE_SCANLINES;
      this.canvasContext = this.canvas.getContext('2d');
   
      this.imageData = this.canvasContext.createImageData(this.SCREEN_W, this.SCREEN_H * this.DOUBLE_SCANLINES);
      this.bmp = new Uint32Array(this.imageData.data.buffer);   
   }   

   drawFrame_y()
   {
      if(this.raster_y < this.SCREEN_H) {
         this.drawFrame_y_text(this.raster_y - this.BORDER_V);
         this.drawFrame_y_border(this.raster_y);
      }
      this.raster_y++;
      if(this.raster_y >= this.SCREEN_H) {  // TODO numscanlines
         this.raster_y = 0; 
         this.canvasContext.putImageData(this.imageData, 0, 0);
      }
   }
   
   drawFrame_y_border(y) 
   {
      // draw borders
      for(let x=0; x<this.SCREEN_W; x++) {
         const inside = y>=this.BORDER_V && y<(this.BORDER_V+this.TEXT_H) && x>=this.BORDER_H && x<this.BORDER_H+this.TEXT_W;
         if(!inside)
         {
            this.setPixelBorder(x,y, this.border_color);
         }
      }
   }
   
   drawFrame_y_text(y) {           
      let lines_per_char = 13;
   
      let y_offset = y % lines_per_char;
      let row = (y - y_offset) / lines_per_char;
   
      let charset;
      let set1,set2;
   
      if(emulator.charset_bit)
      {
         set1 = rom_GCE_M1_U3;
         set2 = rom_GCE_M2_U4;
      }
      else
      {
         set1 = rom_GCAR_A_U7;
         set2 = rom_GCAR_B_U8;
      }
   
      for(let x=0; x<this.SCREEN_COLUMNS; x++)
      {
         let code = emulator.memory[this.video_ram+(row*this.SCREEN_COLUMNS_ARR)+x];
   
         let reverse = ((code & 128) >> 7) == 0;
         let fg = this.foreground_color;
         let bg = this.background_color;
         code = code & 127;
   
         let bitmap = 0;
         if(code < 64)
         {
            charset = set1;
            if(y_offset < 8 ) bitmap = charset[code * 8 + y_offset];
            else              bitmap = charset[code * 8 + (y_offset-8) + 64*8];
         }
         else
         {
            charset = set2;
            if(y_offset < 8 ) bitmap = charset[(code-64) * 8 + y_offset];
            else              bitmap = charset[(code-64) * 8 + (y_offset-8) + 64*8];
         }
   
         // poly 88 patch 0123 45678 9012
         if(emulator.poly88) {
            if(reverse) {
               bitmap = 0;
   
                    if(y_offset <  4) { if(code & (1<<2)) bitmap |= 0b00001111; if(code & (1<<5)) bitmap |= 0b11110000; }
               else if(y_offset <  9) { if(code & (1<<1)) bitmap |= 0b00001111; if(code & (1<<4)) bitmap |= 0b11110000; }
               else if(y_offset < 13) { if(code & (1<<0)) bitmap |= 0b00001111; if(code & (1<<3)) bitmap |= 0b11110000; }
            }
            else reverse=1;
         }
   
         for(let xx=0;xx<8;xx++) {
            let pixel_color;
            
            if(reverse == 0) pixel_color = (bitmap & (128>>xx)) > 0 ? fg : bg;
            else             pixel_color = (bitmap & (128>>xx)) > 0 ? bg : fg;
            this.setPixel640(x*8+xx, y, pixel_color);
         }
      }
   }
   
   setPixelBorder(x, y, color) {      
      const c0 = this.palette.palette[color];   
      const c1 = this.palette.palette[color];
      const ptr0 = ((y*2)+0) * this.SCREEN_W + x;
      const ptr1 = ((y*2)+1) * this.SCREEN_W + x;
      this.bmp[ ptr0 ] = c0;      
      this.bmp[ ptr1 ] = c1;      
   }
   
   setPixel640(x, y, color) {
      const c0 = this.palette.palette[color];   
      const c1 = color === 8 ? this.palette.palette[color] : this.palette.halfpalette[color];
      const xx = x + this.BORDER_H;
      const yy = (y + this.BORDER_V)*2;
      const ptr0 = (yy+0) * this.SCREEN_W + xx;
      const ptr1 = (yy+1) * this.SCREEN_W + xx;
      this.bmp[ ptr0 ] = c0;
      this.bmp[ ptr1 ] = c1;
   }
}

class Palette {
   constructor() {
      this.palette = new Uint32Array(16);
      this.halfpalette = new Uint32Array(16);
      this.saturation = 1.0;  
      this.hide_scanlines = false;
      this.show_scanlines = true;            
   }
   
   applySaturation(r,g,b, s) {      
      const L = 0.3*r + 0.6*g + 0.1*b;
      const new_r = r + (1.0 - s) * (L - r);
      const new_g = g + (1.0 - s) * (L - g);
      const new_b = b + (1.0 - s) * (L - b);
      return { r: new_r, g: new_g, b: new_b };
   }

   setPalette(i,r,g,b) { 
      let color = this.applySaturation(r,g,b, this.saturation);
      this.palette[i] = 0xFF000000 | color.r | color.g << 8 | color.b << 16; 
      this.halfpalette[i] = 0xFF000000 | ((color.r/1.1)|0) | ((color.g/1.1)|0) << 8 | ((color.b/1.1)|0) << 16;
      if(i==8) this.halfpalette[i] = 0xFF000000 | ((color.r/1.1)|0) | ((color.g/1.1)|0) << 8 | ((color.b/1.1)|0) << 16;
      if(this.hide_scanlines || !this.show_scanlines) this.halfpalette[i] = this.palette[i];
   }

   buildPalette() {      
      this.setPalette( 0, 0x00, 0x00, 0x00);  /* black */
      this.setPalette( 1, 0x00, 0x00, 0xff);  /* blue */
      this.setPalette( 2, 0x00, 0x80, 0x00);  /* green */
      this.setPalette( 3, 0x00, 0x90, 0xff);  /* cyan */
      this.setPalette( 4, 0x60, 0x00, 0x00);  /* red */
      this.setPalette( 5, 0x80, 0x30, 0xf0);  /* magenta */
      this.setPalette( 6, 0x6c, 0x87, 0x01);  /* yellow */
      this.setPalette( 7, 0xc0, 0xc0, 0xc0);  /* bright grey */
      this.setPalette( 8, 0x25, 0x25, 0x25);  /* dark grey */
      this.setPalette( 9, 0x80, 0x80, 0xff);  /* bright blue */
      this.setPalette(10, 0x50, 0xFF, 0x50);  /* bright green */
      this.setPalette(11, 0x87, 0xc5, 0xff);  /* bright cyan */
      this.setPalette(12, 0xed, 0x50, 0x8c);  /* bright red */
      this.setPalette(13, 0xff, 0x90, 0xff);  /* bright magenta */
      this.setPalette(14, 0xdf, 0xdf, 0x60);  /* bright yellow */
      this.setPalette(15, 0xff, 0xff, 0xff);  /* white */
   }
}

