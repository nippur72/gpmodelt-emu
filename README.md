# GENERAL PROCESSOR MODEL T emulator

## Z80

24 / 7


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

E000    MONITOR   monitor entry point
E003-4  pointer to VDD table

?? E003 VDR       video driver, prints character in A
E3DC (E006??) KBDIN keyboard input, puts read key in A
E3FA (E009??) WRSTG write string, pointed by HL until a char with bit 7 turned on,
                    register A is destroyed, HL points to end of string
?? E00C PRTDVR    printer driver, prints char in A (after CR or LF)
?? E00F INIZV     inizializza il video
?? E012 INIZP     inizializza la stampante
?? E015 PTBTE     stampa BC in esadecimale (BC destroyed)
?? E018 TOGCUR    toggle cursor

E40C NOBLK

## TASTIERA

- Tasto BRK genera RESET sullo Z80

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
    - Bit 0 ed 1: selezione drive (0=drive 0)
    - Bit 3: selezione side (0=2.nda faccia)
    (in ingresso)
    - Bit 0, 1, 3: rilettura dati da uscita
    - Bit 5: Lettura linea HLD 1791
    - Bit 6: Lettura linea INTREQ 1791
    - Bit 7: Lettura linea DATA REQ 1791

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

