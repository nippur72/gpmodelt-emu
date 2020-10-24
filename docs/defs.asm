; **** CPM 2.2 ****

; low RAM workspace
WARMRESET   EQU $0000   ; ricarica il CP/M JP BA03 (WARM BOOT IN JUMP TABLE)
IOBYTE      EQU $0003   ; IO byte
DEFDRIVE    EQU $0004   ; default drive
JUMPTOBDOS  EQU $0005   ; (3 bytes) JP BDOS

; CPM addresses
STARTCCP    EQU $A400   ; start of CCP in memory
STARTBIOS   EQU $BA00   ; start of bios in memory

; CPM bios RAM workspace
NUM_RETRY   EQU $BA54  ; number of write retry attempts
DPH         EQU $BA68  ; DPH ? disk parameter header
DPB         EQU $BAC2  ; DPB disk parameter block
BUFEPROM    EQU $BDA5  ; (128 bytes) sector buffer for disk eprom routines
CRSROW      EQU $BF01  ; cursor row (used by the eprom routines)
LASTCROW    EQU $BF02  ; last cursor row (used by the eprom routines)
CRSCOL      EQU $BF03  ; cursor column (used by the eprom routines)
LASTCCOL    EQU $BF04  ; last cursor column (used by the eprom routines)
REVERSE     EQU $BF05  ; 80h=reverse, 00h=normal
CSRADDR     EQU $BF06  ; (word) cursor address in memory (used by the eprom routines)
TMPREGSP    EQU $BFD0  ; (word) saves sp register
TMPREGHL    EQU $BFD2  ; (word) saves hl register
TMPREGDE    EQU $BFD4  ; (word) saves de register
TMPREGBC    EQU $BFD6  ; (word) saves bc register
TMPREGA     EQU $BFD8  ; (byte) saves a register
CURTRACK    EQU $BFDA  ; current track
CURRSEC     EQU $BFDB  ; current sector
CURRDRIVE   EQU $BFDC  ; current drive number (0..3)
BUFADDR     EQU $BFDE  ; (word) address of sector buffer for DMA
VDDTABLE    EQU $BFE0  ; start of VDD table, usually loaded into IX. Also pointed by VDDPOINTER
LAST_TRACK  EQU $BFEC  ; last used track
VIDEORAM    EQU $C000  ; start of video RAM

; VDD TABLE IX+00h .. IX+10h where IX usually is $BFE0

;
EPROM_CURRDRIVE EQU $09  ; current drive for eprom routines
;

; **** EPROM ****

MONITOR           EQU $E000    ; monitor entry point
VDDPOINTER        EQU $E003    ; (word) address of the VDD table in memory (usually contains $BFE0)
KBDIN             EQU $E3DC    ; keyboard input, puts read key in A
WRSTG             EQU $E3FA    ; prints string in HL until char with 7 bit on
;PRTDVR            EQU ??       ; printer driver, prints char in A (after CR or LF)
;INIZV             EQU ??       ; E00F? inizializza il video
;INIZP             EQU ??       ; E012? inizializza la stampante
;PTBTE             EQU ??       ; E015? stampa BC in esadecimale (BC destroyed)
;TOGCUR            EQU ??       ; E018? toggle cursor
NOBLK             EQU $E40C    ; attende il sincronismo video per evitare il "brillio" durante l'accesso al video
;??                EQU $E650    ; ?? chiamata dall jump table del CBIOS, legge/scrive su 5Ch/5Dh
;??                EQU $E800    ; used by CBIOS
;??                EQU $E80C    ; used by CBIOS
;??                EQU $E82A    ; used by CBIOS
EPROM_SETDRIVE    EQU $E809    ; drive in C
EPROM_SETTRACK    EQU $E803    ; track in C
EPROM_SETSECTOR   EQU $E806    ; sector in C
EPROM_WRITESECTOR EQU $E80F
EPROM_READSECTOR  EQU $E812
BOOT_FROM_DISK    EQU $EB1C

; **** IO PORTS ****

KEYBOARD  EQU $FF    ; porta tastiera
CASSETTE  EQU $77    ; porta cassetta e sincronismi video
DRIVESEL  EQU $3F    ; selezione drive number e side
FDCCMD    EQU $BC    ; 1791 - Comandi/status
FDCTRK    EQU $BD    ; 1791 - Traccia
FDCSEC    EQU $BE    ; 1791 - Settore
FDCDATA   EQU $BF    ; 1791 - Dati
