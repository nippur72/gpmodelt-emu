let emulator = new GPEmulator();

onResize();

// prints welcome message on the console
welcome();

parseQueryStringCommands();

power();

// calculate cpu speed
emulator.systemConfig();

// starts audio
goAudio();

// starts drawing frames
emulator.oneFrame();

// autoload program and run it
if(autoload !== undefined) {
   // gives 1 sec delay, so that load happens after ram is initialized by the eprom
   setTimeout(()=>loadBytes(autoload), 1000);
}

setTimeout(()=>load_default_disks(), 500);
