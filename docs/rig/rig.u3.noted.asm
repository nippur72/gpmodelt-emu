EPROM2_PRINTSTRING EQU $E009     ; print string routine in rom set 2

SA_DATA_PORT   EQU $6C
SA_CTRL_PORT   EQU $6D


; COMMAND TRANSFER
; cpu waits until -BSY (bus is free)
; cpu +D0
; cpu +ACK +B4
; cpu +SEL +ACK +B4
; controller +BSY
; cpu -SEL +ACK +B4
; controller +CD +IO
; (1) controller +REQ
; cpu sends data byte
; cpu +ACK
; controller collects data byte
; controller -REQ
; cpu -+ACK +B4
; repeat (1) for 6 bytes
; cpu +ACK -B4

; STATUS BYTE TRANSFER
; controller asserts CD + IO
; controller asserts REQ
; cpu reads the data byte
; cpu assert ACK
; controller deassert REQ
; cpu deassert ACK
;

RIG_INITD:            JP      RIG_INITD1       ; EPROM_INITD:
RIG_SETTRACK:         JP      RIG_SETTRACK1    ; ok
RIG_SETSECTOR:        JP      RIG_SETSECTOR1   ; ok
RIG_SETDRIVE:         JP      RIG_SETDRIVE1    ; most ok
RIG_SETDMA:           JP      RIG_SETDMA1      ; ok
RIG_WRITESECTOR:      JP      RIG_WRITESECTOR1 ; EPROM_WRITESECTOR:
RIG_READSECTOR:       JP      RIG_READSECTOR1  ; EPROM_READSECTOR:

BOOT_FROM_HD0:        JP      BOOT_FROM_HD0_1      ; ok
LE818:                JP      BOOT_SYSTEM          ; ?? BOOT_FROM_DISK:
LE81B:                JP      LE917                ; ?? READ_ADDRESS:
LE81E:                JP      0000h                ; ?? SET_TRACK_2_ENTRY:
SA_CONTROLLER_RESET0: JP      SA_CONTROLLER_RESET  ; reset the SA1400 controller

HDC_SEND_COMMAND:     JP      HDC_SEND_COMMAND1

RIG_SET_IX_STATUS:    JP      RIG_SET_IX_STATUS1
RIG_SET_IX_READ:      JP      RIG_SET_IX_READ1
RIG_SET_IX_WRITE:     JP      RIG_SET_IX_WRITE1


RIG_INITD1:
       CALL    RIG_SET_IX_STATUS         ; prepare for status
       LD      (IX+IX_TRKNUM),00h        ; goes to track 0
       BIT     5,(IX+IX_CURRDRIVE)       ; is it hard disk?
       RET     NZ                        ; yes return
LE83C: BIT     3,(IX+IX_CURRDRIVE)
       JR      Z,LE846
       LD      A,0FBh
       JR      LE848
LE846: LD      A,0F0h
LE848: OUT     (FDCCMD),A
       CALL    LEB6B
       RET     Z
       JR      LE83C

; assert the RES pin of the SA1400 controller, resetting it
SA_CONTROLLER_RESET:
       LD      A,0FCh
       OUT     (SA_CTRL_PORT),A   ; +RES +ACK
       LD      A,0FEh
       OUT     (SA_CTRL_PORT),A   ; -RES +ACK
       RET

                                        ; --- START PROC LE859 ---
E859: 3E FF                      LE859: LD      A,0FFh
E85B: DD 77 18                          LD      (IX+18h),A
E85E: DD 77 19                          LD      (IX+19h),A
E861: DD 77 1A                          LD      (IX+1Ah),A
E864: DD 77 1B                          LD      (IX+1Bh),A
E867: DD 36 16 FE                       LD      (IX+16h),0FEh
E86B: DD 36 17 DF                       LD      (IX+17h),0DFh
E86F: 06 06                             LD      B,06h
E871: CD 24 E8                          CALL    HDC_SEND_COMMAND
E874: CD C4 E8                          CALL    HDC_READ_STATUS_BYTE
E877: C9                                RET

;
; HD send command
;
HDC_SEND_COMMAND1:
       PUSH    IX
       POP     HL
       LD      L,0F6h             ; HL = BFF6 points to hdc command bytes buffer (IX+16h)

       LD      C,SA_DATA_PORT     ; sets ports for sending command bytes

LE87F: IN      A,(SA_CTRL_PORT)   ;
       BIT     0,A                ;
       JR      Z,LE87F            ; wait until not BSY

       LD      A,0FEh             ;
       OUT     (SA_DATA_PORT),A   ; assert D0

       LD      A,0EEh             ; assert B4(?), assert B0(ACK)
       OUT     (SA_CTRL_PORT),A   ;
       LD      A,0EAh             ;
       OUT     (SA_CTRL_PORT),A   ; assert B4(?), assert B0(ACK), assert B2(SEL)

LE891: IN      A,(SA_CTRL_PORT)   ;
       BIT     0,A                ;
       JR      NZ,LE891           ; wait until BSY is asserted

       LD      A,0EEh             ;
       OUT     (SA_CTRL_PORT),A   ; assert B4(?), assert B0(ACK), deassert B2(SEL)

LE89B: IN      A,(SA_CTRL_PORT)
       BIT     2,A
       JR      NZ,LE89B           ; wait until B2(CD or IO) is asserted

LE8A1: IN      A,(SA_CTRL_PORT)        ;
       BIT     1,A                     ;
       JR      NZ,HDC_SEND_COMMAND2    ; if B1(ERR) is asserted then ERROR

RET_WITH_ERR:
       XOR     A                 ;
       INC     A                 ; ritorna con A=1 (errore)
       RET

HDC_SEND_COMMAND2:
       BIT     3,A               ;
       JR      NZ,LE8A1          ; repeat if B3(REQ) deasserted
       OUTI                      ; send command byte
       CALL    HDC_SEND_ACK      ; send ACK
       JR      NZ,LE8A1          ; if not finished goto next byte
       LD      A,0FEh
       OUT     (SA_CTRL_PORT),A  ; deassert B4(?), assert B0(ACK)
       XOR     A
       RET

; manda ACK ma tenendo B4(?) assert
HDC_SEND_ACK:
       LD      A,0EFh            ; assert B4(?) deassert B0(ACK)
       OUT     (SA_CTRL_PORT),A
       LD      A,0EEh
       OUT     (SA_CTRL_PORT),A  ; assert B4(?) deassert B0(ACK)
       RET


; probabile read status byte
                                        ; --- START PROC HDC_READ_STATUS_BYTE ---
                                 HDC_READ_STATUS_BYTE:
E8C4: 3E FE                             LD      A,0FEh
E8C6: D3 6D                             OUT     (SA_CTRL_PORT),A ; assert B0(ACK)
E8C8: DB 6D                             IN      A,(SA_CTRL_PORT)
E8CA: E6 14                             AND     14h
E8CC: 20 F6                             JR      NZ,HDC_READ_STATUS_BYTE         ; wait until CD+IO are asserted
E8CE: DB 6D                      LE8CE: IN      A,(SA_CTRL_PORT)
E8D0: CB 4F                             BIT     1,A              ; test for B1(ERR)
E8D2: 20 02                             JR      NZ,LE8D6
E8D4: 3C                                INC     A
E8D5: C9                                RET

E8D6: CB 5F                      LE8D6: BIT     3,A
E8D8: 20 F4                             JR      NZ,LE8CE           ; wait until B3(REQ) is asserted
E8DA: DB 6C                             IN      A,(SA_DATA_PORT)   ; get status byte
E8DC: 2F                                CPL                        ; fix negated logic
E8DD: 47                                LD      B,A                ; save into B
E8DE: CD F5 E8                          CALL    HDC_01_ACK         ; assert ACK
E8E1: DB 6D                             IN      A,(SA_CTRL_PORT)   ;
E8E3: CB 4F                             BIT     1,A                ; check for B1(ERR)
E8E5: C0                                RET     NZ                 ; ERR is not asserted, return without error
                                        ; controller sends another status byte which is ignored
E8E6: DB 6D                      LE8E6: IN      A,(SA_CTRL_PORT)
E8E8: CB 5F                             BIT     3,A
E8EA: 20 FA                             JR      NZ,LE8E6           ; wait unti REQ asserted
E8EC: CD F5 E8                          CALL    HDC_01_ACK         ; send ACK
E8EF: AF                                XOR     A
E8F0: CB 48                             BIT     1,B                ; check bit 1 in old status byte in B (normal logic)
E8F2: C8                                RET     Z                  ; 0 = no error (normal logic)
E8F3: 3C                                INC     A                  ; return with error
E8F4: C9                                RET

; manda ACK ma tenendo B4(?) deassert
                                  HDC_01_ACK:
E8F5: 3E FF                             LD      A,0FFh
E8F7: D3 6D                             OUT     (SA_CTRL_PORT),A   ; deassert B0(ACK)
E8F9: 3E FE                             LD      A,0FEh
E8FB: D3 6D                             OUT     (SA_CTRL_PORT),A   ; assert B0(ACK)
E8FD: C9                                RET

;
; read bytes from HDC to memory
; returns A=0 OK
;         A=1 ERROR
;
HDC_READ_BYTES:
       LD      L,(IX+IX_DSKBUF)
       LD      H,(IX+IX_DSKBUF+1)
HDC_READ_BYTES_LOOP:
       IN      A,(SA_CTRL_PORT)
       BIT     3,A
       JR      NZ,HDC_READ_BYTES_LOOP
       BIT     2,A
       JR      Z,RET_WITH_ERR
       INI
       CALL    HDC_01_ACK
       JR      NZ,HDC_READ_BYTES_LOOP
       XOR     A
       RET

                                        ; --- START PROC LE917 ---
E917: DD 6E 0A                   LE917: LD      L,(IX+IX_DSKBUF)
E91A: DD 66 0B                          LD      H,(IX+IX_DSKBUF+1)
E91D: DB 6D                      LE91D: IN      A,(SA_CTRL_PORT) ; 'm'
E91F: CB 5F                             BIT     3,A
E921: 20 FA                             JR      NZ,LE91D
E923: CB 57                             BIT     2,A
E925: CA A7 E8                          JP      Z,RET_WITH_ERR
E928: ED A3                             OUTI
E92A: CD BB E8                          CALL    HDC_SEND_ACK
E92D: 20 EE                             JR      NZ,LE91D
E92F: AF                                XOR     A
E930: C9                                RET

                                        ; --- START PROC RIG_SETTRACK1 ---
RIG_SETTRACK1:
       CALL    RIG_SET_IX_STATUS
       LD      (IX+IX_TRKNUM),C
       BIT     5,(IX+IX_CURRDRIVE)
       RET     NZ                       ; if it's hard disk, it's all done
LE93C: LD      A,(IX+IX_TRKNUM)
       CPL
       OUT     (FDCDATA),A
       BIT     3,(IX+IX_CURRDRIVE)
       JR      Z,LE94C                  ; is it side 0 ?
       LD      A,0EBh
       JR      LE94E
LE94C: LD      A,0E0h
LE94E: OUT     (FDCCMD),A
       CALL    LEB6B
       JR      NZ,LE95C
       LD      A,(IX+IX_TRKNUM)
       CPL
       OUT     (FDCTRK),A
       RET

LE95C: LD      A,0F3h                   ; RESTORE COMMAND, F3h on 5.25
       OUT     (FDCCMD),A
       CALL    LEBD5
       JR      LE93C

RIG_SETSECTOR1:
    CALL    RIG_SET_IX_STATUS
    LD      (IX+IX_SECNUM),C
    BIT     5,(IX+IX_CURRDRIVE)
    RET     NZ                     ; if hard disk it's all done
    LD      A,C                    ;
    CPL                            ; negate sector number for 1791
    OUT     (FDCSEC),A             ; write sector number to FDC
    RET

RIG_SETDRIVE1:
    CALL    RIG_SET_IX_STATUS
    BIT     5,C
    JR      Z,ISFLOPPY
    LD      (IX+IX_CURRDRIVE),C
    RET

ISFLOPPY:
       LD      (IX+IX_CURRDRIVE),C
       CALL    LE9C6               ; calcola drive ?
       OUT     (DRIVESEL),A
       CALL    RIG_SET_IX_READ
READ_ADDRESS_START:
       PUSH    IX
       POP     HL
       LD      L,0F6h              ; HL = BFF6 (IX+16)
       LD      C,FDCDATA
       LD      A,3Bh               ; read address command (negated)
       OUT     (FDCCMD),A
       CALL    LE9AC
       JR      NZ,READ_ADDRESS_START
       CP      00h
       JP      NZ,RIG_INITD
       LD      A,(IX+16h)
       OUT     (FDCTRK),A
       CPL
       LD      (IX+IX_TRKNUM),A
       RET

                                        ; --- START PROC LE9AA ---
E9AA: ED A2                      LE9AA: INI
                                        ; --- START PROC LE9AC ---
E9AC: DB 3F                      LE9AC: IN      A,(DRIVESEL) ; '?'
E9AE: 07                                RLCA
E9AF: 38 F9                             JR      C,LE9AA
E9B1: DB 3F                             IN      A,(DRIVESEL) ; '?'
E9B3: 07                                RLCA
E9B4: 38 F4                             JR      C,LE9AA
E9B6: DB 3F                             IN      A,(DRIVESEL) ; '?'
E9B8: 07                                RLCA
E9B9: 38 EF                             JR      C,LE9AA
E9BB: DB 3F                             IN      A,(DRIVESEL) ; '?'
E9BD: 07                                RLCA
E9BE: 38 EA                             JR      C,LE9AA
E9C0: 07                                RLCA
E9C1: 30 E9                             JR      NC,LE9AC
E9C3: C3 6B EB                          JP      LEB6B

                                        ; --- START PROC LE9C6 ---
E9C6: 79                         LE9C6: LD      A,C
E9C7: E6 07                             AND     07h
E9C9: 1F                                RRA
E9CA: F6 FC                             OR      0FCh
E9CC: CB 41                             BIT     0,C
E9CE: 28 02                             JR      Z,LE9D2
E9D0: CB 9F                             RES     3,A
E9D2: CB 79                      LE9D2: BIT     7,C
E9D4: 20 02                             JR      NZ,LE9D8
E9D6: CB B7                             RES     6,A
E9D8: CB 71                      LE9D8: BIT     6,C
E9DA: 20 02                             JR      NZ,LE9DE
E9DC: CB A7                             RES     4,A
E9DE: CB BF                      LE9DE: RES     7,A
E9E0: C9                                RET


RIG_SETDMA1:
    CALL    RIG_SET_IX_STATUS
    LD      (IX+IX_DSKBUF),L
    LD      (IX+IX_DSKBUF+1),H
    RET

                                        ; --- START PROC RIG_WRITESECTOR1 ---
E9EB: CD 2D E8                   RIG_WRITESECTOR1: CALL    RIG_SET_IX_WRITE
E9EE: DD CB 09 6E                       BIT     5,(IX+IX_CURRDRIVE)
E9F2: 28 4E                             JR      Z,LEA42
E9F4: DD 36 11 05                       LD      (IX+11h),05h
E9F8: DD 36 16 F5                LE9F8: LD      (IX+16h),0F5h
E9FC: 3E FF                             LD      A,0FFh
E9FE: DD CB 09 46                       BIT     0,(IX+IX_CURRDRIVE)
EA02: 28 02                             JR      Z,LEA06
EA04: CB AF                             RES     5,A
EA06: DD CB 09 4E                LEA06: BIT     1,(IX+IX_CURRDRIVE)
EA0A: 28 02                             JR      Z,LEA0E
EA0C: CB B7                             RES     6,A
EA0E: DD 77 17                   LEA0E: LD      (IX+17h),A
EA11: DD 7E 0C                          LD      A,(IX+IX_TRKNUM)
EA14: 2F                                CPL
EA15: DD 77 18                          LD      (IX+18h),A
EA18: DD 7E 0E                          LD      A,(IX+IX_SECNUM)
EA1B: 2F                                CPL
EA1C: DD 77 19                          LD      (IX+19h),A
EA1F: DD 36 1A FE                       LD      (IX+1Ah),0FEh
EA23: DD 36 1B FF                       LD      (IX+1Bh),0FFh
EA27: 06 06                             LD      B,06h
EA29: CD 24 E8                          CALL    HDC_SEND_COMMAND
EA2C: 20 09                             JR      NZ,LEA37
EA2E: 06 00                             LD      B,00h
EA30: CD 1B E8                          CALL    LE81B
EA33: CC C4 E8                          CALL    Z,HDC_READ_STATUS_BYTE
EA36: C8                                RET     Z
EA37: CD 50 E8                   LEA37: CALL    SA_CONTROLLER_RESET
EA3A: DD 35 11                          DEC     (IX+11h)
EA3D: 20 B9                             JR      NZ,LE9F8
EA3F: AF                                XOR     A
EA40: 3C                                INC     A
EA41: C9                                RET

EA42: 0E BF                      LEA42: LD      C,0BFh
EA44: DD 6E 0A                          LD      L,(IX+IX_DSKBUF)
EA47: DD 66 0B                          LD      H,(IX+IX_DSKBUF+1)
EA4A: 3E 5F                             LD      A,5Fh   ; '_'
EA4C: D3 BC                             OUT     (FDCCMD),A
EA4E: 18 02                             JR      LEA52

EA50: ED A3                      LEA50: OUTI
EA52: DB 3F                      LEA52: IN      A,(DRIVESEL) ; '?'
EA54: 07                                RLCA
EA55: 38 F9                             JR      C,LEA50
EA57: DB 3F                             IN      A,(DRIVESEL) ; '?'
EA59: 07                                RLCA
EA5A: 38 F4                             JR      C,LEA50
EA5C: DB 3F                             IN      A,(DRIVESEL) ; '?'
EA5E: 07                                RLCA
EA5F: 38 EF                             JR      C,LEA50
EA61: DB 3F                             IN      A,(DRIVESEL) ; '?'
EA63: 07                                RLCA
EA64: 38 EA                             JR      C,LEA50
EA66: DB 3F                             IN      A,(DRIVESEL) ; '?'
EA68: 07                                RLCA
EA69: 38 E5                             JR      C,LEA50
EA6B: DB 3F                             IN      A,(DRIVESEL) ; '?'
EA6D: 07                                RLCA
EA6E: 38 E0                             JR      C,LEA50
EA70: 07                                RLCA
EA71: 30 DF                             JR      NC,LEA52
EA73: CD 6B EB                          CALL    LEB6B
EA76: 20 CA                             JR      NZ,LEA42
EA78: FE 00                             CP      00h
EA7A: C8                                RET     Z
EA7B: AF                                XOR     A
EA7C: 3C                                INC     A
EA7D: C9                                RET


;
; command: F7,DRIVE,TRK,SEC,FE,FF
; DRIVE: bit 5 off => is drive 1
; DRIVE: bit 6 off => is drive 2
;
RIG_READSECTOR1:
       CALL    RIG_SET_IX_READ           ; prepare for read
       BIT     5,(IX+IX_CURRDRIVE)       ; test bit 5
       JR      Z,READSECTOR_FLOPPY       ; is it floppy?

       LD      (IX+11h),05h              ; sets max 5 number or retry

RDSEC_SEND_COMMAND:
       LD      (IX+16h),0F7h             ; COMMAND BYTE 0 (at BFF6)

       LD      A,0FFh                    ; starts from a negated byte
       BIT     0,(IX+IX_CURRDRIVE)
       JR      Z,RDSEC1                  ; is it HD0 ?
       RES     5,A                       ;
RDSEC1:BIT     1,(IX+IX_CURRDRIVE)       ; HD2-HD3 ?
       JR      Z,RDSEC2
       RES     6,A
RDSEC2:LD      (IX+17h),A                ; COMMAND BYTE 1

       LD      A,(IX+IX_TRKNUM)          ; gets track number
       CPL                               ; negate for HDC
       LD      (IX+18h),A                ; COMMAND BYTE 2 (track num negated)

       LD      A,(IX+IX_SECNUM)          ; gets sector number
       CPL                               ; negate for HDC
       LD      (IX+19h),A                ; COMMAND BYTE 3 (sector number negated)

       LD      (IX+1Ah),0FEh             ; COMMAND BYTE 4
       LD      (IX+1Bh),0FFh             ; COMMAND BYTE 5

       LD      B,06h                     ;
       CALL    HDC_SEND_COMMAND          ; sends the 6 command bytes to the HDC

       JR      NZ,RDSEC_COMMAND_ERR      ; error sending command?
       LD      B,00h                     ;

       CALL    HDC_READ_BYTES
       CALL    Z,HDC_READ_STATUS_BYTE
       RET     Z

;
; handles error sending the command to the controller
; returns with A=1
;
RDSEC_COMMAND_ERR:
       CALL    SA_CONTROLLER_RESET
       CALL    LE859
       DEC     (IX+11h)                ; decrement attepmts
       JR      NZ,RDSEC_SEND_COMMAND     ; retry if not zero
       XOR     A
       INC     A
       RET                             ; else returns with A=1

READSECTOR_FLOPPY:
       LD      C,0BFh
       LD      L,(IX+IX_DSKBUF)
       LD      H,(IX+IX_DSKBUF+1)
       LD      A,7Fh   ; ''
       OUT     (FDCCMD),A
       CALL    LE9AC
       JR      NZ,READSECTOR_FLOPPY
       CP      00h
       RET     Z
       XOR     A
       INC     A
       RET


BOOT_SYSTEM:
       LD      A,2Fh                ; sends command $2F to FDC
       OUT     (FDCCMD),A           ;

       CALL    SA_CONTROLLER_RESET0 ; reset the HDC
       CALL    RIG_SET_IX_STATUS1   ; sets for reading status

       LD      A,0FFh              ; prepare command 00 (TEST DRIVE) per HDC
       LD      (IX+16h),A
       LD      (IX+18h),A
       LD      (IX+19h),A
       LD      (IX+1Ah),A
       LD      (IX+1Bh),A
       LD      (IX+17h),0DFh       ; sets LUN=001 in the command bytes
       LD      B,06h               ; command is 6 bytes
       CALL    HDC_SEND_COMMAND    ; send the command to the controller

       CALL    HDC_READ_STATUS_BYTE          ; read the result of test drive command
       JR      Z,BOOT_HDC_DRIVES             ; if no error then boot
       LD      HL,MESSAGE_DRIVE_NOT_READY    ;
       CALL    EPROM2_PRINTSTRING            ; else prints error message
LEB1E: JR      LEB1E                         ; halts on a forever loop

MESSAGE_DRIVE_NOT_READY:
  DB      "DRIVE NOT READ",0D9h

BOOT_HDC_DRIVES:
       LD      C,21h              ; sets first hard disk
LEB31: CALL    RIG_SETDRIVE
       LD      C,00h              ; sector 0
       CALL    RIG_SETSECTOR
       CALL    SA_CONTROLLER_RESET0
       CALL    RIG_INITD
       LD      HL,0100h           ; loads at address 0100h
       CALL    RIG_SETDMA
       LD      SP,IX              ; sets SP before system vars
       CALL    RIG_READSECTOR     ; reads sector at 0100h
       JP      NZ,0E04Dh          ; if error then display error
       JP      0100h              ; else executes boot sector

                                        ; --- START PROC BOOT_FROM_HD0_1 ---
EB50: 0E 20                      BOOT_FROM_HD0_1: LD      C,20h   ; ' '
EB52: C3 31 EB                          JP      LEB31

                                        ; --- START PROC RIG_SET_IX_STATUS1 ---
EB55: 06 98                      RIG_SET_IX_STATUS1: LD      B,98h
EB57: 18 06                             JR      LEB5F

                                        ; --- START PROC RIG_SET_IX_READ1 ---
EB59: 06 9E                      RIG_SET_IX_READ1: LD      B,9Eh
EB5B: 18 02                             JR      LEB5F

                                        ; --- START PROC RIG_SET_IX_WRITE1 ---
EB5D: 06 DE                      RIG_SET_IX_WRITE1: LD      B,0DEh
                                        ; --- START PROC LEB5F ---
EB5F: DD 21 E0 BF                LEB5F: LD      IX,0BFE0h
EB63: DD 70 10                          LD      (IX+10h),B
EB66: DD 36 11 0F                       LD      (IX+11h),0Fh
EB6A: C9                                RET

                                        ; --- START PROC LEB6B ---
EB6B: DB 3F                      LEB6B: IN      A,(DRIVESEL) ; '?'
EB6D: CB 77                             BIT     6,A
EB6F: 28 FA                             JR      Z,LEB6B
EB71: DB BC                             IN      A,(FDCCMD)
EB73: 57                                LD      D,A
EB74: DD 35 11                          DEC     (IX+11h)
EB77: 20 28                             JR      NZ,LEBA1
EB79: 3E 52                             LD      A,52h   ; 'R'
EB7B: CD 03 E0                          CALL    0E003h
EB7E: 3E 2D                             LD      A,2Dh   ; '-'
EB80: CD 03 E0                          CALL    0E003h
EB83: 01 E9 BF                          LD      BC,0BFE9h
EB86: CD 15 E0                          CALL    0E015h
EB89: 01 EC BF                          LD      BC,0BFECh
EB8C: CD 15 E0                          CALL    0E015h
EB8F: 01 EE BF                          LD      BC,0BFEEh
EB92: CD 15 E0                          CALL    0E015h
EB95: 03                                INC     BC
EB96: CD 15 E0                          CALL    0E015h
EB99: 03                                INC     BC
EB9A: CD 15 E0                          CALL    0E015h
EB9D: AF                                XOR     A
EB9E: 3E FF                             LD      A,0FFh
EBA0: C9                                RET

EBA1: 3E 0C                      LEBA1: LD      A,0Ch
EBA3: DD BE 11                          CP      (IX+11h)
EBA6: CC BA EB                          CALL    Z,LEBBA
EBA9: 3E 05                             LD      A,05h
EBAB: DD BE 11                          CP      (IX+11h)
EBAE: CC BA EB                          CALL    Z,LEBBA
EBB1: 7A                                LD      A,D
EBB2: 2F                                CPL
EBB3: DD 77 0F                          LD      (IX+0Fh),A
EBB6: DD A6 10                          AND     (IX+10h)
EBB9: C9                                RET

                                        ; --- START PROC LEBBA ---
EBBA: 3E F3                      LEBBA: LD      A,0F3h
EBBC: D3 BC                             OUT     (FDCCMD),A
EBBE: CD D5 EB                          CALL    LEBD5
EBC1: DD 7E 0C                          LD      A,(IX+IX_TRKNUM)
EBC4: 2F                                CPL
EBC5: D3 BF                             OUT     (FDCDATA),A
EBC7: 3E E3                             LD      A,0E3h
EBC9: D3 BC                             OUT     (FDCCMD),A
EBCB: CD D5 EB                          CALL    LEBD5
EBCE: DD 7E 0C                          LD      A,(IX+IX_TRKNUM)
EBD1: 2F                                CPL
EBD2: D3 BD                             OUT     (FDCTRK),A
EBD4: C9                                RET

                                        ; --- START PROC LEBD5 ---
EBD5: DB 3F                      LEBD5: IN      A,(DRIVESEL) ; '?'
EBD7: CB 77                             BIT     6,A
EBD9: 28 FA                             JR      Z,LEBD5
EBDB: DB BC                             IN      A,(FDCCMD)
EBDD: C9                                RET

                                        ; Entry Point
                                        ; --- START PROC LEBDE ---
EBDE: DE DD                      LEBDE: SBC     A,0DDh
EBE0: 21 E0 BF                          LD      HL,0BFE0h
EBE3: DD 70 10                          LD      (IX+10h),B
EBE6: DD 36 11 0F                       LD      (IX+11h),0Fh
EBEA: C9                                RET

                                        ; Entry Point
                                        ; --- START PROC LEBEB ---
EBEB: DB 3F                      LEBEB: IN      A,(DRIVESEL) ; '?'
EBED: CB 77                             BIT     6,A
EBEF: 28 FA                             JR      Z,LEBEB
EBF1: DB BC                             IN      A,(FDCCMD)
EBF3: 57                                LD      D,A
EBF4: DD 35 11                          DEC     (IX+11h)
EBF7: 20 28                             JR      NZ,0EC21h
EBF9: 3E 52                             LD      A,52h   ; 'R'
EBFB: CD 03 E0                          CALL    0E003h
EBFE: 3E 2D                             LD      A,2Dh   ; '-'

references to external address 0000h:
        E81E JP 0000h

references to external address 0100h:
        EB3F LD HL,0100h
        EB4D JP 0100h

references to external address 0E003h:
        EB7B CALL 0E003h
        EB80 CALL 0E003h
        EBFB CALL 0E003h

references to external address EPROM2_PRINTSTRING:
        EB1B CALL EPROM2_PRINTSTRING

references to external address 0E015h:
        EB86 CALL 0E015h
        EB8C CALL 0E015h
        EB92 CALL 0E015h
        EB96 CALL 0E015h
        EB9A CALL 0E015h

references to external address 0E04Dh:
        EB4A JP NZ,0E04Dh

possible references to internal address EB20:
        EB18 LD HL,0EB20h

possible references to external address 0100h:
        EB3F LD HL,0100h
        ----------
        EB4D JP 0100h

possible references to external address 0BFE0h:
        EB5F LD IX,0BFE0h
        EBE0 LD HL,0BFE0h

possible references to external address 0BFE9h:
        EB83 LD BC,0BFE9h

possible references to external address 0BFECh:
        EB89 LD BC,0BFECh

possible references to external address 0BFEEh:
        EB8F LD BC,0BFEEh

references to port 3Fh
        E9AC IN A,(DRIVESEL)
        E9B1 IN A,(DRIVESEL)
        E9B6 IN A,(DRIVESEL)
        E9BB IN A,(DRIVESEL)
        EA52 IN A,(DRIVESEL)
        EA57 IN A,(DRIVESEL)
        EA5C IN A,(DRIVESEL)
        EA61 IN A,(DRIVESEL)
        EA66 IN A,(DRIVESEL)
        EA6B IN A,(DRIVESEL)
        EB6B IN A,(DRIVESEL)
        EBD5 IN A,(DRIVESEL)
        EBEB IN A,(DRIVESEL)
        E986 OUT (DRIVESEL),A

references to port 6Ch
        E8DA IN A,(SA_DATA_PORT)
        E887 OUT (SA_DATA_PORT),A

references to port 6Dh
        E87F IN A,(SA_CTRL_PORT)
        E891 IN A,(SA_CTRL_PORT)
        E89B IN A,(SA_CTRL_PORT)
        E8A1 IN A,(SA_CTRL_PORT)
        E8C8 IN A,(SA_CTRL_PORT)
        E8CE IN A,(SA_CTRL_PORT)
        E8E1 IN A,(SA_CTRL_PORT)
        E8E6 IN A,(SA_CTRL_PORT)
        E904 IN A,(SA_CTRL_PORT)
        E91D IN A,(SA_CTRL_PORT)
        E852 OUT (SA_CTRL_PORT),A
        E856 OUT (SA_CTRL_PORT),A
        E88B OUT (SA_CTRL_PORT),A
        E88F OUT (SA_CTRL_PORT),A
        E899 OUT (SA_CTRL_PORT),A
        E8B7 OUT (SA_CTRL_PORT),A
        E8BD OUT (SA_CTRL_PORT),A
        E8C1 OUT (SA_CTRL_PORT),A
        E8C6 OUT (SA_CTRL_PORT),A
        E8F7 OUT (SA_CTRL_PORT),A
        E8FB OUT (SA_CTRL_PORT),A

references to port 0BCh
        EB71 IN A,(FDCCMD)
        EBDB IN A,(FDCCMD)
        EBF1 IN A,(FDCCMD)
        E848 OUT (FDCCMD),A
        E94E OUT (FDCCMD),A
        E95E OUT (FDCCMD),A
        E994 OUT (FDCCMD),A
        EA4C OUT (FDCCMD),A
        EAE2 OUT (FDCCMD),A
        EAF1 OUT (FDCCMD),A
        EBBC OUT (FDCCMD),A
        EBC9 OUT (FDCCMD),A

references to port 0BDh
        E959 OUT (FDCTRK),A
        E9A3 OUT (FDCTRK),A
        EBD2 OUT (FDCTRK),A

references to port 0BEh
        E972 OUT (FDCSEC),A

references to port 0BFh
        E940 OUT (FDCDATA),A
        EBC5 OUT (FDCDATA),A

Procedures (50):
  Proc  Length  References Dependants
  RIG_INITD  0003            2          1
  RIG_SETTRACK  0003            0          1
  RIG_SETSECTOR  0003            1          1
  RIG_SETDRIVE  0003            1          1
  RIG_SETDMA  0003            1          1
  RIG_WRITESECTOR  0003            0          1
  RIG_READSECTOR  0003            1          1
  BOOT_FROM_HD0  0003            0          1
  LE818  0003            0          1
  LE81B  0003            1          1
  LE81E  0003            0          1
  SA_CONTROLLER_RESET0  0003            2          1
  HDC_SEND_COMMAND  0003            4          1
  RIG_SET_IX_STATUS  0003            5          1
  RIG_SET_IX_READ  0003            2          1
  RIG_SET_IX_WRITE  0003            1          1
  RIG_INITD1  0020            1          2
  SA_CONTROLLER_RESET  0009            3          0
  LE859  001F            1          2
  HDC_SEND_COMMAND1  0030            1          2
  LE8A1  0007            2          2
  RET_WITH_ERR  0003            2          0
  HDC_SEND_COMMAND2  0011            1          2
  HDC_SEND_ACK  0009            2          0
  HDC_READ_STATUS_BYTE  0031            5          1
  HDC_01_ACK  0009            3          0
  HDC_READ_BYTES  0019            1          2
  LE917  001A            1          2
  RIG_SETTRACK1  0034            1          3
  RIG_SETSECTOR1  0010            1          1
  RIG_SETDRIVE1  0035            1          5
  LE9AA  0004            4          1
  LE9AC  001A            3          2
  LE9C6  001B            1          0
  RIG_SETDMA1  000A            1          1
  RIG_WRITESECTOR1  0093            1          6
  RIG_READSECTOR1  0071            1          7
  BOOT_SYSTEM  0045            1          7
  BOOT_HDC_DRIVES  0005            1          1
  LEB31  001F            1          8
  BOOT_FROM_HD0_1  0005            1          1
  RIG_SET_IX_STATUS1  0004            2          1
  RIG_SET_IX_READ1  0004            1          1
  RIG_SET_IX_WRITE1  0006            1          1
  LEB5F  000C            2          0
  LEB6B  004F            5          3
  LEBBA  001B            2          1
  LEBD5  0009            4          0
  LEBDE  000D            0          0
  LEBEB  0015            1          2

Call Graph:
RIG_INITD - Entry Point
  RIG_INITD1
    RIG_SET_IX_STATUS
      RIG_SET_IX_STATUS1
        LEB5F
    LEB6B
      0E003h - External
      0E015h - External
      LEBBA
        LEBD5
RIG_SETTRACK - Entry Point
  RIG_SETTRACK1
    RIG_SET_IX_STATUS
      RIG_SET_IX_STATUS1
        LEB5F
    LEB6B
      0E003h - External
      0E015h - External
      LEBBA
        LEBD5
    LEBD5
RIG_SETSECTOR - Entry Point
  RIG_SETSECTOR1
    RIG_SET_IX_STATUS
      RIG_SET_IX_STATUS1
        LEB5F
RIG_SETDRIVE - Entry Point
  RIG_SETDRIVE1
    RIG_SET_IX_STATUS
      RIG_SET_IX_STATUS1
        LEB5F
    LE9C6
    RIG_SET_IX_READ
      RIG_SET_IX_READ1
        LEB5F
    LE9AC
      LE9AA
        LE9AC - Recursive
      LEB6B
        0E003h - External
        0E015h - External
        LEBBA
          LEBD5
    RIG_INITD
      RIG_INITD1
        RIG_SET_IX_STATUS
          RIG_SET_IX_STATUS1
            LEB5F
        LEB6B
          0E003h - External
          0E015h - External
          LEBBA
            LEBD5
RIG_SETDMA - Entry Point
  RIG_SETDMA1
    RIG_SET_IX_STATUS
      RIG_SET_IX_STATUS1
        LEB5F
RIG_WRITESECTOR - Entry Point
  RIG_WRITESECTOR1
    RIG_SET_IX_WRITE
      RIG_SET_IX_WRITE1
        LEB5F
    HDC_SEND_COMMAND
      HDC_SEND_COMMAND1
        HDC_SEND_COMMAND2
          LE8A1
            HDC_SEND_COMMAND2 - Recursive
            RET_WITH_ERR
          HDC_SEND_ACK
        RET_WITH_ERR
    LE81B
      LE917
        RET_WITH_ERR
        HDC_SEND_ACK
    HDC_READ_STATUS_BYTE
      HDC_01_ACK
    SA_CONTROLLER_RESET
    LEB6B
      0E003h - External
      0E015h - External
      LEBBA
        LEBD5
RIG_READSECTOR - Entry Point
  RIG_READSECTOR1
    RIG_SET_IX_READ
      RIG_SET_IX_READ1
        LEB5F
    HDC_SEND_COMMAND
      HDC_SEND_COMMAND1
        HDC_SEND_COMMAND2
          LE8A1
            HDC_SEND_COMMAND2 - Recursive
            RET_WITH_ERR
          HDC_SEND_ACK
        RET_WITH_ERR
    HDC_READ_BYTES
      RET_WITH_ERR
      HDC_01_ACK
    HDC_READ_STATUS_BYTE
      HDC_01_ACK
    SA_CONTROLLER_RESET
    LE859
      HDC_SEND_COMMAND
        HDC_SEND_COMMAND1
          HDC_SEND_COMMAND2
            LE8A1
              HDC_SEND_COMMAND2 - Recursive
              RET_WITH_ERR
            HDC_SEND_ACK
          RET_WITH_ERR
      HDC_READ_STATUS_BYTE
        HDC_01_ACK
    LE9AC
      LE9AA
        LE9AC - Recursive
      LEB6B
        0E003h - External
        0E015h - External
        LEBBA
          LEBD5
BOOT_FROM_HD0 - Entry Point
  BOOT_FROM_HD0_1
    LEB31
      RIG_SETDRIVE
        RIG_SETDRIVE1
          RIG_SET_IX_STATUS
            RIG_SET_IX_STATUS1
              LEB5F
          LE9C6
          RIG_SET_IX_READ
            RIG_SET_IX_READ1
              LEB5F
          LE9AC
            LE9AA
              LE9AC - Recursive
            LEB6B
              0E003h - External
              0E015h - External
              LEBBA
                LEBD5
          RIG_INITD
            RIG_INITD1
              RIG_SET_IX_STATUS
                RIG_SET_IX_STATUS1
                  LEB5F
              LEB6B
                0E003h - External
                0E015h - External
                LEBBA
                  LEBD5
      RIG_SETSECTOR
        RIG_SETSECTOR1
          RIG_SET_IX_STATUS
            RIG_SET_IX_STATUS1
              LEB5F
      SA_CONTROLLER_RESET0
        SA_CONTROLLER_RESET
      RIG_INITD
        RIG_INITD1
          RIG_SET_IX_STATUS
            RIG_SET_IX_STATUS1
              LEB5F
          LEB6B
            0E003h - External
            0E015h - External
            LEBBA
              LEBD5
      RIG_SETDMA
        RIG_SETDMA1
          RIG_SET_IX_STATUS
            RIG_SET_IX_STATUS1
              LEB5F
      RIG_READSECTOR
        RIG_READSECTOR1
          RIG_SET_IX_READ
            RIG_SET_IX_READ1
              LEB5F
          HDC_SEND_COMMAND
            HDC_SEND_COMMAND1
              HDC_SEND_COMMAND2
                LE8A1
                  HDC_SEND_COMMAND2 - Recursive
                  RET_WITH_ERR
                HDC_SEND_ACK
              RET_WITH_ERR
          HDC_READ_BYTES
            RET_WITH_ERR
            HDC_01_ACK
          HDC_READ_STATUS_BYTE
            HDC_01_ACK
          SA_CONTROLLER_RESET
          LE859
            HDC_SEND_COMMAND
              HDC_SEND_COMMAND1
                HDC_SEND_COMMAND2
                  LE8A1
                    HDC_SEND_COMMAND2 - Recursive
                    RET_WITH_ERR
                  HDC_SEND_ACK
                RET_WITH_ERR
            HDC_READ_STATUS_BYTE
              HDC_01_ACK
          LE9AC
            LE9AA
              LE9AC - Recursive
            LEB6B
              0E003h - External
              0E015h - External
              LEBBA
                LEBD5
      0E04Dh - External
      0100h - External
LE818 - Entry Point
  BOOT_SYSTEM
    SA_CONTROLLER_RESET0
      SA_CONTROLLER_RESET
    RIG_SET_IX_STATUS1
      LEB5F
    HDC_SEND_COMMAND
      HDC_SEND_COMMAND1
        HDC_SEND_COMMAND2
          LE8A1
            HDC_SEND_COMMAND2 - Recursive
            RET_WITH_ERR
          HDC_SEND_ACK
        RET_WITH_ERR
    HDC_READ_STATUS_BYTE
      HDC_01_ACK
    BOOT_HDC_DRIVES
      LEB31
        RIG_SETDRIVE
          RIG_SETDRIVE1
            RIG_SET_IX_STATUS
              RIG_SET_IX_STATUS1
                LEB5F
            LE9C6
            RIG_SET_IX_READ
              RIG_SET_IX_READ1
                LEB5F
            LE9AC
              LE9AA
                LE9AC - Recursive
              LEB6B
                0E003h - External
                0E015h - External
                LEBBA
                  LEBD5
            RIG_INITD
              RIG_INITD1
                RIG_SET_IX_STATUS
                  RIG_SET_IX_STATUS1
                    LEB5F
                LEB6B
                  0E003h - External
                  0E015h - External
                  LEBBA
                    LEBD5
        RIG_SETSECTOR
          RIG_SETSECTOR1
            RIG_SET_IX_STATUS
              RIG_SET_IX_STATUS1
                LEB5F
        SA_CONTROLLER_RESET0
          SA_CONTROLLER_RESET
        RIG_INITD
          RIG_INITD1
            RIG_SET_IX_STATUS
              RIG_SET_IX_STATUS1
                LEB5F
            LEB6B
              0E003h - External
              0E015h - External
              LEBBA
                LEBD5
        RIG_SETDMA
          RIG_SETDMA1
            RIG_SET_IX_STATUS
              RIG_SET_IX_STATUS1
                LEB5F
        RIG_READSECTOR
          RIG_READSECTOR1
            RIG_SET_IX_READ
              RIG_SET_IX_READ1
                LEB5F
            HDC_SEND_COMMAND
              HDC_SEND_COMMAND1
                HDC_SEND_COMMAND2
                  LE8A1
                    HDC_SEND_COMMAND2 - Recursive
                    RET_WITH_ERR
                  HDC_SEND_ACK
                RET_WITH_ERR
            HDC_READ_BYTES
              RET_WITH_ERR
              HDC_01_ACK
            HDC_READ_STATUS_BYTE
              HDC_01_ACK
            SA_CONTROLLER_RESET
            LE859
              HDC_SEND_COMMAND
                HDC_SEND_COMMAND1
                  HDC_SEND_COMMAND2
                    LE8A1
                      HDC_SEND_COMMAND2 - Recursive
                      RET_WITH_ERR
                    HDC_SEND_ACK
                  RET_WITH_ERR
              HDC_READ_STATUS_BYTE
                HDC_01_ACK
            LE9AC
              LE9AA
                LE9AC - Recursive
              LEB6B
                0E003h - External
                0E015h - External
                LEBBA
                  LEBD5
        0E04Dh - External
        0100h - External
    EPROM2_PRINTSTRING - External
    LEB31
      RIG_SETDRIVE
        RIG_SETDRIVE1
          RIG_SET_IX_STATUS
            RIG_SET_IX_STATUS1
              LEB5F
          LE9C6
          RIG_SET_IX_READ
            RIG_SET_IX_READ1
              LEB5F
          LE9AC
            LE9AA
              LE9AC - Recursive
            LEB6B
              0E003h - External
              0E015h - External
              LEBBA
                LEBD5
          RIG_INITD
            RIG_INITD1
              RIG_SET_IX_STATUS
                RIG_SET_IX_STATUS1
                  LEB5F
              LEB6B
                0E003h - External
                0E015h - External
                LEBBA
                  LEBD5
      RIG_SETSECTOR
        RIG_SETSECTOR1
          RIG_SET_IX_STATUS
            RIG_SET_IX_STATUS1
              LEB5F
      SA_CONTROLLER_RESET0
        SA_CONTROLLER_RESET
      RIG_INITD
        RIG_INITD1
          RIG_SET_IX_STATUS
            RIG_SET_IX_STATUS1
              LEB5F
          LEB6B
            0E003h - External
            0E015h - External
            LEBBA
              LEBD5
      RIG_SETDMA
        RIG_SETDMA1
          RIG_SET_IX_STATUS
            RIG_SET_IX_STATUS1
              LEB5F
      RIG_READSECTOR
        RIG_READSECTOR1
          RIG_SET_IX_READ
            RIG_SET_IX_READ1
              LEB5F
          HDC_SEND_COMMAND
            HDC_SEND_COMMAND1
              HDC_SEND_COMMAND2
                LE8A1
                  HDC_SEND_COMMAND2 - Recursive
                  RET_WITH_ERR
                HDC_SEND_ACK
              RET_WITH_ERR
          HDC_READ_BYTES
            RET_WITH_ERR
            HDC_01_ACK
          HDC_READ_STATUS_BYTE
            HDC_01_ACK
          SA_CONTROLLER_RESET
          LE859
            HDC_SEND_COMMAND
              HDC_SEND_COMMAND1
                HDC_SEND_COMMAND2
                  LE8A1
                    HDC_SEND_COMMAND2 - Recursive
                    RET_WITH_ERR
                  HDC_SEND_ACK
                RET_WITH_ERR
            HDC_READ_STATUS_BYTE
              HDC_01_ACK
          LE9AC
            LE9AA
              LE9AC - Recursive
            LEB6B
              0E003h - External
              0E015h - External
              LEBBA
                LEBD5
      0E04Dh - External
      0100h - External
LE81B - Entry Point
  LE917
    RET_WITH_ERR
    HDC_SEND_ACK
LE81E - Entry Point
  0000h - External
LEBDE - Entry Point
LEBEB - Entry Point
  0EC21h - External
  0E003h - External
