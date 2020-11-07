
;                                  CHECK_CHANGED_TRKSEC:                     ; Referenced from BC57, BC66
; BCD4: 3A DC BF                          ld      a,(CURRDRIVE)
; BCD7: 4F                                ld      c,a
; BCD8: 3A DD BF                          ld      a,(LAST_DRIVE)
; BCDB: B9                                cp      c
; BCDC: 79                                ld      a,c
; BCDD: 32 DD BF                          ld      (LAST_DRIVE),a
; BCE0: C4 09 E8                          call    nz,EPROM_SETDRIVE
; BCE3: 3A DB BF                          ld      a,(CURRSEC)
; BCE6: 4F                                ld      c,a
; BCE7: CD 06 E8                          call    EPROM_SETSECTOR
; BCEA: 3A DA BF                          ld      a,(CURRTRACK)
; BCED: 4F                                ld      c,a
; BCEE: 3A EC BF                          ld      a,(LAST_TRACK)
; BCF1: B9                                cp      c
; BCF2: C4 03 E8                          call    nz,EPROM_SETTRACK
; BCF5: C9                                ret

include "../../defs.asm"

;    ORG $BCD4
;
;CHECK_CHANGED_TRKSEC:
;    jp      CHECK_CHANGED_TRKSEC_DOUBLE_SIDE

PHDRIVE       EQU $BCD8
PHTRACK       EQU $BCD9
LAST_PHDRIVE  EQU $BCDA
LAST_PHTRACK  EQU $BCDB

    ORG $BF31

CHECK_CHANGED_TRKSEC_DOUBLE_SIDE:
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

    cp    40                 ; IF CURRTRACK <= 39 THEN RET
    ret   c                  ;

    ld    a,(PHDRIVE)
    inc   a                  ;
    ld    (PHDRIVE),a        ; PHDRIVE = PHDRIVE + 1

    ld    a,(PHTRACK)        ;
    ld    c,a                ;
    ld    a,79               ;
    sub   c                  ;
    ld    (PHTRACK),a        ; PHTRACK = 79-CURDRIVE

    ret

