;
; General Processor Model T
; CP/M bootloader contained in disk GP02_IMD.img
;

; options defined from command line parameters
;FLOPPY_525      EQU 1       ; default 0
;BOOT_MESSAGE    EQU 1       ; default 0

IF FLOPPY_525
    NSECTORS        EQU 18
    SECTORSIZE      EQU 128
    STARTSECT       EQU 0
    CCPSIZE         EQU $34
ELSE
    NSECTORS        EQU 26
    SECTORSIZE      EQU 128
    STARTSECT       EQU 1
    CCPSIZE         EQU $34
ENDIF

; MISC
TMPSTACK    EQU $0080   ; temporary stack pointer to use during boot
CPMADDR     EQU $A400   ; address in memory where CP/M is loaded
STARTBIOS   EQU $BA00   ; start of bios in memory, called from boot loader

; EPROM ENTRY POINTS
INIZS             EQU $E3D9    ; inizializza il sistema, monitor, porte I/O
WRSTG             EQU $E3FA    ; write string routine in eprom
EPROM_INITD       EQU $E800    ; initialize the disk routines
EPROM_SETSECTOR   EQU $E806    ; sector in C
EPROM_SETDMA      EQU $E80C    ; set DMA buffer at HL, writes also in EPROM_U1, EPROM_U2
EPROM_READSECTOR  EQU $E812
EPROM_SETTRACK    EQU $E803    ; track in C

        ORG     $0100

        ; boots from here
BOOT:   ld      sp,TMPSTACK     ; imposta stack temporaneo da usare per il boot

; prints alternate message BEFORE reading tracks
IF BOOT_MESSAGE
   call    INIZS             ; inizializza il sistema
   ld      hl,MESSAGE        ; writes message
   call    WRSTG             ;
ENDIF

        ld      c,00h
        call    0E809h          ; ?
        call    0E800h          ; ?

        ld      b,CCPSIZE       ; B conta 52 settori (2 tracce da 26 settori) BUG: ne conta uno in più perchè parte da 2
        ld      c,00h           ; C = traccia 0
        ld      d,STARTSECT+1   ; ccp starts from 2nd sector on track 0
        ld      hl,CPMADDR      ; destination address to load CP/M

LOOPSEC:
        push    bc
        push    de
        push    hl
        ld      c,d
        call    EPROM_SETSECTOR
        pop     hl
        push    hl
        call    EPROM_SETDMA
        call    EPROM_READSECTOR

        pop     hl              ; avanza di 128 bytes (1 settore)
        ld      de,SECTORSIZE   ; il puntatore in memoria per
        add     hl,de           ; ospitare il prossimo settore

        pop     de
        pop     bc
        dec     b               ; decrement read sector count
        jp      z,ENDREAD       ; if all sectors read then exit

        inc     d               ; incrementa settore
        ld      a,d
        cp      NSECTORS+STARTSECT ; se settore <= 26
        jp      c,LOOPSEC          ; loopa

        ld      d,STARTSECT     ; primo settore
        inc     c               ; incrementa traccia
        push    bc
        push    de
        push    hl
        call    EPROM_SETTRACK
        pop     hl
        pop     de
        pop     bc
        jp      LOOPSEC

        ; Referenced from 012B
ENDREAD:
        IF BOOT_MESSAGE==0
           call    INIZS         ; inizializza il sistema
           ld      hl,MESSAGE    ; writes message
           call    WRSTG         ;
        ENDIF

        jp      STARTBIOS     ; starts CP/M

MESSAGE:

IF BOOT_MESSAGE
   DB $0d,$0a,"GENERAL PROCESSOR - MODEL ",34,"T",34,$0d,$0a,$0d,$0a
   DB "BOOTING...",$0d,$0a,$A0
ELSE
   DB      "       G E N E R A L   P R O C E S S O R"
   DB      0Dh
   DB      0Ah
   DB      0A0h
   DB      00h
   DB      00h
   DB      00h
   DB      00h
   DB      00h
ENDIF
