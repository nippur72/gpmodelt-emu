
; standard definitions
include "../../docs/defs.asm"

        ORG     0100h

TMPSTACK EQU $0080                   ; temporary stack pointer to use during boot
BUF      EQU $1000

NUMTRAKS EQU 35
FIRSTSEC EQU 1
LASTSEC  EQU 16

; memory variables
track    EQU $2000
sect     EQU $2001

        ; boots from here
BOOT:
        ld      sp,TMPSTACK          ; imposta stack temporaneo da usare per il boot

        ld      hl,MESSAGE_BOOT_OK   ; writes message
        call    WRSTG                ;

        ld      c,00h
        call    EPROM_SETDRIVE       ; selects drive 0
        call    EPROM_INITD          ; init disk routines

        ; initialize loop variables
        xor     a
        ld      (track),a
        ld      a, 2                 ; FIRSTSEC
        ld      (sect),a

READ_LOOP:
        call    READ_SECTOR

        ld      a,(sect)
        inc     a
        ld      (sect),a
        cp      LASTSEC+1
        jr      nz,READ_LOOP
        ld      a,FIRSTSEC        ; reset sector
        ld      (sect),a
        ld      a,(track)
        inc     a                 ; increment track
        ld      (track),a
        cp      NUMTRAKS
        jr      nz,READ_LOOP

END_LOOP:
        ld      hl,MESSAGE_DONE      ; writes message
        call    WRSTG                ;
        halt

READ_SECTOR:
        ld      hl,BUF
        call    EPROM_SETDMA
        ld      a,(sect)
        ld      c,a
        call    EPROM_SETSECTOR
        ld      a,(track)
        ld      c,a
        call    EPROM_SETTRACK
        call    EPROM_READSECTOR

        ld      hl,(BUF)       ; prints first two bytes
        push    hl             ; of the sector content
        pop     bc             ; that has been previously
        call    PRTAD0         ; filled with data

        ld      a, 32          ; two spaces
        call    PUTCHAR        ;
        call    PUTCHAR        ;

        ret

MESSAGE_BOOT_OK:   DB 0x0C, "BOOT OK", $0d, $0a, $a0
MESSAGE_DONE:      DB $0d, $0a, "ALL DONE!", $a0
