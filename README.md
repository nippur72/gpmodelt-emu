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

## EPROM routines

BF01 cursor row
BF02 last curso row
BF03 cursor column
BF04 last cursor column
BF05 80h=reverse, 00h=normal
BF06-BF07 cursor address in memory

BFE0 address to VDD cursor info table

E000    MONITOR monitor entry point
E003-4  pointer to VDD table

?? E003 VDR video driver, prints character in A
E3DC (E006??) KBDIN keyboard input, puts read key in A
E3FA (E009??) WRSTG write string, pointed by HL until a char with bit 7 turned on,
                    register A is destroyed, HL points to end of string
?? E00C PRTDVR printer driver, prints char in A (after CR or LF)
?? E00F INIZV inizializza il video
?? E012 INIZP inizializza la stampante
?? E015 PTBTE stampa BC in esadecimale (BC destroyed)
?? E018 TOGCUR toggle cursor

E40C NOBLK attende il sincronismo video per evitare il "brillio" durante l'accesso al video

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
3c-3f   PIO floppy
bc-bf   PIO floppy
5c-5f   PIO stampante
78-7b   PIO user 1 libera
6c-6f   PIO user 2 libera
74-77   PIO user 3 libera (ex ACI)
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
DF 1791 - Dati  (dovrebbe essere BF ???)

3fh: (in uscita)
    - Bit 0,1,2: selezione drive 001,010,100
    - Bit 3: selezione side (0=2.nda faccia)
    (in ingresso)
    - Bit 0, 1, 3: rilettura dati da uscita
    - Bit 5: Lettura linea HLD 1791
    - Bit 6: Lettura linea INTREQ 1791
    - Bit 7: Lettura linea DATA REQ 1791

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

