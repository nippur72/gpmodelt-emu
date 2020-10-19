# Content of the software directory

- "GP01_IMD.dsk" thru "GP23_IMD.dsk" are as set of disk images that
  were rescued with some original machines. They are standard 8" disks,
  (77 tracks, 26 sectors, 128 bytes/sector), more details in the
  file "GPModT - Lista Software.xls"

  TODO: compare the boot sector across all disks

- "minibasic_OK.wav" is the Minibasic V2.0 in cassette format for the Child Z,
  dumped by Piero Andreini and provided by Gianni Becattini.  
  It works on the Model T only if the keyboard is mapped to I/O port $D8 instead of $FF.
  The tape file contains 8193 bytes that are loaded at address $0000.
  This Basic seems to be a version adapted from CP/M because the first 256 bytes
  are empty and the first instruction is a "JP 0100H" suggesting it was originally
  a CPM ".com" file

- "minibasic.cas.0x0000.bin" the same Minibasic as above saved as binary file.















