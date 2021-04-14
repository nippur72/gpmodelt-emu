# GENERAL PROCESSOR MODEL T emulator

## TIMINGS

System clock: 10 Mhz
CPU Speed: 2.5 Mhz (10 / 4)
Video: 640x312 dot pixels (512x208 active display)
Refresh: 50 Hz
Linerate: 15625 kHz
Character matrix: 8x13

## ROMS

### ROM SU MAIN BOARD

U1	E000..E3FF
U2	E400..E7FF
U3	E800..EBFF
U4	EC00..EFFF

DT49-48_U1.BIN     TMON ???             slot U1
ROM_MT16_U2.BIN    TMON ???             slot U2
FDC8-8_U3.BIN      floppy 8"            slot U3   (77 tracks*)
ROM-U3.BIN         floppy 5.25"         slot U3   (40 tracks*)
ACI_15-48_U4.BIN   interfaccia cassette slot U4

(*) le due EPROM differiscono per 4 bytes
    la EPROM 525 legge settori 0, quella da 8 no, come mai?

### ROM SCHEDA VIDEO

GCE_M1.U3          chargen 64x16        MEM BOARD  pixel riga da 0..7
GCE_M2.U4          chargen 64x16        MEM BOARD  pixel riga da 8..12
G-CAR-A_U7.BIN     chargen 80x24        MEM BOARD  pixel riga da 0..7
G-CAR-B_U8.BIN     chargen 80x24        MEM BOARD  pixel riga da 8..11?

## MEMORY MAP

0000 .. BFFF RAM utente
C000 .. CFFF RAM video  (replicata C400, C800, CC00)
D000 .. DFFF (non usato) espansione EPROM
E000 .. EFFF EPROM sistema
F000 .. FFFF (non usato) espansione EPROM

## TASTIERA

- Tasto BRK genera RESET sullo Z80
- I/O port $FF in sola lettura
- bit 0..6: carattera ASCII premuto (inverito)
- bit 7: 1=tasto premuto

## VIDEO

- 64x16 con matrice 8x13 a partire da C000 a c3FF
- 80x24 da C000 a CBFF, ogni riga 128 bytes (48 non usati)
- reverse: 7th bit=1 normale, 0=reverse

## I/O MAP

FF      Tastiera
3f      floppy porta drivesel
bc-bf   floppy
5c-5f   stampante parallela
78-7b   us1 seriale
6c-6f   us2 (possible HD)
74-77   us3 (ex ACI)
77      ACI

ordine delle porte PIO:
3c porta A DATI
3d porta B DATI
3e porta A CONTROLLO
3f porta B CONTROLLO

## PORTA FDC

BC 1791 - Comandi/status
BD 1791 - Traccia
BE 1791 - Settore
BF 1791 - Dati  

# PORTA DRIVESEL
3fh: (in uscita)
    - Bit 0,1,2: selezione drive 001,010,100
    - Bit 3: selezione side (0=2.nda faccia)
    - Bit 6: (solo 5.25 revisione ???) pilota DDEN
    (in ingresso)
    - Bit 0, 1, 3: rilettura dati da uscita
    - Bit 4: (undocumented) drive /READY
    - Bit 5: Lettura linea HLT 1791
    - Bit 6: Lettura linea INTREQ 1791
    - Bit 7: Lettura linea DATA REQ 1791

RICOSTRUZIONE DA SCHEDA FDC DELLA PORTA 3FH

bit         write                  read
=====================================================================
                LS374                  LS245
0           D0=>D5=>Q5=>DR SEL 0   D0<=Q6<=D6<=Q6 (latched DR SEL 0)
1           D1=>D4=>Q4=>DR SEL 1   D1<=Q7<=D7<=Q7 (latched DR SEL 1)
2           D2=>D6=>Q6=>DR SEL 2   D2<=Q7<=D7<=Q7 (latched DR SEL 2)
3           D3=>D8=>Q8=>SIDE SEL   D3<=Q4<=D4<=Q1 (latched SIDE SEL)
4           n.c.                   D4<=Q0<=D0<=DRIVE /READY
5           n.c.                   D5<=Q2<=D2<=n.c
6           D6=>D2=>n.c.           D6<=Q3<=D3<=INT REQ
7           n.c.                   D7<=Q5<=D5<=DATA REQ

la porta 3f serve per single side e per selezionare la faccia
la macchina vede A=1°drive side A, B=1°drive sideB, C=2°drivesideA e D_2°drive sideB

## PORTA 77h ACI CASSETTE (pag. 74 manuale utente)

In uscita:
0 - registrazione
1 - relè
2 - registrazione audio
3 - relè

In lettura:
0 - libero
1 - segnale registratore
2 - segnale video anti brillio
3 - segnale video anti brillio

## integrati usati

2114    RAM 1024 4bit words
2708    1K EPROM
74165   Parallel 8 Bit shift registers
7432    Quad 2-input OR gate
74LS245 3-STATE Octal Bus Transceiver

## 1791 notes

- /MR master reset is not connected
- /D0-/D7 are bit inverted
- DRQ (DATA REQUEST)
-     READ:  1=data is ready in data register
-     WRITE: 1=data register is empty
-     reset when CPU reads or writes the data register
- INTRQ set   to 1 when a command is completed
-       reset to 0 when reading the status register writing to command register
- HLT  (chiamato HLD nel manuale) set to 1 when the drive head is engaged
- Track register is incremented/decremented automatically when head steps
- /DDEN = 1 on the GP => single density (FM)
- STATUS REGISTER

- IBM 3470: 26 sectors per track, 128 bytes per sectors, 77 tracce

## porta seriale

porta 78h: read/write data

porta 7Ah
    read: bit 0 => data is ready to be read
          bit 3 => data can be written to output

## notes on CP/M

Mappatura dei dispositivi

- CON:
    read supports only keyboard
    write TTY: (default) e UC1: a video
    write CRT: is mapped to serial
    write BATCH is mapped to eprom printer

- LST:
    write TTY: eprom printer
    write CRT: is mapped to serial
    write LPT: eprom printer
    write UL1: video

- PUN: chiama LST:

- RDR: causa bug legge sempre da keyboard, richiede il seguente patch
       mem_write(0xBBCC, 0b00001100);
       mem_write(0xBBCE, 0b00000100);

# MISC

- print chr$(22)"00"    reverse
- print chr$(22)"80"    reverse off
- print chr$(12)        cls

# SA1004 disk geometry

units: A,B,C,D,E

A:
   512 settori per traccia 
   blocchi da 2048 bytes, 
   4063 blocchi => 8.321.024 bytes per i files CP/M
   directory tiene 575 files 
   1 traccia riservata per il sistema
   non prevede il cambio del supporto (disco fisso)
   non utilizza la skew table (no soft interleave)

B: 
   512 settori per traccia 
   blocchi da 16384 bytes
   71 blocchi => 1.163.264 bytes per i files CP/M
   directory tiene 63 files 
   1 traccia riservata per il sistema
   prevede il cambio del supporto (disco floppy?)
   non utilizza la skew table (no soft interleave)

C:   non utilizzato
D,E: floppy 8" standard tipo T08
