; **** CPM 2.2 ****

; low RAM workspace
WARMRESET   EQU $0000   ; ricarica il CP/M JP BA03 (WARM BOOT IN JUMP TABLE)
IOBYTE      EQU $0003   ; IO byte
DEFDRIVE    EQU $0004   ; default drive
JUMPTOBDOS  EQU $0005   ; (3 bytes) JP BDOS

; CPM addresses
STARTCCP    EQU $A400   ; start of CCP in memory
STARTBDOS   EQU $AC06   ; start of BDOS in memory
STARTBIOS   EQU $BA00   ; start of bios in memory, called from boot loader
ENDBIOS     EQU $BD7F   ; end if bios code
FREESPACE   EQU $BEA5   ; some free space at the end

; CPM bios RAM workspace
NUM_RETRY   EQU $BA54  ; number of write retry attempts
DPH         EQU $BA68  ; DPH disk parameter header
DPB         EQU $BAC2  ; DPB disk parameter block
DIRBUF      EQU $BE25  ; 127 bytes buffer for containing the directory
BUFEPROM    EQU $BDA5  ; (128 bytes) sector buffer for disk eprom routines
SKEWTABLE   EQU $BAA8  ; sector skew table
ALVAREA     EQU $BEA5  ; BEA5-BF02 scratch pad area used by the BDOS to keep disk storage allocation information


CSVAREA     EQU $BF21  ; BF21-51 scratch pad area used for software check for changed disks
TMPREGSP    EQU $BFD0  ; (word) saves sp register
TMPREGHL    EQU $BFD2  ; (word) saves hl register
TMPREGDE    EQU $BFD4  ; (word) saves de register
TMPREGBC    EQU $BFD6  ; (word) saves bc register
TMPREGA     EQU $BFD8  ; (byte) saves a register
CURRTRACK   EQU $BFDA  ; current track
CURRSEC     EQU $BFDB  ; current sector
CURRDRIVE   EQU $BFDC  ; current drive number (0..3)
BUFADDR     EQU $BFDE  ; (word) address of sector buffer for DMA
VDDTABLE    EQU $BFE0  ; start of VDD table, usually loaded into IX. Also pointed by VDDPOINTER
LAST_TRACK  EQU $BFEC  ; last used track (never written to?)
LAST_DRIVE  EQU $BFDD  ; last used drive
VIDEORAM    EQU $C000  ; start of video RAM

; **** VDD TABLE **** IX+00h .. IX+10h where IX usually is $BFE2. At BFE0 there is a pointer to BFE2

IX_CRSROW       EQU $00  ; cursor row
IX_CRSROW_MAX   EQU $01  ; cursor row end, populated with 0Fh in 64x16
IX_CRSCOL       EQU $02  ; cursor column
IX_CRSCOL_MAX   EQU $03  ; cursor column end, populated with 3Fh in 64x16
IX_REVERSE      EQU $04  ; 80h=reverse, 00h=normal only 7 bit is checked
IX_CSRADDR      EQU $05  ; (word) cursor address in memory (used by the eprom routines)

IX_PRN_ST       EQU $06  ; printer status (see LISTST)
IX_CURRDRIVE    EQU $09  ; ** current drive for eprom routines
IX_DSKBUF       EQU $0A  ; ** (word) pointer disk sector buffer
IX_TRKNUM       EQU $0C  ; ** stores track number
IX_STMASK       EQU $0D  ; mask value for disk status byte
IX_NRETRY       EQU $0E  ; number of retry for disk status/restore before fault
IX_DSKSTATUS    EQU $0F  ; stores last disk status from port FDCCMD
IX_RDADDRBUF    EQU $10  ; (6 bytes) READ ADDRESS command result TRK,SIDE,SECT,LEN,CRCL,CRCH

;
; IX_SECNUM  EQU $0E  ; for RIG eprom
; IX_11      EQU $11  ; number of retry when sending command to HDC
; (at $BFF6)
; IX_16      EQU $16  ; HDC COMMAND BYTE 0: delimiter F7h
; IX_17      EQU $17  ; HDC COMMAND BYTE 1: SIDE
; IX_18      EQU $18  ; HDC COMMAND BYTE 2: TRACK (negated)
; IX_19      EQU $19  ; HDC COMMAND BYTE 3: SECTOR (negated)
; IX_1A      EQU $18  ; HDC COMMAND BYTE 4: delimiter FEh
; IX_1B      EQU $19  ; HDC COMMAND BYTE 5: delimiter FFh
;


; **** EPROM ENTRIES ****

MONITOR           EQU $E000    ; monitor entry point
VDDPOINTER        EQU $E003    ; (word) address of the VDD table in memory (usually contains $BFE0)
TMON              EQU $E02A    ; control back to TMON
INIZS             EQU $E3D9    ; inizializza il sistema, monitor, porte I/O
KBDIN             EQU $E3DC    ; keyboard input, puts read key in A
TMONLOAD          EQU $E3DF    ; T-MON "L"
INIZV             EQU $E3E2    ; inizializza il video
INIZO             EQU $E3E5    ; inizializza le porte I/O
RDNUM             EQU $E3E8    ; read HEX number from keyboard ant put in HL, D=0 exit with "." or "/"
PTBTE             EQU $E3EB    ; stampa il numero puntato da (BC) con spazio
PRTAD0            EQU $E3EE    ; stampa BC in esadecimale con ":"
PRTHEX            EQU $E104    ; stamp cifra esadecimale in A
RDCHR             EQU $E3F1    ; read char con echo
PUTCHAR           EQU $E3F4    ; stampa carattere in A
CRLF              EQU $E3F7    ; stampa CR+LF
WRSTG             EQU $E3FA    ; prints string in HL until char with 7 bit on
TMONTEST          EQU $E3FD    ; T-MON "T"
;PRTDVR            EQU ??      ; printer driver, prints char in A (after CR or LF)
;INIZP             EQU ??      ; E012? inizializza la stampante
;TOGCUR            EQU ??      ; E018? toggle cursor
PRTCHAR           EQU $E403    ; used in some dead code in CBIOS
RDFLE             EQU $E406    ; read file from cassette (documented page 58)
SAVEFILE          EQU $E409    ; save the memory in DE-HL to tape A=some marker
NOBLK             EQU $E40C    ; attende il sincronismo video per evitare il "brillio" durante l'accesso al video
EPROM_LPRINT      EQU $E650    ; sends C to parallel printer port
;??                EQU $E80C   ; used by CBIOS
SET_IX_READ       EQU $E82A    ; used by CBIOS
EPROM_INITD       EQU $E800    ; initialize the disk routines
EPROM_SETDRIVE    EQU $E809    ; drive in C
EPROM_SETTRACK    EQU $E803    ; track in C
EPROM_SETSECTOR   EQU $E806    ; sector in C
EPROM_SETDMA      EQU $E80C    ; set DMA buffer at HL, writes also in IX_STMASK, EPROM_U2
EPROM_WRITESECTOR EQU $E80F
EPROM_READSECTOR  EQU $E812
DISK_ERROR        EQU $E830    ; display "DISK ERROR"
BOOT_FROM_TAPE    EQU $E0B0
BOOT_FROM_DISK    EQU $E818


; **** IO PORTS ****

PARALLEL  EQU $5D    ; parallel port
SERIAL    EQU $7A    ; serial port status
SERDATA   EQU $78    ; serial port data
KEYBOARD  EQU $FF    ; porta tastiera
CASSETTE  EQU $77    ; porta cassetta e sincronismi video
DRIVESEL  EQU $3F    ; selezione drive number e side
FDCCMD    EQU $BC    ; 1791 - Comandi/status
FDCTRK    EQU $BD    ; 1791 - Traccia
FDCSEC    EQU $BE    ; 1791 - Settore
FDCDATA   EQU $BF    ; 1791 - Dati
HDCPORT   EQU $6D    ; porta HD controller

; port 6d bits
; bit 0: READY   1 when ready
; bit 1: READOK  1
; bit 2: BUSY    1 when busy
; bit 3: DATAREQ 1

; **** IO PORT VALUES ****
SERIAL_DATA_IN_READY   EQU  &b00000001
SERIAL_DATA_OUT_READY  EQU  &b00000100


; **** some generic constants ****

; TODO aggiungere caratteri CHR$() di controllo
DISK_ERROR_0 EQU 0   ; invalid track?
; TODO aggiungere quelli del manuale


