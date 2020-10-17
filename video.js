// ChildZ screen geometry: 640 x 321 (512x208 visible)

let border_top = undefined;
let border_bottom = undefined;
let border_h = undefined;
let aspect = 1.55;

const TEXT_W = 512; 
const TEXT_H = 208;

let HIDDEN_SCANLINES_TOP;
let HIDDEN_SCANLINES_BOTTOM;

let BORDER_V;
let BORDER_V_BOTTOM;
let BORDER_H;    
let SCREEN_W;
let SCREEN_H;
let DOUBLE_SCANLINES = 2;
let TOTAL_SCANLINES = HIDDEN_SCANLINES_TOP + BORDER_V + TEXT_H + BORDER_V_BOTTOM + HIDDEN_SCANLINES_BOTTOM;

let canvas, canvasContext;
let screenCanvas, screenContext;
let imageData, bmp;

let saturation = 1.0;

function calculateGeometry() {
   if(border_top    !== undefined && (border_top    > 35 || border_top    < 0)) border_top    = undefined;
   if(border_bottom !== undefined && (border_bottom > 35 || border_bottom < 0)) border_bottom = undefined;
   if(border_h      !== undefined && (border_h      > 15 || border_h      < 0)) border_h      = undefined;

   BORDER_V        = (border_top    !== undefined ? border_top    : 10);
   BORDER_V_BOTTOM = (border_bottom !== undefined ? border_bottom : 10);   
   HIDDEN_SCANLINES_TOP    = 35 - BORDER_V; 
   HIDDEN_SCANLINES_BOTTOM = 35 - BORDER_V_BOTTOM;   
   BORDER_H = border_h !== undefined ? border_h : 15;    
   SCREEN_W = BORDER_H + TEXT_W + BORDER_H;
   SCREEN_H = BORDER_V + TEXT_H + BORDER_V_BOTTOM;
   DOUBLE_SCANLINES = 2;
   TOTAL_SCANLINES = HIDDEN_SCANLINES_TOP + BORDER_V + TEXT_H + BORDER_V_BOTTOM + HIDDEN_SCANLINES_BOTTOM; // must be 312

   // canvas is the outer canvas where the aspect ratio is corrected
   canvas = document.getElementById("canvas");
   canvas.width = SCREEN_W;
   canvas.height = SCREEN_H * DOUBLE_SCANLINES;
   canvasContext = canvas.getContext('2d');

   // screen is the inner canvas that contains the emulated PAL screen
   screenCanvas = document.createElement("canvas");
   screenCanvas.width = SCREEN_W;
   screenCanvas.height = SCREEN_H * DOUBLE_SCANLINES;
   screenContext = screenCanvas.getContext('2d');

   imageData = screenContext.getImageData(0, 0, SCREEN_W, SCREEN_H * DOUBLE_SCANLINES);
   
   bmp = new Uint32Array(imageData.data.buffer);   
}

calculateGeometry();

const palette = new Uint32Array(16);
const halfpalette = new Uint32Array(16);

let hide_scanlines = false;
let show_scanlines = true;
let charset_offset = 0;

function buildPalette() {
   function applySaturation(r,g,b, s) {      
      const L = 0.3*r + 0.6*g + 0.1*b;
      const new_r = r + (1.0 - s) * (L - r);
      const new_g = g + (1.0 - s) * (L - g);
      const new_b = b + (1.0 - s) * (L - b);
      return { r: new_r, g: new_g, b: new_b };
   }

   function setPalette(i,r,g,b) { 
      let color = applySaturation(r,g,b, saturation);
      palette[i] = 0xFF000000 | color.r | color.g << 8 | color.b << 16; 
      halfpalette[i] = 0xFF000000 | ((color.r/2.0)|0) | ((color.g/2.0)|0) << 8 | ((color.b/2.0)|0) << 16;
      if(i==8) halfpalette[i] = 0xFF000000 | ((color.r/1.1)|0) | ((color.g/1.1)|0) << 8 | ((color.b/1.1)|0) << 16;
      if(hide_scanlines || !show_scanlines) halfpalette[i] = palette[i];
   }

   setPalette( 0, 0x00, 0x00, 0x00);  /* black */
   setPalette( 1, 0x00, 0x00, 0xff);  /* blue */
   setPalette( 2, 0x00, 0x80, 0x00);  /* green */
   setPalette( 3, 0x00, 0x90, 0xff);  /* cyan */
   setPalette( 4, 0x60, 0x00, 0x00);  /* red */
   setPalette( 5, 0x80, 0x30, 0xf0);  /* magenta */
   setPalette( 6, 0x6c, 0x87, 0x01);  /* yellow */
   setPalette( 7, 0xc0, 0xc0, 0xc0);  /* bright grey */
   setPalette( 8, 0x25, 0x25, 0x25);  /* dark grey */
   setPalette( 9, 0x80, 0x80, 0xff);  /* bright blue */
   setPalette(10, 0x50, 0xFF, 0x50);  /* bright green */
   setPalette(11, 0x87, 0xc5, 0xff);  /* bright cyan */
   setPalette(12, 0xed, 0x50, 0x8c);  /* bright red */
   setPalette(13, 0xff, 0x90, 0xff);  /* bright magenta */
   setPalette(14, 0xdf, 0xdf, 0x60);  /* bright yellow */
   setPalette(15, 0xff, 0xff, 0xff);  /* white */
}

const foreground_color = 10;
const background_color = 0;
const border_color     = 8;

// #region rendering at the cycle level

let raster_y = 0;        // 0 to TOTAL SCANLINES (0-311)
let raster_x = 0;        // 0 to SCREEN_W (720)
let raster_y_text = 0;   // y relative to display area
let raster_x_text = 0;   // x relative to display area


const TEXT_V_START = 65;                   // line number (0-based) where the active area starts
const TEXT_V_END   = TEXT_V_START + 192;   // line number (0-based) where the active area ends
const TEXT_H_START = 40;                   // pixel number (0-based) where the active area starts horizontally
const TEXT_H_END   = TEXT_H_START + 640;   // pixel number (0-based) where the active area starts horizontally

// #region rendeding at scanline level

// (not used) draws the whole frame 
function drawFrame() {
   for(let t=0;t<SCREEN_H;t++) {
      drawFrame_y(raster_y);      
   }
}

function drawFrame_y()
{
   drawFrame_y_text(raster_y - BORDER_V);
   drawFrame_y_border(raster_y);
   raster_y++;
   if(raster_y >= SCREEN_H) {
      raster_y = 0; 
      updateCanvas();     
   }
}

function updateCanvas() {
   canvasContext.putImageData(imageData, 0, 0);
   canvasContext.drawImage(screenCanvas, 0, 0, canvas.width, canvas.height);
}

function drawFrame_y_border(y) 
{
   // draw borders
   for(let x=0; x<SCREEN_W; x++) {
      const inside = y>=BORDER_V && y<(BORDER_V+TEXT_H) && x>=BORDER_H && x<BORDER_H+TEXT_W;
      if(!inside)
      {
         setPixelBorder(x,y, border_color);
      }
   }
}

const video_ram = 0xC000;

let charset_bit = 1;

function drawFrame_y_text(y) 
{           
   let lines_per_char = 13;

   let y_offset = y % lines_per_char;
   let row = (y - y_offset) / lines_per_char;

   let charset;
   let set1,set2;

   if(charset_bit)
   {
      set1 = rom_GCE_M1_U3;
      set2 = rom_GCE_M2_U4;
   }
   else
   {
      set1 = rom_GCAR_A_U7;
      set2 = rom_GCAR_B_U8;
   }

   for(let x=0; x<64; x++)
   {
      let code = memory[video_ram+(row*64)+x];

      let reverse = ((code & 128) >> 7) == 0;
      let fg = 10;
      let bg = 8;
      code = code & 127;


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

      for(let xx=0;xx<8;xx++) {
         let pixel_color;
         
         if(reverse == 0) pixel_color = (bitmap & (128>>xx)) > 0 ? fg : bg;
         else             pixel_color = (bitmap & (128>>xx)) > 0 ? bg : fg;
         setPixel640(x*8+xx, y, pixel_color);
      }
   }
}

// #endregion 


// double scanline drawing routines

function setPixelBorder(x, y, color) {      
   const c0 = palette[color];   
   const c1 = halfpalette[color];   
   const ptr0 = ((y*2)+0) * SCREEN_W + x;   
   const ptr1 = ((y*2)+1) * SCREEN_W + x;      
   bmp[ ptr0 ] = c0;      
   bmp[ ptr1 ] = c1;      
}

function setPixel640(x, y, color) {
   const c0 = palette[color];   
   const c1 = halfpalette[color];   
   const xx = x + BORDER_H;
   const yy = (y + BORDER_V)*2;
   const ptr0 = (yy+0) * SCREEN_W + xx;
   const ptr1 = (yy+1) * SCREEN_W + xx;
   bmp[ ptr0 ] = c0;
   bmp[ ptr1 ] = c1;
}

function setPixel320(x, y, color) {   
   const c0 = palette[color];   
   const c1 = halfpalette[color];   
   const yy = (y + BORDER_V) * 2;
   let ptr0 = (yy+0) * SCREEN_W + x*2 + BORDER_H;
   let ptr1 = (yy+1) * SCREEN_W + x*2 + BORDER_H;
   bmp[ ptr0++ ] = c0;
   bmp[ ptr0   ] = c0;
   bmp[ ptr1++ ] = c1;
   bmp[ ptr1   ] = c1;
}

