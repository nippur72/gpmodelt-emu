class Tape {
   constructor(emulator) {
      this.emulator = emulator;

      // cload
      this.tapeSampleRate = 0;
      this.tapeBuffer = new Float32Array(0);
      this.tapeLen = 0;
      this.tapePtr = 0;
      this.tapeHighPtr = 0;      

      // csave
      this.csaveBufferSize = 44100 * 5 * 60; // five minutes max
      this.csaveBuffer;                      // holds the tape audio for generating the WAV file
      this.csavePtr;                         // points to the write position in the csaveo buffer 
      this.csaveDownSampleCounter;           // counter used to downsample from CPU speed to 48 Khz
      this.csaving = false;                  // is csaving in course
   }

   cloadAudioSamples(n) {
      if(this.tapePtr >= this.tapeLen) {
         this.emulator.cassette_bit_in = 1;
         return;
      }
   
      this.tapeHighPtr += (n*this.tapeSampleRate);
      if(this.tapeHighPtr >= emulator.cpuSpeed) {
         this.tapeHighPtr-=emulator.cpuSpeed;
         this.emulator.cassette_bit_in = this.tapeBuffer[this.tapePtr] > 0 ? 1 : 0;
         this.tapePtr++;      
      }
   }   

   cload(buffer, sampleRate) {
      this.tapeSampleRate = sampleRate;      
      this.tapeBuffer = buffer;
      this.tapeLen = this.tapeBuffer.length;
      this.tapePtr = 0;
      this.tapeHighPtr = 0;
   }

   rewind() {   
      this.tapePtr = 0;
      this.tapeHighPtr = 0;
   }
   
   stop() {   
      this.tapePtr = tapeLen;   
   }   
   
   csaveAudioSamples(n) {
      this.csaveDownSampleCounter += (n * 44100);
      if(this.csaveDownSampleCounter >= emulator.cpuSpeed) {
         const s = (this.emulator.cassette_bit_out1 && this.emulator.cassette_bit_out2 ? 0.75 : this.emulator.cassette_bit_out2 ? -0.75 : 0 );
         this.csaveDownSampleCounter -= emulator.cpuSpeed;
         this.csaveBuffer[this.csavePtr++] = s;
      }      
   }
   
   csave() {
      this.csavePtr = 0;
      this.csaveDownSampleCounter = 0;
      this.csaveBuffer = new Float32Array(this.csaveBufferSize);
      this.csaving = true;
      console.log("saving audio (max 5 minutes); use cstop() to stop recording");
   }
   
   cstop() {
      this.csaving = false;
   
      // trim silence before and after
      let start = this.csaveBuffer.indexOf(0.75)-100;
      let end   = this.csaveBuffer.lastIndexOf(0.75)+100;
   
      start = Math.max(start, 0);
      end   = Math.min(end, this.csaveBuffer.length);
   
      const audioData = this.csaveBuffer.slice(start, end);
      const length = Math.round(audioData.length / 44100);
   
      // TODO make samplerate constant
      const wavData = {
         sampleRate: 44100, 
         channelData: [ audioData ]
      };
        
      const buffer = encodeSync(wavData, { bitDepth: 16, float: false });      
      
      let blob = new Blob([buffer], {type: "application/octet-stream"});   
      const fileName = "csaved.wav";
      saveAs(blob, fileName);
      console.log(`downloaded "${fileName}" (${length} seconds of audio)`);
   }
}

