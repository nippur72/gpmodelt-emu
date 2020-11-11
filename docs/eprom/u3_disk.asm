;***************************************************************************************
;
; U3 DISK EPROM
;
;***************************************************************************************

EPROM_INITD:            jp      EPROM_INITD1                ; ok
EPROM_SETTRACK:         jp      EPROM_SETTRACK1             ; ok
EPROM_SETSECTOR:        jp      EPROM_SETSECTOR1            ; ok
EPROM_SETDRIVE:         jp      EPROM_SETDRIVE1             ; ok
EPROM_SETDMA:           jp      EPROM_SETDMA1               ; ok
EPROM_WRITESECTOR:      jp      EPROM_WRITESECTOR1          ; ok
EPROM_READSECTOR:       jp      EPROM_READSECTOR1           ; ok
BOOT_DISK_0103H0:       jp      BOOT_DISK_0103H             ; ok
BOOT_FROM_DISK:         jp      BOOT_DISK_0100H             ; ok
READ_ADDRESS:           jp      READ_ADDRESS1               ; ok
SET_TRACK_2_ENTRY:      jp      SET_TRACK_2                 ; ok
VERIFY_TRACK:           jp      VERIFY_TRACK1               ; ok not formatted
FILL_TRACK:             jp      FILL_TRACK1                 ; ok not formatted
SET_IX_STATUS:          jp      SET_IX_S1                   ; ok
SET_IX_READ:            jp      SET_IX_R1                   ; ok
SET_IX_WRITE:           jp      SET_IX_W1                   ; ok
DISK_ERROR:             jp      DISK_ERROR_1                ; ok
READ_FDC_STATUS0:       jp      READ_FDC_STATUS1            ; most
RESTORE_FDC:            jp      RESTORE                     ; ok
BOOT_DISK0:             jp      BOOT_DISK1                  ; ok
SEEK:                   jp      SEEK_1                      ; ok
SEEK_FATAL:             jp      SEEK_2                      ; ok
RESTORE_ALT0:           jp      RESTORE_ALT1                ; most

;***************************************************************************************
;
; end of jump table
;
;***************************************************************************************

DISK_ERROR_MSG:
        ; "DISK ERROR",$A0
        DB $44
        DB $49
        DB $53
        DB $4B
        DB $20
        DB $52
        DB $52
        DB $4F
        DB $52
        DB $A0

;***************************************************************************************
;
; SET_IX - sets the IX pointer to the sytem variable area and sets the status
;          mask for READ/WRITE/SEEK
;
;***************************************************************************************

SET_IX_R1:    ld      b,9Eh                      ; mask for read commands
              jr      SET_IX_FINAL
SET_IX_S1:    ld      b,98h                      ; mask for seek commands
              jr      SET_IX_FINAL
SET_IX_W1:    ld      b,0DEh                     ; mask for write commands
              ;
SET_IX_FINAL: ld      ix,(VDDPOINTER)            ; ix points to system variables table
              ld      (ix+IX_STMASK),b           ; sets the FDC status mask
              ld      (ix+IX_NRETRY),0Fh         ; sets the sector number 0Fh = 00 negato
              ret

;***************************************************************************************
;
; READ_FDC_STATUS - reads the status of the FDC
;
;***************************************************************************************

READ_FDC_STATUS1:
        in      a,(DRIVESEL)            ; read drive status latch
        bit     6,a                     ; check for INTREQ (command completed)
        jr      z,READ_FDC_STATUS1      ; loop if not completed
        dec     (ix+IX_NRETRY)          ; ??? increment sector
        jp      z,SEEK_FATAL            ; ???
        ld      a,07h                   ; ???
        cp      (ix+IX_NRETRY)          ; ???
        jr      nz,READ_FDC_STATUS_END  ; ???
        call    RESTORE_ALT0            ; ???
        ret

READ_FDC_STATUS_END:
        in      a,(FDCCMD)                ; read status from 1791
        cpl                               ; negate
        ld      (ix+IX_DSKSTATUS),a       ; store status in system area
        and     (ix+IX_STMASK)            ; mask value in a
        ret

;***************************************************************************************
;
; INITD - initializes the IX pointer, sets track 0 and
;         isse a RESTORE command on the FDC
;
;***************************************************************************************

EPROM_INITD1:
        call    SET_IX_STATUS               ; set IX pointer to VDD table
        ld      (ix+IX_TRKNUM),00h    ; reset track

RESTORE:
        ld      a,0FBh                    ; RESTORE COMMAND, F3h on 5.25
        out     (FDCCMD),a
        call    READ_FDC_STATUS0          ; reads FDC status
        ret     z
        jr      RESTORE                   ; loop if not ok

;***************************************************************************************
;
; SETSECTOR - sets the sector number in C on the FDC
;
;***************************************************************************************

EPROM_SETSECTOR1:
        ld      a,c
        cpl
        out     (FDCSEC),a
        ret

;***************************************************************************************
;
; SETTRACK - sets the track in C on the FDC and moves the drive head to the
;            desidered track via SEEK command
;
;***************************************************************************************

EPROM_SETTRACK1:
       call    SET_IX_STATUS         ; set IX and preparese for SEEK
       ld      (ix+IX_TRKNUM),c      ; sets track number
       ld      a,4Ch                 ; max track, 27h on 5.25"
       cp      c
       jp      c,DISK_ERROR          ; tracks number too high
SET_TRACK_2:
       ld      a,(ix+IX_TRKNUM)      ; gets current track number
       cpl                           ; negate it for the FDC
       out     (FDCDATA),a           ; send track number as data parameter for SEEK
       ld      a,0EBh                ; SEEK COMMAND,  E3h on 5.25"
       out     (FDCCMD),a            ; send SEEK to FDC
       call    READ_FDC_STATUS0      ; read FDC status
       ret     z                     ; ends if ok
       call    RESTORE_FDC           ; else restore FDC
       jr      SET_TRACK_2           ; and retry again

;***************************************************************************************
;
; READ SECTOR
;
;***************************************************************************************

EPROM_READSECTOR1:
       call    SET_IX_READ                  ; set IX and prepare for read

READ_SECTOR_START:
       ld      c,FDCDATA                    ; prepares the IN port for ini
       ld      h,(ix+IX_DSKBUF+1)     ;
       ld      l,(ix+IX_DSKBUF+0)     ; hl points to sector buffer
       ld      a,7Fh                        ; read sector command (negated)
       out     (FDCCMD),a                   ; send command to FDC
       jr      READ_WAIT

       nop                                  ; filler
       nop
       nop

READ_BYTE:
       ini                                  ; read byte from FDC

READ_WAIT:
       in      a,(DRIVESEL)                 ; reads FDC status latch
       rlca                                 ; test bit 7 (data ready)
       jr      c,READ_BYTE                  ; if ready read next byte
       in      a,(DRIVESEL)
       rlca
       jr      c,READ_BYTE
       in      a,(DRIVESEL)
       rlca
       jr      c,READ_BYTE
       in      a,(DRIVESEL)
       rlca
       jr      c,READ_BYTE
       rlca
       jr      nc,READ_WAIT
       call    READ_FDC_STATUS0
       jr      nz,READ_SECTOR_START       ; if read not ok, retry
       ret

;***************************************************************************************
;
; SET DMA
;
;***************************************************************************************

EPROM_SETDMA1:
        call    SET_IX_STATUS             ; IX point to system vars table
        ld      (ix+IX_DSKBUF+0),l  ; set IX_DSKBUF system variable
        ld      (ix+IX_DSKBUF+1),h  ;
        ret

;***************************************************************************************
;
; WRITE SECTOR
;
;***************************************************************************************

EPROM_WRITESECTOR1:
        call    SET_IX_WRITE                ; sets IX pointer and prepares for write

WRITE_START:
       ld      c,FDCDATA                    ; prepares OUT port for outi
       ld      l,(ix+IX_DSKBUF+0)     ;
       ld      h,(ix+IX_DSKBUF+1)     ; hl points to sector buffer to write
       ld      a,5Fh                        ; write sector command negated
       out     (FDCCMD),a                   ; send command to FDC

WRITE_STORT:
       jr      WRITE_WAIT

WRITE_BYTE:
       outi                             ; write byte to FDC

WRITE_WAIT:
       in      a,(DRIVESEL)             ; read FDC status latch
       rlca                             ; test bit 7 buffer empty
       jr      c,WRITE_BYTE             ; write next byte
       in      a,(DRIVESEL)
       rlca
       jr      c,WRITE_BYTE
       in      a,(DRIVESEL)
       rlca
       jr      c,WRITE_BYTE
       in      a,(DRIVESEL)
       rlca
       jr      c,WRITE_BYTE
       in      a,(DRIVESEL)
       rlca
       jr      c,WRITE_BYTE
       in      a,(DRIVESEL)
       rlca
       jr      c,WRITE_BYTE
       rlca
       jr      nc,WRITE_WAIT
       call    READ_FDC_STATUS0        ; read FDC status
       jr      nz,WRITE_START          ; repeats if write is not ok
       ret

FILLER:
        DB $33
        DB $E8
        DB $20
        DB $D1
        DB $C9

;***************************************************************************************
;
; BOOT FROM DISK
;
;***************************************************************************************

BOOT_DISK1:
       ld      a,0FEh                    ; ??
       out     (DRIVESEL),a              ; ?? sets drive 1+2 ?
       ld      hl,0100h                  ;
       call    EPROM_SETDMA              ; sector buffer = 0100h
       ld      (ix+IX_CURRDRIVE),l    ; reset current drive
       nop
       ld      sp,ix                     ; set top of stack pointer before the system vars table
       ld      c,00h
       call    EPROM_SETTRACK            ; imposta traccia 0
       ld      c,01h                     ; 00h on 5.25"
       call    EPROM_SETSECTOR           ; imposta settore 1
       push    hl
       call    EPROM_READSECTOR          ; legge il settore e lo pone a 0100h
       pop     hl
       ld      l,e                       ; hl = 0100 + e ??
       jp      (hl)                      ; execute boot sector code

BOOT_DISK_0100H:
        ld      e,00h
        jp      BOOT_DISK0

BOOT_DISK_0103H:
        ld      e,03h                   ; dead code use to boot from disk and
        jp      BOOT_DISK0              ; jump at address 0103h

;***************************************************************************************
;
; READ ADDRESS
;
;***************************************************************************************

READ_ADDRESS1:
       nop
       nop
       nop
       call    SET_IX_READ

READ_ADDRESS_START:
       push    ix
       pop     hl
       ld      l,0F0h         ; hl now points to BFF0 at IX_RDADDRBUF
       ld      c,FDCDATA      ; prepares IN port for ini
       ld      a,3Bh          ; read address command (negated)
       out     (FDCCMD),a
       jr      READ_ADDRESS_WAIT

       nop                    ; filler
       nop
       nop

READ_ADDRESS_BYTE:
       ini

READ_ADDRESS_WAIT:
       in      a,(DRIVESEL) ; '?'
       rlca
       jr      c,READ_ADDRESS_BYTE
       in      a,(DRIVESEL) ; '?'
       rlca
       jr      c,READ_ADDRESS_BYTE
       in      a,(DRIVESEL) ; '?'
       rlca
       jr      c,READ_ADDRESS_BYTE
READ_ADDRESS_LOOP1:
       in      a,(DRIVESEL) ; '?'
       rlca
       jr      c,READ_ADDRESS_BYTE
       rlca
       jr      nc,READ_ADDRESS_LOOP1
       call    READ_FDC_STATUS0
       jr      nz,READ_ADDRESS_START
       ret

;***************************************************************************************
;
; SET DRIVE without SEEK sets the drive and updates the track the head is currently on
;           by performing a READ ADDRESS
;
;              *** apparently not used by any routine or jump table ***
;
;   C = drive number
;***************************************************************************************

SET_DRIVE_NO_SEEK:
       call    SET_IX_READ
       ld      (ix+IX_CURRDRIVE),c
       ld      a,05h
       cp      c
       jp      c,DISK_ERROR
       ld      b,c
       rr      b
       inc     b
       or      0FFh
0E9AAh:rla
       djnz    0E9AAh
       bit     0,c
       jr      z,0E9B3h
       res     3,a
0E9B3h:
       out     (DRIVESEL),a             ; selects drive number
       call    READ_ADDRESS             ; perform a read address
       ld      a,(ix+10h)               ; reads the track number the head is on (negated)
       out     (FDCTRK),a               ; sends back to FDC
       cpl                              ; negate
       ld      (ix+IX_TRKNUM),a     ; save on system variables
       ret

;***************************************************************************************
;
; VERIFY TRACK - reads all sectors onto a track incrementing them until max
;
;***************************************************************************************

VERIFY_TRACK1:
       nop
       nop
       nop
       nop
       nop
       nop
       call    SET_IX_READ
       res     4,(ix+0Dh)
0E9CFh:ld      c,0BFh
       ld      h,(ix+IX_DSKBUF+1)
       ld      l,(ix+IX_DSKBUF+0)
       ld      a,6Fh   ; 'o'
       out     (FDCCMD),a
       jr      0E9E2h
0E9DDh:nop
       nop
       nop
0E9E0h:ini
0E9E2h:in      a,(DRIVESEL) ; '?'
       rlca
       jr      c,0E9E0h
       in      a,(DRIVESEL) ; '?'
       rlca
       jr      c,0E9E0h
       in      a,(DRIVESEL) ; '?'
       rlca
       jr      c,0E9E0h
0E9F1h:in      a,(DRIVESEL) ; '?'
       rlca
       jr      c,0E9E0h
       rlca
       jr      nc,0E9F1h
       call    READ_FDC_STATUS0
       jr      nz,0E9CFh
       in      a,(FDCSEC)
       cp      0E5h
       ret     z
       dec     (ix+0Eh)
       jr      0E9CFh

;***************************************************************************************
;
; FILL TRACK - fill all sectors of a track with buffer's content
;
;***************************************************************************************
       nop   ; filler

FILL_TRACK1:
       nop
       nop
       nop
       nop
       nop
       nop
       call    SET_IX_WRITE
       res     4,(ix+0Dh)
0EA16h:ld      c,0BFh
       ld      h,(ix+IX_DSKBUF+1)
       ld      l,(ix+IX_DSKBUF+0)
       ld      a,4Fh                       ; write sector command (negated)
       out     (FDCCMD),a
       jr      0EA29h
0EA24h:nop
       nop
       nop
0EA27h:outi
0EA29h:in      a,(DRIVESEL) ; '?'
       rlca
       jr      c,0EA27h
       in      a,(DRIVESEL) ; '?'
       rlca
       jr      c,0EA27h
       in      a,(DRIVESEL) ; '?'
       rlca
       jr      c,0EA27h
0EA38h:in      a,(DRIVESEL) ; '?'
       rlca
       jr      c,0EA27h
       rlca
       jr      nc,0EA38h
       call    READ_FDC_STATUS0
       jr      nz,0EA16h
       in      a,(FDCSEC)
       cp      0E5h
       ret     z
       dec     (ix+0Eh)
       jr      0EA16h


;***************************************************************************************
;
; SEEK COMMAND
;
;***************************************************************************************

SEEK_1:     in      a,(FDCTRK)               ; legge traccia (negata) da FDC
            out     (FDCDATA),a              ; pone sul registro dati come parametro per il SEEK
            call    SET_IX_STATUS            ; imposta IX e prepara per SEEK
            ld      a,0E4h                   ; seek command (negated)
            out     (FDCCMD),a               ; invia comando SEEK
            call    READ_FDC_STATUS0         ; legge stato del FDC
SEEK_WAIT:  in      a,(DRIVESEL)             ; legge FDC latch status
            bit     4,a                      ; testa il bit 4 ??? READY ?
            jr      z,SEEK_WAIT              ; loop if not ready
            ld      a,0FFh                   ; return 1
            ret


;***************************************************************************************
;
; SEEK 2 - seek to track or display error if bit 7 is 1
;
;***************************************************************************************

SEEK_2:  bit     7,a
         jp      nz,SEEK

;
; Display the message "DISK ERROR"
;
DISK_ERROR_1:
        ld      hl,DISK_ERROR_MSG
        call    WRSTG                  ; prints "DISK ERROR"
        ld      a,20h                  ; space character
        call    PRTCHAR                ; prints a separatory space
        push    ix
        pop     bc                     ; bc = &ix[0]
        ld      c,0EFh                 ; bc is now $BFEF => IX_DSKSTATUS
        call    PTBTE                  ; prints number pointed by BC
        jp      MONITOR                ; restart machine


;***************************************************************************************
;
; RESTORE AND SET TRACK
;
;***************************************************************************************

RESTORE_ALT1:  ld      a,(ix+IX_STMASK)
               ld      (ix+16h),a               ; save mask to tmp storage
               ld      (ix+IX_STMASK),98h    ; change the mask
               call    RESTORE_FDC
               call    SET_TRACK_2_ENTRY
               ld      a,(ix+16h)               ;
               ld      (ix+IX_STMASK),a      ; restore mask from tmp storage
               inc     a                        ; ?
               ret

;***************************************************************************************
;
; SET DRIVE with seek
;
;***************************************************************************************

EPROM_SETDRIVE1:
       call    SET_IX_READ
       ld      (ix+IX_CURRDRIVE),c
       ld      a,05h
       cp      c
       jp      c,DISK_ERROR
       ld      b,c
       rr      b
       inc     b
       or      0FFh
SET_DRIVE_CALC:
       rla
       djnz    SET_DRIVE_CALC
       bit     0,c
       jr      z,SET_DRIVE_CALC1
       res     3,a
SET_DRIVE_CALC1:
       out     (DRIVESEL),a                 ; selects drive number
       call    READ_ADDRESS                 ; perform a read address
       ld      a,(ix+10h)                   ; reads the track number the head is on (negated)
       out     (FDCTRK),a                   ; sends back to FDC
       out     (FDCDATA),a                  ; sends
       cpl                                  ; negate because comes from the FDC
       ld      (ix+IX_TRKNUM),a         ; stores in system variables area
       call    SET_IX_STATUS                ; set IX pointer to system variables area
SET_DRIVE_REPEAT:
       ld      a,0E8h                       ; seek command (negated)
       out     (FDCCMD),a                   ; send a seek command
       call    READ_FDC_STATUS0             ; read disk status
       jr      nz,SET_DRIVE_LOOP            ; repeat if error
       ret

;
; END OF ROM CODE
;
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************
; **************************************************************************************

DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $39
DB $00
DB $02
DB $20
DB $28
DB $7E
DB $23
DB $29
DB $E5
DB $E6
DB $1F
DB $4F
DB $CD,$06,$DC
DB $E1
DB $7C
DB $C6,$07
DB $4F
DB $FE,$4E
DB $21,$00,$00
DB $38,$03
DB $23
DB $18,$05

DB $E5
DB $CD 03 DC
DB $E1
DB $E5
DB $2A 06 00
DB $E3
DB $C9
DB $1E 0D
DB $C3 48 08
DB $1E 06
DB $18 F9
DB $FE 03
DB $20 F3
DB $1A
DB $FE 80
DB $38 F3
DB $13
DB $1A
DB $6F
DB $13
DB $1A
DB $67
DB $CD 0C DC
DB $C9
DB $CD E0 E6
DB $CD 12 DC
DB $21 00 00
DB $18 D3
DB $CD E0 E6
DB $CD 0F DC
DB $18 F3
DB $3E 04
DB $32 00 DC
DB $C9

GENERAL_PROCESSOR_STRING:
       DB $20,$20,$20,$20,$20,$20,$20,$47,$45,$4E,$45,$52,$41,$4C,$20,$20
       DB $50,$52,$4F,$43,$45,$53,$53,$4F,$52,$20,$20,$2D,$20,$20,$46,$49
       DB $52,$45,$4E,$5A,$45,$18,$0D,$0A

EB89: 00                                nop
EB8A: FF                                rst     0x38

EB8B: FF                         0EB8Bh:        rst     0x38
EB8C: FF                         0EB8Ch:        rst     0x38
EB8D: FF                         0EB8Dh:        rst     0x38
EB8E: FF                         0EB8Eh:        rst     0x38
EB8F: FF                         0EB8Fh:        rst     0x38

                                        ; Referenced from 0EB6Fh
EB90: CD C8 E5                   0EB90h:        call    0E5C8h
EB93: 3E AC                             ld      a,0ACh

                                        ; Referenced from 0EB86h
EB95: 06 A0                      0EB95h:        ld      b,0A0h
EB97: 21 00 A4                          ld      hl,0A400h

                                        ; Referenced from 0EB9Dh
EB9A: 70                         0EB9Ah:        ld      (hl),b
EB9B: 23                                inc     hl

                                        ; Referenced from 0EB7Ah
EB9C: BC                         0EB9Ch:        cp      h
EB9D: 20 FB                             jr      nz,0EB9Ah

                                        ; Referenced from 0EB7Dh
EB9F: 21 45 A7                   0EB9Fh:        ld      hl,0A745h
EBA2: 22 E7 7F                          ld      (7FE7h),hl
EBA5: 21 61 E7                          ld      hl,0E761h

                                        ; Referenced from 0EBB0h
EBA8: 7E                         0EBA8h:        ld      a,(hl)
EBA9: CD 03 E4                          call    0E403h
EBAC: B7                                or      a
EBAD: 28 03                             jr      z,0EBB2h
EBAF: 23                                inc     hl

                                        ; Referenced from 0EB67h
EBB0: 18 F6                      0EBB0h:        jr      0EBA8h

                                        ; Referenced from 0EBADh
EBB2: 21 00 AA                   0EBB2h:        ld      hl,0AA00h
EBB5: 3E 00                             ld      a,00h
EBB7: 06 40                             ld      b,40h   ; '@'

                                        ; Referenced from 0EBC1h
EBB9: 77                         0EBB9h:        ld      (hl),a
EBBA: 23                                inc     hl
EBBB: 77                                ld      (hl),a
EBBC: 23                                inc     hl
EBBD: 77                                ld      (hl),a
EBBE: 23                                inc     hl
EBBF: C6 11                             add     a,11h
EBC1: 10 F6                             djnz    0EBB9h
EBC3: 21 40 A4                          ld      hl,0A440h
EBC6: 3E 0B                             ld      a,0Bh

                                        ; Referenced from 0EBCBh
EBC8: 77                         0EBC8h:        ld      (hl),a
EBC9: 23                                inc     hl
EBCA: 3C                                inc     a
EBCB: 10 FB                             djnz    0EBC8h

                                        ; Referenced from 0EBD0h
EBCD: C3 E0 E7                   0EBCDh:        jp      0E7E0h

EBD0: 30 FB                      0EBD0h:        jr      nc,0EBCDh
EBD2: F1                                pop     af
EBD3: F5                                push    af
EBD4: 2F                                cpl
EBD5: D3 CD                             out     (0CDh),a
EBD7: 3E FF                             ld      a,0FFh
EBD9: D3 CC                             out     (0CCh),a
EBDB: AF                                xor     a
EBDC: D3 CC                             out     (0CCh),a
EBDE: F1                                pop     af
EBDF: C9                                ret

EBE0: CD EE E7                   0EBE0h:        call    0E7EEh
EBE3: 47                                ld      b,a
EBE4: CD 03 E4                          call    0E403h
EBE7: C3 E0 E7                          jp      0E7E0h

EBEA: FF                         0EBEAh:        rst     0x38

EBEB: FF                         0EBEBh:        rst     0x38

EBEC: FF                         0EBECh:        rst     0x38

EBED: FF                         0EBEDh:        rst     0x38

                                        ; Referenced from 0EBF1h
EBEE: DB D8                      0EBEEh:        in      a,(0D8h)
EBF0: 07                                rlca
EBF1: 38 FB                             jr      c,0EBEEh
EBF3: 0F                                rrca
EBF4: 2F                                cpl
EBF5: F5                                push    af

                                        ; Referenced from 0EBF9h
EBF6: DB D8                      0EBF6h:        in      a,(0D8h)
EBF8: 07                                rlca
EBF9: 30 FB                             jr      nc,0EBF6h
EBFB: F1                                pop     af
EBFC: E6 7F                             and     7Fh     ; ''
EBFE: C9                                ret

EBFF: FF                         0EBFFh:        rst     0x38



