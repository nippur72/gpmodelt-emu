;***************************************************************************************
; U1 & U2 Eproms
;
;
;***************************************************************************************

MONITOR:
    jp MONITOR_1

VDDPOINTER:
    DW BFE0

VECTORTABLE:
    DW MONITORLOOP      ; @
    DW MONITORLOOP      ; A
    DW MENU_BOOT        ; B R
    DW MENU_SAVE        ; C S  SAVE xxxx-yyyy
    DW MENU_TESTVID     ; D T
    DW MONITORLOOP
    DW MONITORLOOP
    DW MENU_GO          ; G W   GO xxxx
    DW MONITORLOOP
    DW MONITOR          ; I Y   Initialize
    DW MONITORLOOP
    DW MONITORLOOP
    DW MENU_LOADTAPE    ; L
    DW MENU_DUMPMEM     ; M   memory dump xxxx or edit xxxx-yyyy
    DW MONITORLOOP
    DW MONITORLOOP

;***************************************************************************************
;
; MONITOR
;
;***************************************************************************************

MONITOR_1:
    in      a,(KEYBOARD)            ; read keyboard
    rlca                            ; test if character is ready
    jr      c,MONITOR_1             ; if not, loop
TMON:                               ; E02A entry point mentioned in the manual
    ld      hl,(VDDPOINTER)
    ld      l,80h                   ; HL = BF80
    ld      b,h
    ld      c,00h                   ; BC = BF00 highest location
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld      sp,hl                   ; sets stack pointer to BF80 below system area
    push    bc
    call    INIZS
    pop     bc
    ld      hl,MESSAGE1
    call    WRSTG
    call    PRTAD0                  ; prints highest mem loc in BC
MONITORLOOP:
    call    CRLF                    ; prints crls
    ld      a,3Fh                   ; '?'
    call    PUTCHAR                 ; prints question mark
    call    RDCHR                   ; reads character with echo
    and     0Fh                     ; range betwen 0-15
    ld      c,a
    ld      b,00h                   ; bc = char and 0fh
    ld      hl,VECTORTABLE
    add     hl,bc
    add     hl,bc                   ; hl = vectortable[char*2]
    ld      bc,MONITORLOOP          ; BC = MONITORLOOP
    push    bc                      ; pushes BC on the stack so it will RET there
    ld      c,(hl)
    inc     hl
    ld      b,(hl)                  ; bc = vectortable[char*2]]
    ld      h,b
    ld      l,c                     ; hl = bc
    jp      (hl)                    ; jump to routine in vectortable[char*2]] and RET back to MONITORLOOP

;***************************************************************************************
;
; MENU GO
;
;***************************************************************************************

MENU_GO:
    call    RDNUM                   ; reads 4 digit hex num into hl
    jp      (hl)                    ; jumps to it

;***************************************************************************************
;
; MENU DUMP OR EDIT MEM
;
;***************************************************************************************

MENU_DUMPMEM:   call    RDNUM_BC            ; reads an hex number in BC (start memory)
                cp      2Dh                 ; '-'
                jr      nz,MEM_EDIT         ; if last char is not '-' then edit memory
                call    RDNUM_DE            ; DE = end of memory range
                jr      MEM_DUMP

MEM_DUMPLOOP:   ld      a,c                 ;
                and     0Fh                 ; align to 16 multiples
                jr      nz,MEM_DUMP1        ; if BC not 16 multiple skip
MEM_DUMP:       call    PRINT_CRLF_4HEXNUM   ; prints a CRLF, hexnum in BC and ": "
MEM_DUMP1:      call    PTBTE               ; prints number pointed by BC and a space
                inc     bc                  ; increment location
                call    CMP_BC_DE           ; is end reached?
                jr      nz,MEM_DUMPLOOP     ; loop if not end
                ret

MEM_EDIT:       call    PRINT_CRLF_4HEXNUM   ; prints a CRLF, hexnum in BC and ": "
                call    PTBTE               ; prints number pointed by BC and a space
                call    RDNUM               ; read the hexnum from keyboard in HL, A=exit key, D=exit with "." or "/"
                cp      2Fh                 ; '/'
                ret     z                   ; if it's slash then stop edit
                cp      2Eh                 ; '.'
                jr      nz,MEM_EDIT2        ; if it's not dot, a number was typed
                dec     bc                  ; it's dot, decrement bc twice
                dec     bc
MEM_EDIT2:      bit     0,d                 ; was an exit with "." or "/" ?
                jr      z,MEM_EDIT3         ; yes, skip mem edit
                ld      a,l                 ; hex number is in L
                ld      (bc),a              ; does the mem edit
MEM_EDIT3:      inc     bc                  ; increment to next location
                jr      MEM_EDIT

;***************************************************************************************
;
; BOOT FROM CASSETTE OR DISK
;
;***************************************************************************************

MENU_BOOT:
    call    RDCHR
    cp      43h                  ; 'C'
    jr      nz,MENU_BOOT1        ; if not check boot from disk
    ld      a,42h                ; 'B'
    call    RDFLE                ; read file from cassette
    jp      0000h                ; executes the loaded file from $0000
MENU_BOOT1:
    cp      44h                  ; 'D'
    jp      z,BOOT_FROM_DISK     ; boot from disk and RET there
    ret

;***************************************************************************************
;
; RDNUM - read a 4 digit HEX number from keyboard ant put in HL
;         D=0 if exit with "." or "/"
;         A=last character
;
;***************************************************************************************
RDNUM1:
       ld      hl,0000h      ; start from 0
       ld      d,00h         ; sets the exit condition
       call    RDHEXDIGIT    ; a=hex digit, c=1 error
       jr      nc,RDNUM_SUM  ; if it's a true hex digit, accumulate it
       cp      0Dh           ; is it return key ?
       ret     z             ; if yes, return
       cp      2Fh           ; is it a '/' ?
       ret     z             ; if yes, return
       cp      2Eh           ; is it '.' ?
       ret     z             ; if yes, return, any other character is coerced to hex

RDNUM_SUM:
       add     hl,hl
       ld      d,01h         ; D=1 exit condition HL contains hex number
       add     hl,hl
       add     hl,hl
       add     hl,hl         ; shift HL to left 4 bits to give space for the new digit
       or      l
       ld      l,a           ; in the end: HL = (HL << 4) | A
       call    RDHEXDIGIT    ; read next digit
       ret     c             ; exit if special key or error
       jr      RDNUM_SUM     ; sum next digit

;
; read a hex num and put in BC, last character in A
;
RDNUM_BC:
    call    RDNUM
    ld      b,h
    ld      c,l
    ret

;
; read a hex num and put in DE, last character in A
;
RDNUM_DE:
    call    RDNUM
    ld      d,h
    ld      e,l
    ret

;
; reads an HEX digit from keyboard and puts in A
; on exit C=1 if digit is not an hex number
;
RDHEXDIGIT_0_9:
       sub     30h                ; put in the range 0-9
       ret

; entry point is here
RDHEXDIGIT:
       call    RDCHR              ; reads a character
       and     7Fh                ; clears 0-127 (isn't already cleared?)
       cp      30h                ; is it less than '0' ?
       ret     c                  ; then return (dirty digit is in A)
       cp      3Ah                ; is it greater or equal than ':' ?
       jr      c,RDHEXDIGIT_0_9   ; no, it's a 0-9 digit
       cp      41h                ; is it less than 'A' ?
       ret     c                  ; then return (dirty digit is in A)
       cp      47h                ; is it greater or equal than 'G' ?
       ccf                        ; complement so it's a "<=" compare
       ret     c                  ; then return (dirty digit is in A)
       sub     37h                ; put A in the range 0Ah-0Fh
       ret

;
; prints the hex digit in A
;
PRINT_HEX_DIGIT:
    and     0Fh        ; clears the hex digit in the range 0-F
    add     a,30h      ; add '0'
    cp      3Ah        ; is it a numeric digit (0-9) ?
    jp      c,PUTCHAR  ; yes prints it
    add     a,07h      ; add 7 to put it in the range A-F
    jp      PUTCHAR    ; prints it

;
; compares BC with DE
;
CMP_BC_DE:
    ld      a,b
    cp      d
    ret     nz
    ld      a,c
    cp      e
    ret

;
; prints a 2 digit hex number pointed by BC with a space
;
PRINT_HEXNUM:
    ld      a,(bc)
    rra
    rra
    rra
    rra
    call    PRINT_HEX_DIGIT     ; prints first hex digit
    ld      a,(bc)
    call    PRINT_HEX_DIGIT     ; prints second hex digit
    ld      a,20h   ; ' '
    jp      PUTCHAR             ; prints space and RET there

;
; prints a 4 digit hex num contained in BC with ":" and a space
;
PRINT_CRLF_4HEXNUM:
       call    CRLF
PRINT_4HEXNUM:
       ld      a,b
       rra
       rra
       rra
       rra
       call    PRINT_HEX_DIGIT     ; left digit in B
       ld      a,b
       call    PRINT_HEX_DIGIT     ; right digit in B
       ld      a,c
       rra
       rra
       rra
       rra
       call    PRINT_HEX_DIGIT     ; left digit in C
       ld      a,c
       call    PRINT_HEX_DIGIT     ; right digit in C
       ld      a,3Ah               ; ':'
       call    PUTCHAR
       ld      a,20h               ; ' '
       jp      PUTCHAR             ; prints space and RET there

;***************************************************************************************
;
; MENU SAVE - save a program on tape
;
;
;***************************************************************************************

MENU_SAVE:
       call    RDNUM_DE   ; get start address in DE
       cp      2Dh        ; is there a separatory '-' ?
       ret     nz         ; no, abort save
       push    de         ; save DE
       call    RDNUM      ; read hex number in HL
       pop     de         ; gets back DE
       ld      a,80h      ; ? some marker for the tape file
       jp      SAVEFILE   ; save to TAPE

;***************************************************************************************
;
; MENU_LOADTAPE - loads a file from tape
;
;
;***************************************************************************************

MENU_LOADTAPE1:
    ld      a,42h   ; 'B'
    jp      RDFLE

;***************************************************************************************
;
; RDCHR - reads a char from the keyboard with echo
;
;
;***************************************************************************************

RDCHR1:
    call    KBD          ; reads char
    jp      PUTCHAR         ; prints char and RET there

;***************************************************************************************
;
; KBD - gets a character from the keyboard (without echo)
;
;
;***************************************************************************************

KBD1:
       in      a,(KEYBOARD)       ; read keyboard port
       rlca                       ; check bit 7 key pressed
       jr      c,KBD1          ; loop if key is NOT is pressed
       rrca                       ; readjusts from rlca
       cpl                        ; negate because keyboard is inverted
       push    af                 ; save A
GETKEY2:
       in      a,(KEYBOARD)       ; read keyboard port
       rlca                       ; check bit 7 key pressed
       jr      nc,GETKEY2         ; loop until key is released
       pop     af                 ; loads saved A value
       and     7Fh                ; mask out bit 7 (key pressed)
       ret

;***************************************************************************************
;
; CRLF prints a CRLF (actually a LF CR)
;
;***************************************************************************************

CRFL1: ld      a,0Ah
       call    PUTCHAR
       ld      a,0Dh
       call    PUTCHAR
       ld      a,00h
       jp      PUTCHAR

;***************************************************************************************
;
; WRSTG - write a string on the video, terminated with bit 7 turned on
;
;***************************************************************************************

WRSTG1:ld      a,(hl)
       call    PUTCHAR
       bit     7,a
       inc     hl
       jp      z,WRSTG
       ret

;"         G E N E R A L   P R O C E S S O R Your highest ram loc. is"
MESSAGE1:
    DB $0A
    DB $20,$20
    DB $20,$20
    DB $20,$20
    DB $20,$20
    DB $20,$47
    DB $20,$45
    DB $20,$4E
    DB $20,$45
    DB $20,$52
    DB $20,$41
    DB $20,$4C
    DB $20,$20
    DB $20,$50
    DB $20,$52
    DB $20,$4F
    DB $20,$43
    DB $20,$45
    DB $20,$53
    DB $20,$53
    DB $20,$4F
    DB $20,$52
    DB $0A
    DB $0A
    DB $0D
    DB $59
    DB $6F
    DB $75
    DB $72
    DB $20,$68
    DB $69
    DB $67
    DB $68
    DB $65
    DB $73
    DB $74
    DB $20,$72
    DB $61
    DB $6D
    DB $20,$6C
    DB $6F
    DB $63
    DB $2E,$20
    DB $28,$68
    DB $65
    DB $78
    DB $29
    DB $20,$69
    DB $73
    DB $BA

;***************************************************************************************
;
; PRTCHAR - prints the character in A on the screen
;
;***************************************************************************************

PRTCHAR1:
               push    de
               push    ix
               push    hl
               push    bc
               push    af
               ;
               ld      hl,(VDDPOINTER)    ; hl = BFE0 (from VDDTABLE pointer in eprom)
               ld      e,(hl)
               inc     hl
               ld      d,(hl)
               push    de
               pop     ix                 ; ix = BFE2 start of VDDTABLE
               jp      PRTCHAR_CONT1      ; continue to splitted routine wher NOBLK is called
             ;;call    NOBLK1
             ;;ld      h,(IX+IX_CSRADDR+1)
             ;;jp      PRTCHAR_CONT2
PRTCHAR_CONT2: ld      l,(IX+IX_CSRADDR)  ; HL = cursor address
0E1F6h:        call    CURSOROFF          ; turn off cursor

0E1F9h:        ld      b,a                ;
0E1FAh:        ld      a,(0E41Bh)         ; checks if E41Bh contains "DD" (bit instruction)
               cp      0DDh               ; and if so, saves A to B and jumps there
0E1FFh:        ld      a,b                ;
0E200h:        jp      z,0E41Bh           ; ??? check cursor limits

0E203h:        cp      00h                ; NULL
               jr      z,CHAR_NULL
               cp      0FFh               ; NULL (reversed)
               jr      z,CHAR_NULL
0E20Bh:        cp      0Dh                ; CR
0E20Dh:        jr      z,CHAR_CR
               cp      0Ah                ; LF
0E211h:        jr      z,CHAR_LF
               cp      0Ch                ; FF
               jr      z,DOCLS            ; ???
               ld      (hl),a             ; writes the character on the screen
0E218h:        jp      PRTCHAR_CONT3
PRTCHAR_CONT4: jr      z,CHAR_LF
CHAR_NULL:     call    TOGGLE
POPALL:        pop     af
               pop     bc
               pop     hl
               pop     ix
               pop     de
               ret


                                        ; Referenced from 0E20Dh
                                        ; --- START PROC CHAR_CR ---
E227: CD 6F E2                   CHAR_CR:        call    UPDATE_CURSORPTR

                                        ; Referenced from 0E23Fh
                                        ; --- START PROC 0E22Ah ---
E22A: DD 75 05                   0E22Ah:        ld      (IX+IX_CSRADDR),l
E22D: 18 EE                             jr      CHAR_NULL

                                        ; Referenced from 0E1C6h, 0E211h, PRTCHAR_CONT4, 0E49Ch
                                        ; --- START PROC CHAR_LF ---
E22F: CD 77 E2                   CHAR_LF:        call    0E277h
E232: 20 05                             jr      nz,0E239h
E234: CD 93 E2                          call    0E293h
E237: 18 03                             jr      0E23Ch

                                        ; Referenced from 0E232h
                                        ; --- START PROC 0E239h ---
E239: CD EC E2                   0E239h:        call    0E2ECh

                                        ; Referenced from 0E237h, 0E48Bh
                                        ; --- START PROC 0E23Ch ---
E23C: DD 74 06                   0E23Ch:        ld      (IX+IX_CSRADDR+1),h

                                        ; Referenced from 0E1D2h
E23F: 18 E9                      0E23Fh:        jr      0E22Ah

                                        ; Referenced from 0E1CEh, 0E1D8h, 0E215h
                                        ; --- START PROC DOCLS ---
E241: CD 04 E3                   DOCLS:        call    0E304h

                                        ; Referenced from 0E252h
E244: CD BF E2                   0E244h:        call    0E2BFh

                                        ; Referenced from 0E1DDh
E247: CD 77 E2                   0E247h:        call    0E277h
E24A: 28 08                             jr      z,0E254h
E24C: CD EC E2                          call    0E2ECh
E24F: CD 6F E2                          call    UPDATE_CURSORPTR
E252: 18 F0                             jr      0E244h

                                        ; Referenced from 0E24Ah
E254: CD 04 E3                   0E254h:        call    0E304h
E257: 18 C4                             jr      CHAR_NULL

E259: 0E 00                      CURSOROFF:ld      c,00h
E25B: 18 02                             jr      0E25Fh

E25D: 0E 80                      TOGGLE:ld      c,80h

E25F: F5                         0E25Fh:push    af
E260: DD 7E 04                          ld      a,(ix+IX_REVERSE)    ;
E263: E6 80                             and     80h                  ; get reverse state
E265: A9                                xor     c                    ; toggle reverse if C=80h, unchanged if C=00h
E266: 4F                                ld      c,a                  ; C=(IX_REVERSE & 80) ^ C => new reverse
E267: 7E                                ld      a,(hl)               ; loads character under cursor
E268: E6 7F                             and     7Fh                  ; converts back to ASCII
E26A: B1                                or      c                    ; apply reverse
E26B: 77                                ld      (hl),a               ; writes back
E26C: F1                                pop     af
E26D: C9                                ret

E26E: C9                         0E26Eh:        ret

;
; updates the cursor pointer from its column value
;
UPDATE_CURSORPTR:
       ld      a,l
       and     0C0h
       or      (ix+IX_CRSCOL)
       ld      l,a
       ret

                                        ; Referenced from CHAR_LF, 0E247h, 0E2AAh
                                        ; --- START PROC 0E277h ---
E277: CD 7E E2                   0E277h:        call    0E27Eh
E27A: DD BE 01                          cp      (ix+IX_CRSROW_MAX)
E27D: C9                                ret

                                        ; Referenced from 0E277h, 0E2E4h, 0E2F0h, 0E478h
                                        ; --- START PROC 0E27Eh ---
E27E: E5                         0E27Eh:        push    hl
E27F: 29                                add     hl,hl
E280: 29                                add     hl,hl
E281: 7C                                ld      a,h
E282: E6 0F                             and     0Fh
E284: E1                                pop     hl
E285: C9                                ret

                                        ; Referenced from 0E2B9h, 0E4D1h
                                        ; --- START PROC 0E286h ---
E286: DD 7E 02                   0E286h:        ld      a,(ix+IX_CRSCOL)
E289: ED 44                             neg
E28B: DD 86 03                          add     a,(ix+IX_CRSCOL_MAX)
E28E: 3C                                inc     a
E28F: 4F                                ld      c,a
E290: 06 00                             ld      b,00h
E292: C9                                ret

                                        ; Referenced from 0E234h
                                        ; --- START PROC 0E293h ---
E293: E5                         0E293h:        push    hl
E294: CD 04 E3                          call    0E304h

                                        ; Referenced from 0E2ADh
E297: 00                         0E297h:        nop
E298: CD C8 E4                          call    0E4C8h
E29B: 00                                nop
E29C: 00                                nop
E29D: 00                                nop
E29E: 00                                nop
E29F: 00                                nop
E2A0: 00                                nop
E2A1: 00                                nop
E2A2: 00                                nop
E2A3: 00                                nop
E2A4: 00                                nop
E2A5: 00                                nop
E2A6: 2B                                dec     hl
E2A7: CD 6F E2                          call    UPDATE_CURSORPTR
E2AA: CD 77 E2                          call    0E277h
E2AD: 20 E8                             jr      nz,0E297h
E2AF: CD CE E4                          call    0E4CEh
E2B2: E1                                pop     hl
E2B3: C9                                ret

                                        ; Referenced from 0E4CBh
                                        ; --- START PROC 0E2B4h ---
E2B4: EB                         0E2B4h:        ex      de,hl
E2B5: 21 40 00                          ld      hl,0040h
E2B8: 19                                add     hl,de
E2B9: CD 86 E2                          call    0E286h
E2BC: ED B0                             ldir
E2BE: C9                                ret

                                        ; Referenced from 0E244h, 0E2C8h, 0E4A4h
                                        ; --- START PROC 0E2BFh ---
E2BF: C3 CE E4                   0E2BFh:        jp      0E4CEh

E2C2: CD 59 E2                   0E2C2h:        call    CURSOROFF
E2C5: CD CB E2                          call    0E2CBh
E2C8: 20 F5                             jr      nz,0E2BFh
E2CA: C9                                ret

0E2CBh:
       ld      a,l                   ; gets cursor column from the address part
       and     3Fh                   ; range between 0-63
       cp      (ix+IX_CRSCOL_MAX)    ; maximum reached ?
       jr      z,0E2D8h              ; ?
       inc     (IX+IX_CSRADDR)       ; move cursor to right (on sys var)
       inc     l                     ; move cursor to right (in HL)
       ret

0E2D8h:call    UPDATE_CURSORPTR
       ld      (IX+IX_CSRADDR),l
       xor     a
       ret

                                        ; Referenced from 0E454h
                                        ; --- START PROC 0E2E0h ---
E2E0: F5                         0E2E0h:        push    af
E2E1: 11 C0 FF                          ld      de,0FFC0h
E2E4: CD 7E E2                          call    0E27Eh
E2E7: DD BE 00                          cp      (IX+IX_CRSROW)
E2EA: 18 0A                             jr      0E2F6h

                                        ; Referenced from 0E239h, 0E24Ch
                                        ; --- START PROC 0E2ECh ---
E2EC: F5                         0E2ECh:        push    af
E2ED: 11 40 00                          ld      de,0040h
E2F0: CD 7E E2                          call    0E27Eh
E2F3: DD BE 01                          cp      (ix+IX_CRSROW_MAX)

                                        ; Referenced from 0E2EAh
                                        ; --- START PROC 0E2F6h ---
E2F6: 20 03                      0E2F6h:        jr      nz,0E2FBh
E2F8: 11 00 00                          ld      de,0000h

                                        ; Referenced from 0E2F6h
E2FB: 19                         0E2FBh:        add     hl,de
E2FC: DD 75 05                          ld      (IX+IX_CSRADDR),l
E2FF: DD 74 06                          ld      (IX+IX_CSRADDR+1),h
E302: F1                                pop     af
E303: C9                                ret

                                        ; Referenced from DOCLS, 0E254h, 0E294h, 0E45Bh
                                        ; --- START PROC 0E304h ---
E304: F5                         0E304h:        push    af
E305: 7C                                ld      a,h
E306: E6 FC                             and     0FCh
E308: 67                                ld      h,a
E309: DD 7E 00                          ld      a,(IX+IX_CRSROW)
E30C: 6F                                ld      l,a
E30D: CB 2F                             sra     a
E30F: CB 2F                             sra     a
E311: E6 03                             and     03h
E313: B4                                or      h
E314: 67                                ld      h,a
E315: 7D                                ld      a,l
E316: 1F                                rra
E317: 1F                                rra
E318: E6 C0                             and     0C0h
E31A: DD B6 02                          or      (ix+IX_CRSCOL)
E31D: 6F                                ld      l,a
E31E: DD 75 05                          ld      (IX+IX_CSRADDR),l
E321: DD 74 06                          ld      (IX+IX_CSRADDR+1),h
E324: F1                                pop     af
E325: C9                                ret

;***************************************************************************************
;
; MENU TEST VIDEO
;
;***************************************************************************************
MENU_TESTVID1:
    call    0E3E2h
    ld      hl,MESSAGE1
    call    WRSTG
    ld      a,0C4h
    ld      b,20h   ; ' '
    ld      hl,0C0C0h

E336: 70                         0E336h:        ld      (hl),b
E337: 23                                inc     hl
E338: BC                                cp      h
E339: 20 FB                             jr      nz,0E336h
E33B: AF                                xor     a
E33C: 06 40                             ld      b,40h   ; '@'
E33E: 21 C0 C2                          ld      hl,0C2C0h
E341: 3E 1A                             ld      a,1Ah
E343: 77                         0E343h:        ld      (hl),a
E344: 23                                inc     hl
E345: C6 80                             add     a,80h
E347: 00                                nop
E348: 00                                nop
E349: 10 F8                             djnz    0E343h
E34B: 21 80 C1                          ld      hl,0C180h
E34E: 3E 0B                             ld      a,0Bh
E350: 77                         0E350h:        ld      (hl),a
E351: 23                                inc     hl
E352: 3C                                inc     a
E353: 10 FB                             djnz    0E350h
E355: CD F1 E3                   0E355h:        call    RDCHR
E358: 18 FB                             jr      0E355h


INIZV1:
       call    INIT_WITH_THE_TABLE_1
       ld      a,0Ch
       call    PRTCHAR1
       call    INIT_WITH_THE_TABLE_2
       ret


INIT_WITH_THE_TABLE_1:        jp      INIT_WITH_TABLE_1
                              rst     0x38
                              rst     0x38
INIT_WITH_THE_TABLE_2:        jp      INIT_WITH_TABLE_2
                              rst     0x38
                              rst     0x38
                              rst     0x38
                              rst     0x38

LDIR_7BYTES:
    ld      bc,0007h
    ldir
    ret

E378: E2 7F
TABLE_VALUES_1:
    DB $00,$0F,$00,$3F,$00,$00,$C0

E381: E2 7F
TABLE_VALUES_2:
    DB $00,$0F,$00,$3F,$00,$02,$C0

                                        ; Referenced from INIZS
                                        ; --- START PROC INIZS1 ---
E38A: CD E2 E3                   INIZS1:        call    0E3E2h

                                        ; Referenced from INIZIO
E38D: 3E 00                      INIZIO1:        ld      a,00h
E38F: D3 77                             out     (CASSETTE),a ; 'w'
E391: 3E FF                             ld      a,0FFh
E393: D3 5F                             out     (5Fh),a ; '_'
E395: 3E FB                             ld      a,0FBh
E397: D3 5F                             out     (5Fh),a ; '_'
E399: 3E FF                             ld      a,0FFh
E39B: D3 5E                             out     (5Eh),a ; '^'
E39D: AF                                xor     a
E39E: D3 5E                             out     (5Eh),a ; '^'
E3A0: C9                                ret

; splitted part of the PRTCHAR routine
;
;
PRTCHAR_CONT3:
       call    CURSOROFF
       call    0E2CBh
       jp      PRTCHAR_CONT4

INIT_WITH_TABLE_2:
       ld      a,20h                  ; ' '
       ld      (0C000h),a             ; prints reverse space at (0,0)
       ld      de,TABLE_VALUES_2
       jr      INIT_WITH_SKIP
INIT_WITH_TABLE_1:
       ld      de,TABLE_VALUES_1
INIT_WITH_SKIP:
       ld      hl,(VDDPOINTER)       ; HL = BFE0
       ld      a,l
       inc     a
       inc     a
       ld      (hl),a                ; *BFE0 = E2
       inc     hl
       ld      (hl),h                ; *BFE1 = BF ==> writes BFE2 on top of the VDDTABLE
       inc     hl
       ex      de,hl                 ; DE=BFE2, HL=TABLE_VALUES
       jp      LDIR_7BYTES


E3C5: 47                         0E3C5h:        ld      b,a
E3C6: DD 66 06                          ld      h,(IX+IX_CSRADDR+1)

                                        ; Referenced from 0E3CDh
E3C9: DB 77                      0E3C9h:        in      a,(CASSETTE) ; 'w'
E3CB: CB 57                             bit     2,a
E3CD: 20 FA                             jr      nz,0E3C9h

                                        ; Referenced from 0E3D3h
E3CF: DB 77                      0E3CFh:        in      a,(CASSETTE) ; 'w'
E3D1: CB 57                             bit     2,a
E3D3: 28 FA                             jr      z,0E3CFh
E3D5: 78                                ld      a,b
E3D6: C3 F3 E1                          jp      PRTCHAR_CONT2

E3D9: C3 8A E3                   INIZS:         jp      INIZS1
E3DC: C3 69 E1                   KBD:           jp      KBD1
E3DF: C3 5E E1                   MENU_LOADTAPE: jp      MENU_LOADTAPE1
E3E2: C3 5A E3                   INIZV:         jp      INIZV1
E3E5: C3 8D E3                   INIZIO:        jp      INIZIO1
E3E8: C3 BE E0                   RDNUM:         jp      RDNUM1
E3EB: C3 18 E1                   PTBTE:         jp      PRINT_HEXNUM
E3EE: C3 2C E1                   PRTAD0:        jp      PRINT_4HEXNUM
E3F1: C3 63 E1                   RDCHR:         jp      RDCHR1
E3F4: C3 E1 E1                   PUTCHAR:       jp      PRTCHAR1
E3F7: C3 7A E1                   CRLF:          jp      CRFL1
E3FA: C3 89 E1                   WRSTG:         jp      WRSTG1
E3FD: C3 26 E3                   MENU_TESTVID:  jp      MENU_TESTVID1

;
; **************************************************************************************
;

               jp      0000h
PRTCHAR:       jp      PRTCHAR1
RDFLE:         jp      RDFLE1
SAVEFILE:      jp      SAVEFILE1
0E40Ch:        jp      NOBLK1
               jp      0000h
               jp      0000h
               jp      0000h
               jp      0000h

;
; the location is checked for containing "BIT 7,(IX+00)" byte DDh
;
0E41Bh:
       bit     7,(IX+IX_CRSROW)   ; if CRSROW <= 63
       jr      z,0E42Bh           ; then goto ...
       res     7,(IX+IX_CRSROW)   ; else CRSROW = CRSROW and 63
       add     a,a
       add     a,a
       add     a,a
       add     a,a                ; a = a << 4
       jr      0E43Ah

                                        ; Referenced from 0E41Fh
E42B: DD CB 00 76                0E42Bh:bit     6,(IX+IX_CRSROW)
E42F: 28 0F                             jr      z,0E440h
E431: DD CB 00 B6                       res     6,(IX+IX_CRSROW)
E435: DD 7E 04                          ld      a,(ix+IX_REVERSE)
E438: EE 80                             xor     80h

                                        ; Referenced from 0E429h
E43A: DD 77 04                   0E43Ah:        ld      (ix+IX_REVERSE),a

                                        ; Referenced from 0E44Ch
E43D: C3 20 E2                   0E43Dh:        jp      POPALL

                                        ; Referenced from 0E42Fh
E440: FE 16                      0E440h:        cp      16h
E442: 20 0A                             jr      nz,0E44Eh
E444: DD 7E 00                          ld      a,(IX+IX_CRSROW)
E447: F6 C0                             or      0C0h
E449: DD 77 00                          ld      (IX+IX_CRSROW),a
E44C: 18 EF                             jr      0E43Dh

                                        ; Referenced from 0E442h
E44E: FE 18                      0E44Eh:        cp      18h
E450: 28 52                             jr      z,0E4A4h
E452: FE 0F                             cp      0Fh
E454: CC E0 E2                          call    z,0E2E0h
E457: 28 48                             jr      z,0E4A1h
E459: FE 0B                             cp      0Bh
E45B: CC 04 E3                          call    z,0E304h
E45E: 28 41                             jr      z,0E4A1h
E460: FE 0E                             cp      0Eh
E462: CA 18 E2                          jp      z,0E218h
E465: FE 08                             cp      08h
E467: 28 07                             jr      z,0E470h
E469: FE 09                             cp      09h
E46B: 28 24                             jr      z,0E491h
E46D: C3 03 E2                          jp      0E203h

                                        ; Referenced from 0E467h
E470: 7D                         0E470h:        ld      a,l
E471: E6 3F                             and     3Fh     ; '?'
E473: DD BE 02                          cp      (ix+IX_CRSCOL)
E476: 20 16                             jr      nz,0E48Eh
E478: CD 7E E2                          call    0E27Eh
E47B: DD BE 00                          cp      (IX+IX_CRSROW)
E47E: 28 21                             jr      z,0E4A1h
E480: 7D                                ld      a,l
E481: E6 C0                             and     0C0h
E483: DD B6 03                          or      (ix+IX_CRSCOL_MAX)
E486: 6F                                ld      l,a
E487: 01 C0 FF                          ld      bc,0FFC0h
E48A: 09                                add     hl,bc

                                        ; Referenced from 0E48Fh, 0E4AAh
E48B: C3 3C E2                   0E48Bh:        jp      0E23Ch

                                        ; Referenced from 0E476h
E48E: 2D                         0E48Eh:        dec     l
E48F: 18 FA                             jr      0E48Bh

                                        ; Referenced from 0E46Bh
E491: 7D                         0E491h:        ld      a,l
E492: E6 07                             and     07h
E494: D6 08                             sub     08h
E496: ED 44                             neg
E498: 47                                ld      b,a

                                        ; Referenced from 0E49Fh
E499: CD CB E2                   0E499h:        call    0E2CBh
E49C: CA 2F E2                          jp      z,CHAR_LF
E49F: 10 F8                             djnz    0E499h

                                        ; Referenced from 0E457h, 0E45Eh, 0E47Eh
E4A1: C3 1D E2                   0E4A1h:        jp      CHAR_NULL

                                        ; Referenced from 0E450h
E4A4: CD BF E2                   0E4A4h:        call    0E2BFh
E4A7: CD 6F E2                          call    UPDATE_CURSORPTR
E4AA: 18 DF                             jr      0E48Bh

E4AC: FF                         0E4ACh:        rst     0x38
E4AD: FF                         0E4ADh:        rst     0x38
E4AE: FF                         0E4AEh:        rst     0x38
E4AF: FF                         0E4AFh:        rst     0x38

;
; comes here from PRTCHAR, this piece was added later
;
PRTCHAR_CONT1:
               call    NOBLK1
               ld      h,(IX+IX_CSRADDR+1)
               jp      PRTCHAR_CONT2

;
; NOBLK - no blink attende i segnali di sincronia del video HSYNC e VSYNC
;
NOBLK1:        push    af
NOBLK2:        in      a,(CASSETTE)
               bit     3,a
               jr      nz,NOBLK2         ; wait for bit 3 to become 0
NOBLK3:        in      a,(CASSETTE)
               bit     2,a
               jr      z,NOBLK3          ; wait for bit 2 to become 1
               pop     af
               ret

                                        ; Referenced from 0E298h
                                        ; --- START PROC 0E4C8h ---
E4C8: CD B9 E4                   0E4C8h:        call    NOBLK1
E4CB: C3 B4 E2                          jp      0E2B4h

                                        ; Referenced from 0E2AFh, 0E2BFh
                                        ; --- START PROC 0E4CEh ---
E4CE: CD B9 E4                   0E4CEh:        call    NOBLK1
E4D1: CD 86 E2                          call    0E286h
E4D4: DD 7E 04                          ld      a,(ix+IX_REVERSE)
E4D7: E6 80                             and     80h
E4D9: C6 20                             add     a,20h   ; ' '
E4DB: 47                                ld      b,a

                                        ; Referenced from 0E4E1h
E4DC: 78                         0E4DCh:        ld      a,b
E4DD: 77                                ld      (hl),a
E4DE: CD CB E2                          call    0E2CBh
E4E1: 20 F9                             jr      nz,0E4DCh
E4E3: C9                                ret

E4E4: 01 32 86                   0E4E4h:        ld      bc,8632h
E4E7: 37                                scf
E4E8: CD 05 29                          call    2905h
E4EB: 21 FE 36                          ld      hl,36FEh
E4EE: CB A6                             res     4,(hl)
E4F0: C9                                ret

E4F1: CB D6                      0E4F1h:        set     2,(hl)
E4F3: CB 4E                             bit     1,(hl)
E4F5: 01 08 00                          ld      bc,0008h
E4F8: 28 0F                             jr      z,0E509h
E4FA: CB E6                             set     4,(hl)
E4FC: 21 08 37                          ld      hl,3708h
E4FF: ED B0                             ldir
E501: CD 92 35                          call    3592h
E504: 30 09                             jr      nc,0E50Fh
E506: EB                                ex      de,hl
E507: 18 0C                             jr      0E515h

                                        ; Referenced from 0E4F8h
E509: EB                         0E509h:        ex      de,hl
E50A: 11 08 37                          ld      de,3708h
E50D: ED B0                             ldir

                                        ; Referenced from 0E504h
E50F: 2A 2E 37                   0E50Fh:        ld      hl,(372Eh)
E512: 2B                                dec     hl
E513: 18 04                             jr      0E519h

                                        ; Referenced from 0E507h
E515: 11 07 00                   0E515h:        ld      de,0007h
E518: 19                                add     hl,de

                                        ; Referenced from 0E513h
E519: E5                         0E519h:        push    hl
E51A: 01 07 00                          ld      bc,0007h
E51D: A7                                and     a
E51E: ED 42                             sbc     hl,bc
E520: E5                                push    hl
E521: ED 4B 20 37                       ld      bc,(3720h)
E525: ED 42                             sbc     hl,bc
E527: 4D                                ld      c,l
E528: 44                                ld      b,h
E529: E1                                pop     hl
E52A: 2B                                dec     hl
E52B: D1                                pop     de
E52C: 79                                ld      a,c
E52D: B0                                or      b
E52E: 28 02                             jr      z,0E532h
E530: ED B8                             lddr

                                        ; Referenced from 0E52Eh
E532: 21 0F 37                   0E532h:        ld      hl,370Fh
E535: 01 08 00                          ld      bc,0008h
E538: ED B8                             lddr
E53A: C9                                ret

E53B: 21 FE 36                   0E53Bh:        ld      hl,36FEh
E53E: CB DE                             set     3,(hl)
E540: 2A 06 37                          ld      hl,(3706h)
E543: 01 7F 00                          ld      bc,007Fh
E546: A7                                and     a
E547: ED 42                             sbc     hl,bc
E549: 22 06 37                          ld      (3706h),hl
E54C: 21 80 37                          ld      hl,3780h
E54F: CD E9 28                          call    28E9h
E552: 2A C0 13                          ld      hl,(13C0h)
E555: ED 4B 20 37                       ld      bc,(3720h)
E559: AF                                xor     a
E55A: ED 42                             sbc     hl,bc
E55C: 06 0A                             ld      b,0Ah
E55E: 3E 00                             ld      a,00h

                                        ; Referenced from 0E566h
E560: CB 3C                      0E560h:        srl     h
E562: CB 1D                             rr      l
E564: CE 00                             adc     a,00h
E566: 10 F8                             djnz    0E560h
E568: 28 01                             jr      z,0E56Bh
E56A: 2C                                inc     l

                                        ; Referenced from 0E568h
E56B: 7D                         0E56Bh:        ld      a,l
E56C: 32 86 37                          ld      (3786h),a
E56F: 2A 20 37                          ld      hl,(3720h)
E572: 22 82 37                          ld      (3782h),hl

                                        ; Referenced from 0E67Bh
E575: 21 80 37                   0E575h:        ld      hl,3780h
E578: 36 24                             ld      (hl),24h        ; '$'
E57A: CD 05 29                          call    2905h
E57D: 2A 2E 37                          ld      hl,(372Eh)
E580: 22 82 37                          ld      (3782h),hl
E583: 21 80 37                          ld      hl,3780h
E586: 36 1A                             ld      (hl),1Ah
E588: CD 05 29                          call    2905h
E58B: C9                                ret

E58C: 21 08 37                   0E58Ch:        ld      hl,3708h
E58F: C3 8A 28                          jp      288Ah

E592: 2A 20 37                   0E592h:        ld      hl,(3720h)
E595: ED 4B 06 37                       ld      bc,(3706h)
E599: 18 06                             jr      0E5A1h

E59B: 2A 2E 37                   0E59Bh:        ld      hl,(372Eh)
E59E: 01 80 00                          ld      bc,0080h

                                        ; Referenced from 0E599h
E5A1: CD A9 35                   0E5A1h:        call    35A9h
E5A4: EB                                ex      de,hl
E5A5: 21 FE 36                          ld      hl,36FEh
E5A8: C9                                ret

E5A9: 78                         0E5A9h:        ld      a,b
E5AA: B1                                or      c
E5AB: C8                                ret     z
E5AC: C5                                push    bc
E5AD: 41                                ld      b,c
E5AE: 3A 08 37                          ld      a,(3708h)
E5B1: 4F                                ld      c,a
E5B2: 11 08 00                          ld      de,0008h
E5B5: D9                                exx
E5B6: C1                                pop     bc
E5B7: 04                                inc     b

                                        ; Referenced from 0E5C6h
E5B8: D9                         0E5B8h:        exx

                                        ; Referenced from 0E5C3h
E5B9: 7E                         0E5B9h:        ld      a,(hl)
E5BA: FE FF                             cp      0FFh
E5BC: C8                                ret     z
E5BD: 91                                sub     c
E5BE: E6 7F                             and     7Fh     ; ''
E5C0: 28 08                             jr      z,0E5CAh
E5C2: 19                                add     hl,de
E5C3: 10 F4                             djnz    0E5B9h
E5C5: D9                                exx
E5C6: 10 F0                             djnz    0E5B8h

                                        ; Referenced from 0E678h, 0E790h, 0EB90h
                                        ; --- START PROC 0E5C8h ---
E5C8: AF                         0E5C8h:        xor     a
E5C9: C9                                ret

                                        ; Referenced from 0E5C0h
E5CA: E5                         0E5CAh:        push    hl
E5CB: D9                                exx
E5CC: E1                                pop     hl
E5CD: 23                                inc     hl
E5CE: C5                                push    bc
E5CF: 06 05                             ld      b,05h
E5D1: 11 09 37                          ld      de,3709h

                                        ; Referenced from 0E5DCh
E5D4: 1A                         0E5D4h:        ld      a,(de)
E5D5: 96                                sub     (hl)
E5D6: E6 7F                             and     7Fh     ; ''
E5D8: 20 08                             jr      nz,0E5E2h
E5DA: 13                                inc     de
E5DB: 23                                inc     hl
E5DC: 10 F6                             djnz    0E5D4h
E5DE: C1                                pop     bc
E5DF: 37                                scf
E5E0: D9                                exx
E5E1: C9                                ret

                                        ; Referenced from 0E5D8h
E5E2: C1                         0E5E2h:        pop     bc
E5E3: D9                                exx
E5E4: C3 C2 35                          jp      35C2h

E5E7: 54                         0E5E7h:        ld      d,h
E5E8: 45                                ld      b,l
E5E9: 53                                ld      d,e
E5EA: 54                                ld      d,h
E5EB: 56                                ld      d,(hl)
E5EC: 20 3A                             jr      nz,0E627h+1     ; reference not aligned to instruction
E5EE: FE 36                             cp      36h     ; '6'
E5F0: CB 4F                             bit     1,a
E5F2: C0                                ret     nz
E5F3: 21 08 37                          ld      hl,3708h
E5F6: ED 5B 1E 37                       ld      de,(371Eh)
E5FA: 01 06 00                          ld      bc,0006h
E5FD: ED B0                             ldir
E5FF: 2A 3D 3D                          ld      hl,(3D3Dh)
E602: 3D                                dec     a
E603: CB 1F                             rr      a
E605: CB 17                             rl      a
E607: C9                                ret

E608: CB 1F                      0E608h:        rr      a
E60A: CB 17                             rl      a
E60C: C0                                ret     nz
E60D: 3C                                inc     a
E60E: CB 1F                             rr      a
E610: CB 17                             rl      a
E612: C9                                ret

E613: CB 1F                      0E613h:        rr      a
E615: CB 17                             rl      a
E617: E2 C2 16                          jp      po,16C2h
E61A: C3 B2 16                          jp      16B2h

E61D: CB 1F                      0E61Dh:        rr      a
E61F: CB 17                             rl      a
E621: E2 7F 1B                          jp      po,1B7Fh
E624: C3 7E 1B                          jp      1B7Eh

                                        ; Referenced from 0E5ECh
E627: CB 1F                      0E627h:        rr      a
E629: CB 17                             rl      a
E62B: E2 9E 1C                          jp      po,1C9Eh
E62E: C3 B5 1C                          jp      1CB5h

E631: C5                         0E631h:        push    bc
E632: 47                                ld      b,a
E633: D6 05                             sub     05h
E635: CB 1F                             rr      a
E637: CB 17                             rl      a
E639: 78                                ld      a,b
E63A: C1                                pop     bc
E63B: EA 88 32                          jp      pe,3288h
E63E: C3 31 32                          jp      3231h

E641: 3E 0D                      0E641h:        ld      a,0Dh
E643: CD 50 E6                          call    EPROM_LPRINT
E646: 3E 0A                             ld      a,0Ah
E648: 00                                nop
E649: 00                                nop
E64A: 00                                nop
E64B: 3E 01                             ld      a,01h
E64D: C3 C5 0D                          jp      0DC5h

                                        ; Referenced from 0E643h
                                        ; --- START PROC EPROM_LPRINT ---
E650: F5                         EPROM_LPRINT:        push    af

                                        ; Referenced from 0E654h
E651: DB 5D                      0E651h:        in      a,(5Dh) ; ']'
E653: 0F                                rrca
E654: 38 FB                             jr      c,0E651h
E656: F1                                pop     af
E657: F5                                push    af
E658: 00                                nop
E659: D3 5C                             out     (5Ch),a ; '\'
E65B: DD 7E 00                          ld      a,(IX+IX_CRSROW)
E65E: CB 97                             res     2,a
E660: D3 5D                             out     (5Dh),a ; ']'
E662: 3E C0                             ld      a,0C0h

                                        ; Referenced from 0E665h
E664: 3D                         0E664h:        dec     a
E665: 20 FD                             jr      nz,0E664h
E667: DD 7E 00                          ld      a,(IX+IX_CRSROW)
E66A: CB D7                             set     2,a
E66C: D3 5D                             out     (5Dh),a ; ']'
E66E: F1                                pop     af
E66F: C9                                ret

E670: 3A 00 DC                   0E670h:        ld      a,(0DC00h)
E673: FE C3                             cp      0C3h
E675: CA 18 DC                          jp      z,0DC18h
E678: CD C8 E5                          call    0E5C8h
E67B: C3 77 E5                          jp      0E575h+2        ; reference not aligned to instruction

E67E: FF                         0E67Eh:        rst     0x38

E67F: FF                         0E67Fh:        rst     0x38

                                        ; Referenced from 0E691h, 0E6C8h
                                        ; --- START PROC 0E680h ---
E680: 3E 01                      0E680h:        ld      a,01h
E682: D3 79                             out     (79h),a ; 'y'
E684: 3E 40                             ld      a,40h   ; '@'
E686: D3 79                             out     (79h),a ; 'y'
E688: 3E CD                             ld      a,0CDh
E68A: D3 79                             out     (79h),a ; 'y'
E68C: 3E 15                             ld      a,15h
E68E: D3 79                             out     (79h),a ; 'y'
E690: C9                                ret

E691: CD 80 E6                   0E691h:        call    0E680h

                                        ; Referenced from 0E694h
E694: 18 FE                      0E694h:        jr      0E694h

                                        ; Referenced from 0E6ACh, 0E6B1h, 0E6B6h
                                        ; --- START PROC 0E696h ---
E696: F5                         0E696h:        push    af

                                        ; Referenced from 0E69Bh
E697: DB 79                      0E697h:        in      a,(79h) ; 'y'
E699: CB 57                             bit     2,a
E69B: 28 FA                             jr      z,0E697h
E69D: F1                                pop     af
E69E: D3 78                             out     (78h),a ; 'x'
E6A0: C9                                ret

                                        ; Referenced from 0E6A5h
E6A1: DB 79                      0E6A1h:        in      a,(79h) ; 'y'
E6A3: CB 4F                             bit     1,a
E6A5: 28 FA                             jr      z,0E6A1h
E6A7: DB 78                             in      a,(78h) ; 'x'
E6A9: C9                                ret

E6AA: 3E 0D                      0E6AAh:        ld      a,0Dh
E6AC: CD 96 E6                          call    0E696h
E6AF: 3E 0A                             ld      a,0Ah
E6B1: CD 96 E6                          call    0E696h
E6B4: 3E 00                             ld      a,00h
E6B6: CD 96 E6                          call    0E696h
E6B9: 3E 01                             ld      a,01h
E6BB: C3 C5 0D                          jp      0DC5h

E6BE: 3E AA                      0E6BEh:        ld      a,0AAh
E6C0: 32 C2 0D                          ld      (0DC2h),a
E6C3: 3E 96                             ld      a,96h
E6C5: 32 84 0D                          ld      (0D84h),a
E6C8: CD 80 E6                          call    0E680h
E6CB: C3 00 00                          jp      0000h

E6CE: FF                         0E6CEh:        rst     0x38

E6CF: FF                         0E6CFh:        rst     0x38

E6D0: FF                         0E6D0h:        rst     0x38

E6D1: FF                         0E6D1h:        rst     0x38

E6D2: FF                         0E6D2h:        rst     0x38

E6D3: FF                         0E6D3h:        rst     0x38

E6D4: FF                         0E6D4h:        rst     0x38

E6D5: FF                         0E6D5h:        rst     0x38

E6D6: FF                         0E6D6h:        rst     0x38

E6D7: FF                         0E6D7h:        rst     0x38

E6D8: FF                         0E6D8h:        rst     0x38

E6D9: FF                         0E6D9h:        rst     0x38

E6DA: FF                         0E6DAh:        rst     0x38

E6DB: FF                         0E6DBh:        rst     0x38

E6DC: FF                         0E6DCh:        rst     0x38

E6DD: FF                         0E6DDh:        rst     0x38

E6DE: FF                         0E6DEh:        rst     0x38

E6DF: FF                         0E6DFh:        rst     0x38

                                        ; Referenced from 0E748h, 0E753h, 0EB48h, 0EB53h
                                        ; --- START PROC 0E6E0h ---
E6E0: FE 02                      0E6E0h:        cp      02h
E6E2: C2 35 E7                          jp      nz,0E735h
E6E5: 7E                                ld      a,(hl)
E6E6: 23                                inc     hl
E6E7: 66                                ld      h,(hl)
E6E8: 6F                                ld      l,a
E6E9: CD 0C DC                          call    0DC0Ch
E6EC: C9                                ret

E6ED: FF                         0E6EDh:        rst     0x38
E6EE: FF                         0E6EEh:        rst     0x38
E6EF: FF                         0E6EFh:        rst     0x38
E6F0: FF                         0E6F0h:        rst     0x38
E6F1: FF                         0E6F1h:        rst     0x38
E6F2: FF                         0E6F2h:        rst     0x38
E6F3: FF                         0E6F3h:        rst     0x38
E6F4: FF                         0E6F4h:        rst     0x38
E6F5: FF                         0E6F5h:        rst     0x38
E6F6: FF                         0E6F6h:        rst     0x38
E6F7: FF                         0E6F7h:        rst     0x38
E6F8: FF                         0E6F8h:        rst     0x38
E6F9: FF                         0E6F9h:        rst     0x38
E6FA: FF                         0E6FAh:        rst     0x38
E6FB: FF                         0E6FBh:        rst     0x38
E6FC: FF                         0E6FCh:        rst     0x38
E6FD: FF                         0E6FDh:        rst     0x38
E6FE: FF                         0E6FEh:        rst     0x38
E6FF: FF                         0E6FFh:        rst     0x38

E700: FE 02                      0E700h:        cp      02h
E702: 20 28                             jr      nz,0E72Ch
E704: 7E                                ld      a,(hl)
E705: 23                                inc     hl
E706: 66                                ld      h,(hl)
E707: 6F                                ld      l,a
E708: 29                                add     hl,hl
E709: 29                                add     hl,hl
E70A: 29                                add     hl,hl
E70B: E5                                push    hl
E70C: E6 1F                             and     1Fh
E70E: 4F                                ld      c,a
E70F: CD 06 DC                          call    0DC06h
E712: E1                                pop     hl
E713: 7C                                ld      a,h
E714: C6 07                             add     a,07h
E716: 4F                                ld      c,a
E717: FE 4E                             cp      4Eh     ; 'N'
E719: 21 00 00                          ld      hl,0000h
E71C: 38 03                             jr      c,0E721h
E71E: 23                                inc     hl
E71F: 18 05                             jr      0E726h

                                        ; Referenced from 0E71Ch
E721: E5                         0E721h:        push    hl
E722: CD 03 DC                          call    0DC03h
E725: E1                                pop     hl

                                        ; Referenced from 0E71Fh, 0E751h
E726: E5                         0E726h:        push    hl
E727: 2A 06 00                          ld      hl,(0006h)
E72A: E3                                ex      (sp),hl
E72B: C9                                ret

                                        ; Referenced from 0E702h, 0E737h
E72C: 1E 0D                      0E72Ch:        ld      e,0Dh

                                        ; Referenced from 0E733h
E72E: C3 48 08                   0E72Eh:        jp      0848h

                                        ; Referenced from 0E73Ch
E731: 1E 06                      0E731h:        ld      e,06h
E733: 18 F9                             jr      0E72Eh

                                        ; Referenced from 0E6E2h
E735: FE 03                      0E735h:        cp      03h
E737: 20 F3                             jr      nz,0E72Ch
E739: 1A                                ld      a,(de)
E73A: FE 80                             cp      80h
E73C: 38 F3                             jr      c,0E731h
E73E: 13                                inc     de
E73F: 1A                                ld      a,(de)
E740: 6F                                ld      l,a
E741: 13                                inc     de
E742: 1A                                ld      a,(de)
E743: 67                                ld      h,a
E744: CD 0C DC                          call    0DC0Ch
E747: C9                                ret

E748: CD E0 E6                   0E748h:        call    0E6E0h
E74B: CD 12 DC                          call    0DC12h

                                        ; Referenced from 0E759h
E74E: 21 00 00                   0E74Eh:        ld      hl,0000h
E751: 18 D3                             jr      0E726h

E753: CD E0 E6                   0E753h:        call    0E6E0h
E756: CD 0F DC                          call    0DC0Fh
E759: 18 F3                             jr      0E74Eh

E75B: 3E 04                      0E75Bh:        ld      a,04h
E75D: 32 00 DC                          ld      (0DC00h),a
E760: C9                                ret

E761: 20 20                      0E761h:        jr      nz,0E783h
E763: 20 20                             jr      nz,0E785h
E765: 20 20                             jr      nz,0E786h+1     ; reference not aligned to instruction
E767: 20 47                             jr      nz,0E7B0h
E769: 45                                ld      b,l
E76A: 4E                                ld      c,(hl)
E76B: 45                                ld      b,l
E76C: 52                                ld      d,d
E76D: 41                                ld      b,c
E76E: 4C                                ld      c,h
E76F: 20 20                             jr      nz,0E790h+1     ; reference not aligned to instruction
E771: 50                                ld      d,b
E772: 52                                ld      d,d
E773: 4F                                ld      c,a
E774: 43                                ld      b,e
E775: 45                                ld      b,l
E776: 53                                ld      d,e
E777: 53                                ld      d,e
E778: 4F                                ld      c,a
E779: 52                                ld      d,d
E77A: 20 20                             jr      nz,0E79Ch
E77C: 2D                                dec     l
E77D: 20 20                             jr      nz,0E79Fh
E77F: 46                                ld      b,(hl)
E780: 49                                ld      c,c
E781: 52                                ld      d,d
E782: 45                                ld      b,l

                                        ; Referenced from 0E761h
E783: 4E                         0E783h:        ld      c,(hl)
E784: 5A                                ld      e,d

                                        ; Referenced from 0E763h
E785: 45                         0E785h:        ld      b,l

                                        ; Referenced from 0E765h
E786: 18 0D                      0E786h:        jr      0E795h

E788: 0A                         0E788h:        ld      a,(bc)
E789: 00                                nop
E78A: FF                                rst     0x38

E78B: FF                         0E78Bh:        rst     0x38

E78C: FF                         0E78Ch:        rst     0x38

E78D: FF                         0E78Dh:        rst     0x38

E78E: FF                         0E78Eh:        rst     0x38

E78F: FF                         0E78Fh:        rst     0x38

                                        ; Referenced from 0E76Fh
E790: CD C8 E5                   0E790h:        call    0E5C8h
E793: 3E AC                             ld      a,0ACh

                                        ; Referenced from 0E786h
E795: 06 A0                      0E795h:        ld      b,0A0h
E797: 21 00 A4                          ld      hl,0A400h

                                        ; Referenced from 0E79Dh
E79A: 70                         0E79Ah:        ld      (hl),b
E79B: 23                                inc     hl

                                        ; Referenced from 0E77Ah
E79C: BC                         0E79Ch:        cp      h
E79D: 20 FB                             jr      nz,0E79Ah

                                        ; Referenced from 0E77Dh
E79F: 21 45 A7                   0E79Fh:        ld      hl,0A745h
E7A2: 22 E7 3F                          ld      (3FE7h),hl
E7A5: 21 61 E7                          ld      hl,0E761h

                                        ; Referenced from 0E7B0h
E7A8: 7E                         0E7A8h:        ld      a,(hl)
E7A9: CD 03 E4                          call    PRTCHAR
E7AC: B7                                or      a
E7AD: 28 03                             jr      z,0E7B2h
E7AF: 23                                inc     hl

                                        ; Referenced from 0E767h
E7B0: 18 F6                      0E7B0h:        jr      0E7A8h

                                        ; Referenced from 0E7ADh
E7B2: 21 00 AA                   0E7B2h:        ld      hl,0AA00h
E7B5: 3E 00                             ld      a,00h
E7B7: 06 40                             ld      b,40h   ; '@'

                                        ; Referenced from 0E7C1h
E7B9: 77                         0E7B9h:        ld      (hl),a
E7BA: 23                                inc     hl
E7BB: 77                                ld      (hl),a
E7BC: 23                                inc     hl
E7BD: 77                                ld      (hl),a
E7BE: 23                                inc     hl
E7BF: C6 11                             add     a,11h
E7C1: 10 F6                             djnz    0E7B9h
E7C3: 21 40 A4                          ld      hl,0A440h
E7C6: 3E 0B                             ld      a,0Bh

                                        ; Referenced from 0E7CBh
E7C8: 77                         0E7C8h:        ld      (hl),a
E7C9: 23                                inc     hl
E7CA: 3C                                inc     a
E7CB: 10 FB                             djnz    0E7C8h

                                        ; Referenced from 0E7D0h
E7CD: C3 E0 E7                   0E7CDh:        jp      0E7E0h

E7D0: 30 FB                      0E7D0h:        jr      nc,0E7CDh
E7D2: F1                                pop     af
E7D3: F5                                push    af
E7D4: 2F                                cpl
E7D5: D3 CD                             out     (0CDh),a
E7D7: 3E FF                             ld      a,0FFh
E7D9: D3 CC                             out     (0CCh),a
E7DB: AF                                xor     a
E7DC: D3 CC                             out     (0CCh),a
E7DE: F1                                pop     af
E7DF: C9                                ret

                                        ; Referenced from 0E7CDh, 0E7E7h, 0EBCDh, 0EBE7h
E7E0: CD EE E7                   0E7E0h:        call    0E7EEh
E7E3: 47                                ld      b,a
E7E4: CD 03 E4                          call    PRTCHAR
E7E7: C3 E0 E7                          jp      0E7E0h

E7EA: FF                         0E7EAh:        rst     0x38

E7EB: FF                         0E7EBh:        rst     0x38

E7EC: FF                         0E7ECh:        rst     0x38

E7ED: FF                         0E7EDh:        rst     0x38

                                        ; Referenced from 0E7E0h, 0E7F1h, 0EBE0h
                                        ; --- START PROC 0E7EEh ---
E7EE: DB D8                      0E7EEh:        in      a,(0D8h)
E7F0: 07                                rlca
E7F1: 38 FB                             jr      c,0E7EEh
E7F3: 0F                                rrca
E7F4: 2F                                cpl
E7F5: F5                                push    af

                                        ; Referenced from 0E7F9h
E7F6: DB D8                      0E7F6h:        in      a,(0D8h)
E7F8: 07                                rlca
E7F9: 30 FB                             jr      nc,0E7F6h
E7FB: F1                                pop     af
E7FC: E6 7F                             and     7Fh     ; ''
E7FE: C9                                ret

E7FF: A1                         0E7FFh:        and     c

