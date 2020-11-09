;***************************************************************************************
; CPM BIOS for GP Model T
;***************************************************************************************

; external options
;FLOPPY_525      EQU 0
;DOUBLE_SIDE     EQU 0

;internal options
CUSTOM_DOS_MSG  EQU 1              ; customized prompt message
NO_AUTOEXEC     EQU 1              ; 1=disables "Inizio Lavoro"
SAVE_SPACE      EQU 1
PATCH_READER    EQU 1              ; 1=patches a bug in READER
PATCH_WBOOT     EQU 1              ; 1=checks for validity of the drive in WBOOT
PATCH_VERIFY    EQU 1              ; 1=avoid repeated code in VERIFY_LOOP routine

;
; DSM = (TRACKS x SIDE – RESERVED) x NSECT x SECTSIZE : BLOCKSIZE
;
IF FLOPPY_525
    NTRACKS         EQU 40
    NSECTORS        EQU 18
    SECTORSIZE      EQU 128
    RESERVED_TRACKS EQU 4
    STARTSECT       EQU 0
    USE_SKEWING     EQU 0
    IF DOUBLE_SIDE
        NBLOCKS         EQU 170
        MAX_DRIVES      EQU 2
        BLOCKSIZE       EQU 1024
    ELSE
        NBLOCKS         EQU 80
        MAX_DRIVES      EQU 4
        BLOCKSIZE       EQU 1024
    ENDIF
ELSE
    NTRACKS         EQU 77
    NSECTORS        EQU 26
    SECTORSIZE      EQU 128
    RESERVED_TRACKS EQU 2
    STARTSECT       EQU 1
    USE_SKEWING     EQU 1
    IF DOUBLE_SIDE
        NBLOCKS         EQU 246
        MAX_DRIVES      EQU 2
        BLOCKSIZE       EQU 2048
    ELSE
        NBLOCKS         EQU 242
        MAX_DRIVES      EQU 4
        BLOCKSIZE       EQU 1024
    ENDIF
ENDIF

; IOBYTE masks and bits

IOBYTE_CON_MASK   EQU &b00000011
IOBYTE_RDR_MASK   EQU &b00001100
IOBYTE_PUN_MASK   EQU &b00110000
IOBYTE_LST_MASK   EQU &b11000000

IOBYTE_CON_TTY    EQU &b00000000  ; console is assigned to the console printer device (TTY:)
IOBYTE_CON_CRT    EQU &b00000001  ; console is assigned to the CRT device (CRT:)
IOBYTE_CON_BATCH  EQU &b00000010  ; batch mode: use the READER as the CONSOLE input, and the LIST device as the CONSOLE output (BAT:)
IOBYTE_CON_UC1    EQU &b00000011  ; user-defined console device (UC1:)

IOBYTE_RDR_TTY    EQU &b00000000  ; READER is the teletype device (TTY:)
IOBYTE_RDR_PTR    EQU &b00000100  ; READER is the high speed reader device (PTR:)
IOBYTE_RDR_UR1    EQU &b00001000  ; user-defined reader #1 (UR1:)
IOBYTE_RDR_UR2    EQU &b00001100  ; user-defined reader #2 (UR2:)

IOBYTE_PUN_TTY    EQU &b00000000  ; PUNCH is the teletype device (TTY:)
IOBYTE_PUN_PTP    EQU &b00010000  ; PUNCH is the high speed punch device (PTP:)
IOBYTE_PUN_UP1    EQU &b00100000  ; user-defined punch #1 (UP1:)
IOBYTE_PUN_UP2    EQU &b00110000  ; user-defined punch #2 (UP2:)

IOBYTE_LST_TTY    EQU &b00000000  ; LIST is the teletype device (TTY:)
IOBYTE_LST_CRT    EQU &b01000000  ; LIST is the CRT device (CRT:)
IOBYTE_LST_LPT    EQU &b10000000  ; LIST is the line printer device (LPT:)
IOBYTE_LST_UL1    EQU &b11000000  ; user-defined list device (UL1:)

; IO PORTS

PARALLEL  EQU $5D    ; parallel port
SERIAL    EQU $7A    ; serial port
SERDATA   EQU $78    ; serial port
DRIVESEL  EQU $3F    ; selezione drive number e side
FDCCMD    EQU $BC    ; 1791 - Comandi/status
FDCTRK    EQU $BD    ; 1791 - Traccia
FDCSEC    EQU $BE    ; 1791 - Settore
FDCDATA   EQU $BF    ; 1791 - Dati
KEYBOARD  EQU $FF    ; porta tastiera

; IO PORT VALUES
SERIAL_DATA_IN_READY   EQU  &b00000001
SERIAL_DATA_OUT_READY  EQU  &b00000100

; MEMORY MAP
IOBYTE            EQU $0003  ; IO byte
DEFDRIVE          EQU $0004  ; default drive
JUMPTOBDOS        EQU $0005  ; (3 bytes) JP BDOS
CCP_ENTRY_POINT   EQU $AC06  ; installed as JP at address $0005
STARTCCP          EQU $A400  ; start of CCP in memory
STARTBIOS         EQU $BA00  ; start of bios in memory, called from boot loader
VDDTABLE          EQU $BFE0  ; start of VDD table, usually loaded into IX. Also pointed by VDDPOINTER
LAST_TRACK        EQU $BFEC  ; last used track (never written to?)

; EPROMS
KBDIN             EQU $E3DC   ; keyboard input, puts read key in A
EPROM_PRTCHAR     EQU $E403   ; used in some dead code in CBIOS
EPROM_INITD       EQU $E800   ; initialize the disk routines
EPROM_LPRINT      EQU $E650   ; stampa carattere
EPROM_E82A        EQU $E82A   ; used by CBIOS
EPROM_SETDRIVE    EQU $E809   ; drive in C
EPROM_SETSECTOR   EQU $E806   ; sector in C
EPROM_SETDMA      EQU $E80C   ; set DMA buffer at HL, writes also in EPROM_U1, EPROM_U2
EPROM_READSECTOR  EQU $E812
EPROM_WRITESECTOR EQU $E80F
EPROM_SETTRACK    EQU $E803   ; track in C
WRSTG             EQU $E3FA    ; prints string in HL until char with 7 bit on

; VDD TABLE IX
EPROM_DSKBUFPTR EQU $0A  ; (word) pointer disk sector buffer
EPROM_DSKSTATUS EQU $0F  ; stores last disk status from port FDCCMD

ORG STARTBIOS

            jp      BOOT            ;ARRIVE HERE FROM COLD START LOAD
WARMBOOT:   jp      WBOOT           ;ARRIVE HERE FOR WARM START
            jp      CONST           ;CHECK FOR CONSOLE CHAR READY
FCONIN:     jp      CONIN           ;READ CONSOLE CHARACTER IN
            jp      CONOUT          ;WRITE CONSOLE CHARACTER OUT
            jp      LIST            ;WRITE LISTING CHARACTER OUT
            jp      PUNCH           ;WRITE CHARACTER TO PUNCH DEVICE
            jp      READER          ;READ READER DEVICE
            jp      HOME            ;MOVE TO TRACK 00 ON SELECTED DISK
            jp      SELDSK          ;SELECT DISK DRIVE
            jp      SETTRK          ;SET TRACK NUMBER
            jp      SETSEC          ;SET SECTOR NUMBER
            jp      SETDMA          ;SET DMA ADDRESS
            jp      READ            ;READ SELECTED SECTOR
            jp      WRITE           ;WRITE SELECTED SECTOR
            jp      LISTST          ;RETURN LIST STATUS
            jp      SECTRAN         ;SECTOR TRANSLATE SUBROUTINE
            jp      0000h
            jp      0000h
            jp      0000h
            jp      0000h
            jp      0000h
            jp      0000h
            jp      0000h
            jp      0000h
            jp      0000h

OUT_EPROM_LPRINT:
            jp      EPROM_LPRINT
            jp      GETCURSORADDR

NUM_RETRY:
    DB $05

IF !SAVE_SPACE
    UNUSED_BYTE:
    DB $31
ENDIF

; 10 bytes sent to port 7ah
INIT_SERIAL_DATA:
    DB $01,$00,$02,$00,$03,$C1,$04,$44,$05,$68

IF !SAVE_SPACE
    EMPTY_OR_UNKNOWN:
    DB $00,$00,$00,$00,$00,$00,$00,$00
ENDIF

DPH_TABLE:
    ; disk 0
    DW SKEWTABLE
    DW $00,$00,$00 ; scratch pad bytes
    DW DIRBUF
    DW DPB
    DW CSVAREA + 0*16
    DW ALVAREA + 0*31

    ; disk 1
    DW SKEWTABLE
    DW $00,$00,$00 ; scratch pad bytes
    DW DIRBUF
    DW DPB
    DW CSVAREA + 1*16
    DW ALVAREA + 1*31

; disks 2 and 3 for 8" configuration
IF MAX_DRIVES==4
    ; disk 2
    DW SKEWTABLE
    DW $00,$00,$00 ; scratch pad bytes
    DW DIRBUF
    DW DPB
    DW CSVAREA + 2*16
    DW ALVAREA + 2*31

    ; disk 3
    DW SKEWTABLE
    DW $00,$00,$00 ; scratch pad bytes
    DW DIRBUF
    DW DPB
    DW CSVAREA + 3*16
    DW ALVAREA + 3*31
ENDIF

IF USE_SKEWING
    SKEWTABLE:
    IF FLOPPY_525
        DB 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
    ELSE
        DB $01,$07,$0D,$13,$19,$05,$0B,$11,$17,$03,$09,$0F,$15,$02,$08,$0E,$14,$1A,$06,$0C,$12,$18,$04,$0A,$10,$16
    ENDIF
ELSE
    SKEWTABLE EQU $0
ENDIF

DPB:
    DW NSECTORS          ;SECTORS PER TRACK
    IF BLOCKSIZE == 1024
        DB $03               ;BSH - BLOCK SHIFT FACTOR
        DB $07               ;BLM - BLOCK MASK
        DB $00               ;EXM - EXTENT MASK
    ELSE
        DB $04               ;BSH - BLOCK SHIFT FACTOR
        DB 15                ;BLM - BLOCK MASK
        DB $00               ;EXM - EXTENT MASK
    ENDIF
    DW NBLOCKS           ;NUMBER OF BLOCKS
    DB $3F,$00           ;DIRENTRY SIZE
    DB $C0,$00           ;AL0, AL1
    DB $10,$00           ;CHECKSUM AREA SIZE IN BYTES
    DW RESERVED_TRACKS   ;NUMBER OF RESERVED TRACKS AT THE START OF THE DISK

WBOOT:
    ld      sp,0080h                   ; sets a temporary stack
    ld      c,00h
    call    EPROM_SETDRIVE
    call    EPROM_INITD
    ld      b,2Ch                      ; reads 44 sectors (only CCP)
    ld      c,00h                      ; track 0
    ld      d,STARTSECT+1              ; ccp starts from 2nd sector on track 0
    ld      hl,STARTCCP

WBOOTLOOP:
    push    bc
    push    de
    push    hl
    ld      c,d
    call    EPROM_SETSECTOR
    pop     hl
    push    hl
    call    EPROM_SETDMA
    call    EPROM_READSECTOR
    pop     hl
    ld      de,SECTORSIZE
    add     hl,de
    pop     de
    pop     bc
    dec     b
    jr      z,WBOOTENDLOOP
    inc     d
    ld      a,d
    cp      NSECTORS+STARTSECT
    jr      c,WBOOTLOOP
    ld      d,STARTSECT
    inc     c
    push    bc
    push    de
    push    hl
    call    EPROM_SETTRACK
    pop     hl
    pop     de
    pop     bc
    jr      WBOOTLOOP

BOOT:
    xor     a
    ld      (IOBYTE),a
    ld      (DEFDRIVE),a

WBOOTENDLOOP:
    ld      hl,MESSAGE_DOS_22
    call    WRSTG

    push    bc                    ;
    ld      b,0Ah                 ;
    ld      hl,INIT_SERIAL_DATA   ;
INIT_SERIAL:                      ;
    ld      a,(hl)                ; scrive i bytes di inizializzazione
    out     (SERIAL),a            ; sulla seriale.
    inc     hl                    ; TODO si può ottimizzare con OTIR
    dec     b                     ;
    jp      nz,INIT_SERIAL        ;
    pop     bc

    ld      a,0C3h
    ld      (0000h),a
    ld      hl,WARMBOOT
    ld      (0001h),hl       ; JP WARMBOOT at RST 0

    ld      (0005h),a           ;
    ld      hl,CCP_ENTRY_POINT  ;
    ld      (0006h),hl          ; JP $AC06 at $0005

    ld      hl,BUFEPROM      ;
    call    EPROM_SETDMA     ; sets the EPROM DMA buffer

    ei
    ld      a,(DEFDRIVE)     ;
    IF PATCH_WBOOT
        IF MAX_DRIVES==4
            and $03
        ELSE
            and $01
        ENDIF
    ENDIF
    ld      c,a              ; sets cpm default drive

    jp      STARTCCP         ; starts

MESSAGE_DOS_22:
    IF CUSTOM_DOS_MSG
        DB $0D,$0A
        IF FLOPPY_525
            IF MAX_DRIVES == 2
                DB "CPM 2.2 48k 5.25",34," DS"
            ELSE
                DB "CPM 2.2 48k 5.25",34," SS"
            ENDIF
        ELSE
            IF MAX_DRIVES == 2
                DB "CPM 2.2 48k 8",34," DS"
            ELSE
                DB "CPM 2.2 48k 8",34," SS"
            ENDIF
        ENDIF
        DB $0D,$0A,$A0
    ELSE
        DB $0D,$0A, "DOS 2.2 48k",$0D,$0A
        DB "rev. dic/81",$0D,$0A,$A0
    ENDIF

; Referenced from BBCF
; TODO call directly
READKBD:
    jp      KBDIN

IF !SAVE_SPACE
    ; apparently not referenced, sends 0d 0a to video
    ; TODO remove if dead code
    LBB70:
    ld      a,0Dh
    call    EPROM_PRTCHAR
    ld      a,0Ah
    call    EPROM_PRTCHAR
    ret
ENDIF

;***************************************************************************************
;
; CONST (function 2)
; Returns its status in A; 0 if no character is ready, 0FFh if one is.
;
;***************************************************************************************
CONST: ld      a,(IOBYTE)
       and     IOBYTE_CON_MASK
       cp      IOBYTE_CON_CRT      ; is CON a CRT ?
       jr      z,CONST_NOTCRT
       in      a,(KEYBOARD)
       rlca                        ; test 7 bit of keyboard port
ALL_ST_EXIT:
       ld      a,0FFh
       ret     nc                  ; if 1 returns $FF
       xor     a                   ; if 0 returns $00
       ret

CONST_NOTCRT:
       xor     a
       out     (SERIAL),a
       in      a,(SERIAL)
       and     SERIAL_DATA_IN_READY    ; bit 0 seriale => input data ready
CST_EXIT:
       scf
       jr      z,ALL_ST_EXIT
       ccf
       jr      ALL_ST_EXIT

LISTST_SERIAL:
       xor     a
       out     (SERIAL),a
       in      a,(SERIAL)
       and     SERIAL_DATA_OUT_READY  ; bit 3 seriale => out data ready
       jr      CST_EXIT

;***************************************************************************************
;
;LISTST (function 15)
;Return status of current printer device.
;
;Returns A=0 (not ready) or A=0FFh (ready).
;
;***************************************************************************************

LISTST:
    ld      a,(IOBYTE)
    and     IOBYTE_LST_MASK
    jr      z,LIST_PARALLEL          ; TTY: => PARALLEL
    cp      IOBYTE_LST_CRT
    jr      z,LISTST_SERIAL          ; CRT: => SERIAL
    cp      IOBYTE_LST_LPT
    jr      z,LIST_PARALLEL          ; LPT: => PARALLEL
    xor     a
    jr      LISTST_EXIT              ; UL1: => VIDEO
LIST_PARALLEL:
    in      a,(PARALLEL)            ; bit 6 = printer ready
    rlca
    rlca
    ld      iy,(0E003h)             ; read printer statuses from
    ld      b,a                     ; eprom routines,
    ld      a,(iy+06h)              ; but such values are
    xor     04h                     ; not used when returning
    and     b                       ;
    and     0C0h                    ;

; Referenced from BBB2
LISTST_EXIT:
    cpl
    jr      ALL_ST_EXIT

;***************************************************************************************
;
;READER (function 7)
;Read a character from the "paper tape reader" - or whatever the current auxiliary device is. If the device isn't ready, wait until it is. The character will be returned in A. If this device isn't implemented, return character 26 (^Z).
;
;***************************************************************************************

READER:
    ld      a,(IOBYTE)
    IF PATCH_READER
        and     IOBYTE_RDR_MASK
        cp      IOBYTE_RDR_PTR
    ELSE
        and     IOBYTE_CON_MASK    ;
        cp      IOBYTE_CON_CRT     ; bit check is WRONG if not patched
    ENDIF
    jr      nz,READKBD

READER_SERIAL:
    xor     a
    out     (SERIAL),a
    in      a,(SERIAL)
    and     SERIAL_DATA_IN_READY
    jp      z,READER_SERIAL
    in      a,(SERDATA)
    ret

CONOUT:
       call    SAVE_REGS
       ld      a,(IOBYTE)
       and     IOBYTE_CON_MASK
       cp      IOBYTE_CON_CRT
       jr      z,OUT_SERIAL
       cp      IOBYTE_CON_BATCH
       jr      z,LPT_OUT

VIDEO_OUT:
       ld      a,c
       call    EPROM_PRTCHAR
       jr      OUT_EXIT

OUT_SERIAL:
       xor     a
       out     (SERIAL),a
       in      a,(SERIAL)
       and     SERIAL_DATA_OUT_READY
       jp      z,OUT_SERIAL
       ld      a,c
       out     (SERDATA),a
       jr      OUT_EXIT

PUNCH:
       ; punch tape is not implemented
       ; and falls back to LST:
       ;

LIST:  call    SAVE_REGS
       ld      a,(IOBYTE)
       and     IOBYTE_LST_MASK
       jr      z,LPT_OUT
       cp      IOBYTE_LST_CRT
       jr      z,OUT_SERIAL
       cp      IOBYTE_LST_LPT
       jr      z,LPT_OUT
       jr      VIDEO_OUT

LPT_OUT:                                 ; Referenced from BBEC, BC0B, BC13
       ld      a,c
       call    OUT_EPROM_LPRINT


OUT_EXIT:                                ; Referenced from BBF2, BC01
       jr      LOAD_REGS2


; Referenced from BA18
HOME:  ld      c,00h
       call    SETTRK
       ld      c,00h
       jr      SETSEC


; returns the address of a Disc Parameter Header in HL.
; The exact format of a DPH varies between CP/M versions;
; If the disc could not be selected it returns HL=0.
; Referenced from BA1B
SELDSK:
    ld      hl,0000h
    ld      a,c
    ld      (CURRDRIVE),a
    cp      MAX_DRIVES
    ret     nc                         ; IF CURRDRIVE >= MAX_DRIVES THEN ret
    ld      a,(CURRDRIVE)
    ld      l,a
    ld      h,00h
    add     hl,hl
    add     hl,hl
    add     hl,hl
    add     hl,hl
    ld      de,DPH_TABLE
    add     hl,de                      ; hl = DPH_TABLE[CURRDRIVE*16]
    ret

SETTRK:                                   ; Referenced from BA1E, BC1F
    ld      a,c
    ld      (CURRTRACK),a
    ret

SETSEC:                                   ; Referenced from BA21, BC24
    ld      a,c
    ld      (CURRSEC),a
    ret

; Translate sector numbers to take account of skewing.
; On entry, BC=logical sector number (zero based) and DE=address
; of translation table. On exit, HL contains physical sector number.
; On a system with hardware skewing, this would normally ignore DE
; and return either BC or BC+1.
; Referenced from BA30
SECTRAN:
    IF USE_SKEWING
        ex      de,hl    ;
        add     hl,bc    ;
        ld      l,(hl)   ;
        ld      h,00h    ; hl = DE[BC]
    ELSE
        push    bc       ;
        pop     hl       ; hl = bc  (no skew table)
    ENDIF
    ret

; Referenced from BA24
SETDMA:
    ld      (DMA_ADDR),bc
    ret

;
; Read the currently set track and sector at the current DMA address.
; Returns A=0 for OK, 1 for unrecoverable error, 0FFh if media changed.
; Note: on this bios it always returns OK
;
READ:
    call    SAVE_REGS
    call    CHECK_CHANGED_TRKSEC
    call    EPROM_READSECTOR
    call    DISKBUF_TO_CPMBUF
    xor     a                         ; A=0 read ok
    jr      LOAD_REGS2

;
; Write the currently set track and sector. C contains a deblocking code:
;
; C=0 - Write can be deferred
; C=1 - Write must be immediate
; C=2 - Write can be deferred, no pre-read is necessary.
; Returns A=0 for OK, 1 for unrecoverable error, 2 if disc is readonly, 0FFh if media changed.
; Note: on the GP, C is ignored, 0FFh is never returned
;
WRITE:
    call    SAVE_REGS
    call    CHECK_CHANGED_TRKSEC
    ld      a,(NUM_RETRY)
    push    af                    ; save num retry in stack

WRITE_RETRY:
    call    CPMBUF_TO_DISKBUF
    call    EPROM_WRITESECTOR
    ld      a,(NUM_RETRY)
    cp      00h                   ; do not verify if NUM_VERIFY=0
    jr      z,WRITE_RETRY_EXIT    ;
    call    VERIFY_SECTOR         ; verify sector written
    or      a
    jr      z,WRITE_RETRY_EXIT    ; verify ok => exit
    ld      hl,MSGRETRY           ; prints error message
    call    WRSTG                 ;
    pop     af
    dec     a                     ; decrease number of attempts
    push    af
    jr      nz,WRITE_RETRY        ; retry
    inc     a                     ; sets A=1 error

WRITE_RETRY_EXIT:
    pop     bc                    ; destroy temp retry value from stack

LOAD_REGS2:
    call    LOAD_REGS
    ret

SAVE_REGS:                           ; Referenced from BBDE, BC03, BC54, BC63
    ld      (TMPREGSP),sp
    ld      (TMPREGHL),hl
    ld      (TMPREGDE),de
    ld      (TMPREGBC),bc
    ld      (TMPREGA),a
    pop     de                      ; de = return address
    ld      sp,STACK_BOTTOM         ; sets a new stack for read write routines
    push    de                      ; puts return address there
    ret

; Referenced from BC8D
LOAD_REGS:
    pop     hl                      ; hl = return address
    ld      sp,(TMPREGSP)           ; restores CP/M stack
    ex      (sp),hl                 ; puts return address there
    ld      bc,(TMPREGBC)
    ld      de,(TMPREGDE)
    ld      hl,(TMPREGHL)
    ret

CPMBUF_TO_DISKBUF:                  ; Referenced from BC6D
    ld      de,BUFEPROM
    ld      hl,(DMA_ADDR)
    jr      START_COPYBUF

DISKBUF_TO_CPMBUF:                  ; Referenced from BC5D
    ld      de,BUFEPROM
    ld      hl,(DMA_ADDR)
    ex      de,hl

START_COPYBUF:
    ld      b,SECTORSIZE
COPY_LOOP:
    ld      a,(hl)
    cpl                   ; invert data from WDC 1791 /D0-/D7
    ld      (de),a
    inc     hl
    inc     de
    djnz    COPY_LOOP
    ret

CHECK_CHANGED_TRKSEC:
    IF DOUBLE_SIDE==0
        ; single sided disks
        ld      a,(CURRDRIVE)
        ld      c,a
        ld      a,(LAST_DRIVE)
        cp      c
        ld      a,c
        ld      (LAST_DRIVE),a
        call    nz,EPROM_SETDRIVE
        ld      a,(CURRSEC)
        ld      c,a
        call    EPROM_SETSECTOR
        ld      a,(CURRTRACK)
        ld      c,a
        ld      a,(LAST_TRACK)
        cp      c
        call    nz,EPROM_SETTRACK
        ret
    ELSE
        ; double sided disks
        call    CALC_PHYSICAL_DRIVE_TRACK
        ld      a,(PHDRIVE)
        ld      c,a
        ld      a,(LAST_PHDRIVE)
        cp      c
        ld      a,c
        ld      (LAST_PHDRIVE),a
        call    nz,EPROM_SETDRIVE
        ld      a,(CURRSEC)
        ld      c,a
        call    EPROM_SETSECTOR
        ld      a,(PHTRACK)
        ld      c,a
        ld      a,(LAST_PHTRACK)
        cp      c
        call    nz,EPROM_SETTRACK
        ld      a,(CURRDRIVE)
        ld      (LAST_DRIVE),a
        ld      a,(CURRTRACK)
        ld      (LAST_TRACK),a
        ret

        CALC_PHYSICAL_DRIVE_TRACK:
        ; PHDRIVE = CURRDRIVE * 2
        ; PHTRACK = CURRTRACK
        ; IF CURRTRACK > 39 THEN
        ;    PHDRIVE = PHDRIVE + 1
        ;    PHTRACK = 79-CURDRIVE
        ; END
        ld    a,(CURRDRIVE)      ;
        sla   a                  ;
        ld    (PHDRIVE),a        ; PHDRIVE = CURRDRIVE * 2
        ld    a,(CURRTRACK)      ;
        ld    (PHTRACK),a        ; PHTRACK = CURRTRACK
        cp    NTRACKS            ; IF CURRTRACK <= NTRACKS THEN RET
        ret   c                  ;
        ld    a,(PHDRIVE)
        inc   a                  ;
        ld    (PHDRIVE),a        ; PHDRIVE = PHDRIVE + 1
        ld    a,(PHTRACK)        ;
        ld    c,a                ;
        ld    a,NTRACKS*2-1      ;
        sub   c                  ;
        ld    (PHTRACK),a        ; PHTRACK = (NTRACKS*2-1)-CURRTRACK
        ret
    ENDIF

VERIFY_SECTOR:
    call    EPROM_E82A                ; ? reset IX to VDDTABLE
    ld      c,FDCDATA                 ; port to be used in "ini"
    ld      h,(ix+EPROM_DSKBUFPTR+1)
    ld      l,(ix+EPROM_DSKBUFPTR)    ; hl points to EPROM_DISKBUFPTR
    ld      a,7Fh
    out     (FDCCMD),a                ; send FDC READ SECTOR command
    jr      VERIFY_LOOPENTER

VERIFY_LOOP:
       ini
VERIFY_LOOPENTER:
       in      a,(DRIVESEL)           ; read drive status
       rlca                           ; carry = bit 7 DATAREQ
       jr      c,VERIFY_LOOP          ; if data is ready repeat

       IF !PATCH_VERIFY
            in      a,(DRIVESEL)           ; read drive status
            rlca                           ; carry = bit 7 DATAREQ
            jr      c,VERIFY_LOOP          ; if data is ready repeat

            in      a,(DRIVESEL)           ; read drive status
            rlca                           ; carry = bit 7 DATAREQ
            jr      c,VERIFY_LOOP          ; if data is ready repeat

            in      a,(DRIVESEL)           ; read drive status
            rlca                           ; carry = bit 7 DATAREQ
            jr      c,VERIFY_LOOP          ; if data is ready repeat
       ENDIF

       rlca                           ; carry = bit 6 INTREQ (end of command)
       jr      nc,VERIFY_LOOPENTER    ; if command is not completed then repeat

VERIFY_WAITEND:
       in      a,(DRIVESEL)
       bit     6,a                    ; carry = bit 6 INTREQ (end of command)
       jr      z,VERIFY_WAITEND       ; wait until command is completed

       in      a,(FDCCMD)             ;
       cpl                            ; read FDC status
       ld      (ix+EPROM_DSKSTATUS),a ; save into table
       and     (ix+0Dh)               ; mask it
       ret

; Message "\r\nDISK WRITE RETRY\r", $A0
MSGRETRY:
    DB $0D, $0A, "DISK WRITE RETRY", $0A, $A0

; gets cursor address in HL
; by reading it from the pointer
; stored in the VDD table
; Referenced from jump table
GETCURSORADDR:
    ld      ix,VDDTABLE
    ld      h,(ix+01h)
    ld      l,(ix+00h)
    ld      de,0005h
    add     hl,de
    ld      d,(hl)
    inc     hl
    ld      h,(hl)
    ld      l,d
    ret

; Referenced from BD59, BD62
AUTOEXEC_STRING_ADDR:
    DW MESSAGE_INIZIO_LAVORO

;***************************************************************************************
;
;CONIN (function 3)
;Wait until the keyboard is ready to provide a character, and return it in A.
;
;***************************************************************************************

CONIN:
    ld      hl,(AUTOEXEC_STRING_ADDR)
    ld      a,(hl)
    or      a
    jp      m,RESTORE_CONIN_VECTOR
    inc     hl
    ld      (AUTOEXEC_STRING_ADDR),hl
    ret

RESTORE_CONIN_VECTOR:
    ld      hl,KBDIN
    ld      (FCONIN+1),hl   ; change JP CONIN vector to JP KBDIN
    and     7Fh             ; clean 7th bit
    ret

; STRING "Inizio Lavoro"
MESSAGE_INIZIO_LAVORO:
    IF NO_AUTOEXEC
        DB 128+8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    ELSE
        DB "Inizio Lavoro",$8D,$00,$00,$00
    ENDIF

END_BIOS_BD7F:

IF !SAVE_SPACE
    EMPTY_ZONE_37B:
    DS 37
ENDIF

; (128 bytes) sector buffer for disk eprom routines
BUFEPROM:
    DS 128

; 127 bytes buffer for containing the directory
DIRBUF:
    DS 128

; scratch pad area used by the BDOS to keep disk storage allocation information
ALVAREA:
    DS 31
    DS 31
    IF MAX_DRIVES==4
        DS 31
        DS 31
    ENDIF

; scratch pad area used for software check for changed disks
CSVAREA:
    DS 16
    DS 16
    IF MAX_DRIVES==4
        DS 16
        DS 16
    ENDIF

STACK_TOP:
    DS 111
STACK_BOTTOM:

TMPREGSP:    DW 0    ; saves sp register
TMPREGHL:    DW 0    ; saves hl register
TMPREGDE:    DW 0    ; saves de register
TMPREGBC:    DW 0    ; saves bc register
TMPREGA:     DB 0    ; saves a register
EMPTY_BF:    DB 0    ; empty
CURRTRACK:   DB 0    ; current track
CURRSEC:     DB 0    ; current sector
CURRDRIVE:   DB 0    ; current drive number (0..3)
LAST_DRIVE:  DB 0    ; last used drive
DMA_ADDR:    DW 0    ; saves CPM DMA buffer
IF DOUBLE_SIDE
    PHDRIVE:       DB 0
    PHTRACK:       DB 0
    LAST_PHDRIVE:  DB 0
    LAST_PHTRACK:  DB 0
ENDIF

