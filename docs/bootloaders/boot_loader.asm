;
; General Processor Model T
; CP/M bootloader contained in disk GP02_IMD.dsk
;

        ORG     0100h

TMPSTACK EQU 0080h        ; temporary stack pointer to use during boot
CPMADDR  EQU 0A400h       ; address in memory where CP/M is loaded

WRSTG    EQU 0E3FAh       ; write string routine in eprom

        ; boots from here
BOOT:   ld      sp,TMPSTACK     ; imposta stack temporaneo da usare per il boot

        ld      c,00h
        call    0E809h          ; ?
        call    0E800h          ; ?

        ld      b,34h           ; B conta 52 settori (2 tracce da 26 settori) BUG: ne conta uno in più perchè parte da 2
        ld      c,00h           ; C = traccia 0
        ld      d,02h           ; D = settore ? come mai non è zero?
        ld      hl,CPMADDR      ; destination address to load CP/M

LOOPSEC:
        push    bc
        push    de
        push    hl
        ld      c,d
        call    0E806h
        pop     hl
        push    hl
        call    0E80Ch
        call    0E812h

        pop     hl              ; avanza di 128 bytes (1 settore)
        ld      de,0080h        ; il puntatore in memoria per
        add     hl,de           ; ospitare il prossimo settore

        pop     de
        pop     bc
        dec     b               ; decrement read sector count
        jp      z,ENDREAD       ; if all sectors read then exit

        inc     d               ; incrementa settore
        ld      a,d
        cp      1Bh             ; se settore <= 26
        jp      c,LOOPSEC       ; loopa

        ld      d,01h           ; settore 01 (come mai non è 00?)
        inc     c               ; incrementa traccia ?
        push    bc
        push    de
        push    hl
        call    0E803h
        pop     hl
        pop     de
        pop     bc
        jp      LOOPSEC

        ; Referenced from 012B
ENDREAD:
        call    0E3D9h        ; ??? eprom call, forse clear/reset screen ?

        ld      hl,MESSAGE    ; writes message
        call    WRSTG         ;

        jp      0BA00h        ; starts CP/M

MESSAGE:
        DB      "       G E N E R A L   P R O C E S S O R"
        DB      0Dh
        DB      0Ah
        DB      0A0h
        DB      00h
        DB      00h
        DB      00h
        DB      00h
        DB      00h

