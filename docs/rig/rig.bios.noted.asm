BA00: C3 00 E4                   LBA00: JP      0E400h ; BOOT            ;ARRIVE HERE FROM COLD START LOAD
BA03: C3 0A E4                   LBA03: JP      0E40Ah ; WBOOT           ;ARRIVE HERE FOR WARM START
BA06: C3 33 BB                   LBA06: JP      LBB33  ; CONST           ;CHECK FOR CONSOLE CHAR READY
BA09: C3 02 BB                   LBA09: JP      LBB02  ; CONIN           ;READ CONSOLE CHARACTER IN
BA0C: C3 9F E5                   LBA0C: JP      0E59Fh ; CONOUT          ;WRITE CONSOLE CHARACTER OUT
BA0F: C3 C8 E5                   LBA0F: JP      0E5C8h ; LIST            ;WRITE LISTING CHARACTER OUT
BA12: C3 12 E6                   LBA12: JP      0E612h ; PUNCH           ;WRITE CHARACTER TO PUNCH DEVICE
BA15: C3 14 E6                   LBA15: JP      0E614h ; READER          ;READ READER DEVICE
BA18: C3 41 E6                   LBA18: JP      0E641h ; HOME            ;MOVE TO TRACK 00 ON SELECTED DISK
BA1B: C3 58 E6                   LBA1B: JP      0E658h ; SELDSK          ;SELECT DISK DRIVE
BA1E: C3 77 E6                   LBA1E: JP      0E677h ; SETTRK          ;SET TRACK NUMBER
BA21: C3 7D E6                   LBA21: JP      0E67Dh ; SETSEC          ;SET SECTOR NUMBER
BA24: C3 91 E6                   LBA24: JP      0E691h ; SETDMA          ;SET DMA ADDRESS
BA27: C3 97 E6                   LBA27: JP      0E697h ; READ            ;READ SELECTED SECTOR
BA2A: C3 AE E6                   LBA2A: JP      0E6AEh ; WRITE           ;WRITE SELECTED SECTOR
BA2D: C3 E7 E5                   LBA2D: JP      0E5E7h ; LISTST          ;RETURN LIST STATUS
BA30: C3 83 E6                   LBA30: JP      0E683h ; SECTRAN         ;SECTOR TRANSLATE SUBROUTINE
BA33: C3 00 00                   LBA33: JP      0000h
BA36: C3 00 00                   LBA36: JP      0000h
BA39: C3 00 00                   LBA39: JP      0000h
BA3C: C3 00 00                   LBA3C: JP      0000h
BA3F: C3 00 00                   LBA3F: JP      0000h
BA42: C3 00 00                   LBA42: JP      0000h
BA45: C3 00 00                   LBA45: JP      0000h
BA48: C3 00 00                   LBA48: JP      0000h
BA4B: C3 00 00                   LBA4B: JP      0000h
BA4E: C3 00 00                   LBA4E: JP      0000h
BA51: C3 00 00                   LBA51: JP      0000h

BA54: 05                         LBA54: DB      05h
BA55: 05                                DB      05h
BA56: 18                                DB      18h

INIT_SERIAL_DATA:

BA57: 01                                DB      01h
BA58: 00                                DB      00h
BA59: 02                                DB      02h
BA5A: 00                                DB      00h
BA5B: 03                                DB      03h
BA5C: E1                                DB      0E1h
BA5D: 04                                DB      04h
BA5E: 44                                DB      44h     ; 'D'
BA5F: 05                                DB      05h
BA60: EA                                DB      0EAh

;BA61:
DISK_UNIT_TABLE:
   DW $0021                                
   DW $0020                                
   DW $0021                                
   DW $00D4                                
   DW $00D5                                


DPH_TABLE:

; LOGICAL UNIT A:

;BA6B:

DW $0000        ; SKEWTABLE (no skewtable)
DW $00,$00,$00  ; scratch pad bytes
DW $BCB6        ; DIRBUF
DW $BAE4        ; DPB disk parameter block
DW $BF92        ; CSVAREA 
DW $BD36        ; ALVAREA

; LOGICAL UNIT B:

;BA7B

DW $0000        ; SKEWTABLE (no skewtable)
DW $00,$00,$00  ; scratch pad bytes
DW $BCB6        ; DIRBUF
DW $BAF3        ; DPB disk parameter block
DW $BF92        ; CSVAREA 
DW $BF32        ; ALVAREA

; LOGICAL UNIT C:

;BA8B:
DS 16           ; unit C: is empty

; LOGICAL UNIT D: (floppy 8")

;BA9B:

DW $BABB        ; SKEWTABLE
DW $00,$00,$00  ; scratch pad bytes
DW $BCB6        ; DIRBUF
DW $BAD5        ; DPB disk parameter block
DW $BFA2        ; CSVAREA 
DW $BF52        ; ALVAREA

; LOGICAL UNIT E: (floppy 8" 1791)

;BABB:

DW $BABB        ; SKEWTABLE
DW $00,$00,$00  ; scratch pad bytes
DW $BCB6        ; DIRBUF
DW $BAD5        ; DPB disk parameter block
DW $BFB2        ; CSVAREA 
DW $BF72        ; ALVAREA

;skew table for floppy discs D and E
SKEWTABLE:

;BABB:

DB $01,$07,$0D,$13,$19,$05,$0B,$11,$17,$03,$09,$0F,$15,$02,$08,$0E,$14,$1A,$06,$0C,$12,$18,$04,$0A,$10,$16

; disk parameter block for units D: and E:
DPB_DE:
;BAD5:

DW $001A             ;NSECTORS - SECTORS PER TRACK
DB $03               ;BSH - BLOCK SHIFT FACTOR (1024 bytes)
DB $07               ;BLM - BLOCK MASK
DB $00               ;EXM - EXTENT MASK
DW $00F2             ;NBLOCKS - NUMBER OF BLOCKS
DB $3F,$00           ;DIRENTRY SIZE
DB $C0,$00           ;AL0, AL1
DW $0010             ;CHECKSUM AREA SIZE IN BYTES
DW $0002             ;RESERVED_TRACKS - NUMBER OF RESERVED TRACKS AT THE START OF THE DISK

; disk parameter block for unit A:
DPB_A:
;BAE4:

DW $0200             ;NSECTORS - SECTORS PER TRACK
DB $04               ;BSH - BLOCK SHIFT FACTOR (2048 bytes)
DB $0F               ;BLM - BLOCK MASK
DB $00               ;EXM - EXTENT MASK
DW $0FDF             ;NBLOCKS - NUMBER OF BLOCKS
DW $023F             ;DIRENTRY SIZE
DB $FF,$80           ;AL0, AL1
DW $0000             ;CHECKSUM AREA SIZE IN BYTES
DW $0001             ;RESERVED_TRACKS - NUMBER OF RESERVED TRACKS AT THE START OF THE DISK

;disk parameter block for unit B:
DPB_B:

;BAF3:

DW $0200             ;NSECTORS - SECTORS PER TRACK
DB $07               ;BSH - BLOCK SHIFT FACTOR (16384 bytes)
DB $7F               ;BLM - BLOCK MASK
DB $0F               ;EXM - EXTENT MASK
DW $0047             ;NBLOCKS - NUMBER OF BLOCKS
DW $003F             ;DIRENTRY SIZE
DB $80,$00           ;AL0, AL1
DW $0010             ;CHECKSUM AREA SIZE IN BYTES
DW $0001             ;RESERVED_TRACKS - NUMBER OF RESERVED TRACKS AT THE START OF THE DISK


                                        ; --- START PROC LBB02 ---
BB02: 2A 26 BB                   LBB02: LD      HL,(LBB26)
BB05: 7E                                LD      A,(HL)
BB06: B7                                OR      A
BB07: FA 0F BB                          JP      M,LBB0F
BB0A: 23                                INC     HL
BB0B: 22 26 BB                          LD      (LBB26),HL
BB0E: C9                                RET

BB0F: 21 5E BB                   LBB0F: LD      HL,0BB5Eh
                                        ; --- START PROC LBB11 ---
BB11: BB                         LBB11: CP      E
BB12: 22 0A BA                          LD      (LBA09+1),HL    ; reference not aligned to instruction
BB15: E6 7F                             AND     7Fh     ; ''
BB17: C9                                RET

BB18: 49 4E 49 5A 49 4F 20 4C    LBB18: DB      "INIZIO LAVORO"
BB20: 41 56 4F 52 4F
BB25: 8D                                DB      8Dh
BB26: 18                         LBB26: DB      18h
BB27: BB                                DB      0BBh

                                        ; Entry Point
                                        ; --- START PROC LBB28 ---
BB28: 3E 0D                      LBB28: LD      A,0Dh
BB2A: CD 03 E0                          CALL    0E003h
BB2D: 3E 0A                             LD      A,0Ah
BB2F: CD 03 E0                          CALL    0E003h
BB32: C9                                RET

                                        ; --- START PROC LBB33 ---
BB33: 3A 03 00                   LBB33: LD      A,(0003h)
BB36: E6 03                             AND     03h
BB38: FE 01                             CP      01h
BB3A: CA 45 BB                          JP      Z,LBB45
BB3D: DB FF                             IN      A,(0FFh)
BB3F: 07                                RLCA
                                        ; --- START PROC LBB40 ---
BB40: 3E FF                      LBB40: LD      A,0FFh
BB42: D0                                RET     NC
BB43: AF                                XOR     A
BB44: C9                                RET

BB45: AF                         LBB45: XOR     A
BB46: D3 7A                             OUT     (7Ah),A ; 'z'
BB48: DB 7A                             IN      A,(7Ah) ; 'z'
BB4A: E6 01                             AND     01h
                                        ; --- START PROC LBB4C ---
BB4C: 37                         LBB4C: SCF
BB4D: CA 40 BB                          JP      Z,LBB40
BB50: 3F                                CCF
BB51: C3 40 BB                          JP      LBB40

                                        ; Entry Point
                                        ; --- START PROC LBB54 ---
BB54: AF                         LBB54: XOR     A
BB55: D3 7A                             OUT     (7Ah),A ; 'z'
BB57: DB 7A                             IN      A,(7Ah) ; 'z'
BB59: E6 04                             AND     04h
BB5B: C3 4C BB                          JP      LBB4C

                                        ; Entry Point
                                        ; --- START PROC LBB5E ---
BB5E: CD 17 E6                   LBB5E: CALL    0E617h
BB61: 3A 03 00                          LD      A,(0003h)
BB64: E6 03                             AND     03h
BB66: FE 01                             CP      01h
BB68: C2 7B BB                          JP      NZ,LBB7B
                                        ; --- START PROC LBB6B ---
BB6B: AF                         LBB6B: XOR     A
                                        ; --- START PROC LBB6C ---
BB6C: D3 7A                      LBB6C: OUT     (7Ah),A ; 'z'
BB6E: DB 7A                             IN      A,(7Ah) ; 'z'
BB70: E6 01                             AND     01h
BB72: CA 6B BB                          JP      Z,LBB6B
BB75: DB 78                             IN      A,(78h) ; 'x'
BB77: CD 2F E6                          CALL    0E62Fh
BB7A: C9                                RET

BB7B: CD 06 E0                   LBB7B: CALL    0E006h
BB7E: CD 2F E6                          CALL    0E62Fh
BB81: C9                                RET

                                        ; Entry Point
                                        ; --- START PROC LBB82 ---
BB82: 19                         LBB82: ADD     HL,DE
BB83: D1                                POP     DE
BB84: C1                                POP     BC
BB85: 05                                DEC     B
BB86: CA 9F BB                          JP      Z,LBB9F
BB89: 14                                INC     D
BB8A: 7A                                LD      A,D
BB8B: FE 10                             CP      10h
BB8D: C3 6C BB                          JP      LBB6C

                                        ; Entry Point
                                        ; --- START PROC LBB90 ---
BB90: 16 00                      LBB90: LD      D,00h
BB92: 0C                                INC     C
BB93: C5                                PUSH    BC
BB94: D5                                PUSH    DE
BB95: E5                                PUSH    HL
BB96: CD 03 E8                          CALL    0E803h
BB99: E1                                POP     HL
BB9A: D1                                POP     DE
BB9B: C1                                POP     BC
BB9C: C3 6C BB                          JP      LBB6C

                                        ; --- START PROC LBB9F ---
BB9F: AF                         LBB9F: XOR     A
BBA0: 32 45 BD                          LD      (LBD45),A
BBA3: 32 4A BD                          LD      (LBD4A),A
BBA6: 21 CE BB                          LD      HL,0BBCEh
BBA9: CD 09 E0                          CALL    0E009h
BBAC: 3E C3                             LD      A,0C3h
BBAE: 32 00 00                          LD      (0000h),A
BBB1: 21 03 BA                          LD      HL,0BA03h
BBB4: 22 01 00                          LD      (0001h),HL
BBB7: 32 05 00                          LD      (0005h),A
BBBA: 21 06 AC                          LD      HL,0AC06h
BBBD: 22 06 00                   LBBBD: LD      (0006h),HL
BBC0: 01 80 00                   LBBC0: LD      BC,0080h
BBC3: CD 49 E5                          CALL    0E549h
BBC6: FB                                EI
BBC7: 3A 04 00                          LD      A,(0004h)
BBCA: 4F                                LD      C,A
BBCB: C3 00 A4                   LBBCB: JP      0A400h

BBCE: 0D                         LBBCE: DB      0Dh
BBCF: 0A                                DB      0Ah
BBD0: 44                                DB      44h     ; 'D'
BBD1: 4F                         LBBD1: DB      4Fh     ; 'O'
BBD2: 53 20 32 2E 32 20 34              DB      "S 2.2 4"
BBD9: 38                         LBBD9: DB      38h     ; '8'
BBDA: 6B                         LBBDA: DB      6Bh     ; 'k'
BBDB: 0D                         LBBDB: DB      0Dh
BBDC: 0A                         LBBDC: DB      0Ah
BBDD: 72                         LBBDD: DB      72h     ; 'r'
BBDE: 65 76 2E 20 61 70 72 2F           DB      "ev. apr/82"
BBE6: 38 32
BBE8: 0D                                DB      0Dh
BBE9: 0A                                DB      0Ah
BBEA: A0                                DB      0A0h

                                        ; Entry Point
                                        ; --- START PROC LBBEB ---
BBEB: EB                         LBBEB: EX      DE,HL
BBEC: 21 37 BD                          LD      HL,0BD37h
BBEF: 1A                                LD      A,(DE)
BBF0: BE                                CP      (HL)
BBF1: C0                                RET     NZ
BBF2: 13                                INC     DE
BBF3: 23                                INC     HL
BBF4: 1A                                LD      A,(DE)
BBF5: BE                                CP      (HL)
BBF6: C9                                RET

                                        ; Entry Point
                                        ; --- START PROC LBBF7 ---
BBF7: CD D2 E4                   LBBF7: CALL    0E4D2h
BBFA: CD 6C BC                          CALL    LBC6C
BBFD: CD CF BC                          CALL    LBCCF
BC00: 3A 54 BA                          LD      A,(LBA54)
BC03: F5                                PUSH    AF
BC04: CD 0F E8                   LBC04: CALL    0E80Fh
BC07: C2 27 BC                          JP      NZ,LBC27
BC0A: 2A EA BF                          LD      HL,(0BFEAh)
BC0D: E5                                PUSH    HL
BC0E: 21 00 FE                          LD      HL,0FE00h
BC11: 22 EA BF                          LD      (0BFEAh),HL
BC14: CD 12 E8                          CALL    0E812h
BC17: E1                                POP     HL
BC18: 22 EA BF                          LD      (0BFEAh),HL
BC1B: CA 30 BC                          JP      Z,LBC30
BC1E: F1                                POP     AF
BC1F: 3D                                DEC     A
BC20: CA 28 BC                          JP      Z,LBC28
BC23: F5                                PUSH    AF
BC24: C3 04 BC                          JP      LBC04

BC27: F1                         LBC27: POP     AF
BC28: 3E FF                      LBC28: LD      A,0FFh
BC2A: 32 52 BD                          LD      (LBD52),A
BC2D: C3 36 BC                          JP      LBC36

BC30: F1                         LBC30: POP     AF
BC31: 3E 00                             LD      A,00h
BC33: 32 52 BD                          LD      (LBD52),A
BC36: CD CF BC                   LBC36: CALL    LBCCF
BC39: C3 4B BC                          JP      LBC4B

                                        ; Entry Point
                                        ; --- START PROC LBC3C ---
BC3C: CD D2 E4                   LBC3C: CALL    0E4D2h
BC3F: CD 6C BC                          CALL    LBC6C
BC42: CD 12 E8                          CALL    0E812h
BC45: 32 52 BD                          LD      (LBD52),A
BC48: CD CF BC                          CALL    LBCCF
                                        ; --- START PROC LBC4B ---
BC4B: CD EA E4                   LBC4B: CALL    0E4EAh
BC4E: C9                                RET

                                        ; Entry Point
                                        ; --- START PROC LBC4F ---
BC4F: 3A 36 BD                   LBC4F: LD      A,(LBD36)
BC52: FD 21 31 BD                       LD      IY,0BD31h
BC56: 21 5B BD                          LD      HL,0BD5Bh
BC59: 22 EA BF                          LD      (0BFEAh),HL
                                        ; --- START PROC LBC5C ---
BC5C: 21 60 BA                   LBC5C: LD      HL,0BA60h
BC5F: 5F                                LD      E,A
BC60: 16 00                             LD      D,00h
BC62: 19                                ADD     HL,DE
BC63: 19                                ADD     HL,DE
BC64: 5E                                LD      E,(HL)
BC65: 23                                INC     HL
BC66: 56                                LD      D,(HL)
BC67: ED 53 31 BD                       LD      (LBD31),DE
BC6B: C9                                RET

                                        ; --- START PROC LBC6C ---
BC6C: 3A 3E BD                   LBC6C: LD      A,(LBD3E)
BC6F: 4F                                LD      C,A
BC70: 3A 3D BD                          LD      A,(LBD3D)
BC73: CD 5C BC                          CALL    LBC5C
BC76: 7A                                LD      A,D
BC77: B7                                OR      A
BC78: CA 86 BC                          JP      Z,LBC86
BC7B: 81                                ADD     A,C
BC7C: FA 86 BC                          JP      M,LBC86
BC7F: FD 86 01                          ADD     A,(IY+01h)
BC82: 2F                                CPL
BC83: 4F                                LD      C,A
BC84: CB C3                             SET     0,E
BC86: 51                         LBC86: LD      D,C
BC87: D5                                PUSH    DE
BC88: 7B                                LD      A,E
BC89: 4F                                LD      C,A
BC8A: DD BE 09                          CP      (IX+09h)
BC8D: 32 E9 BF                          LD      (0BFE9h),A
BC90: C4 09 E8                          CALL    NZ,0E809h
BC93: C1                                POP     BC
BC94: 3E C0                             LD      A,0C0h
BC96: A1                                AND     C
BC97: FE 80                             CP      80h
BC99: 3A 40 BD                          LD      A,(LBD3F+1)     ; reference not aligned to instruction
BC9C: 4F                                LD      C,A
BC9D: C2 BE BC                          JP      NZ,LBCBE
BCA0: C5                                PUSH    BC
BCA1: 78                                LD      A,B
BCA2: 58                                LD      E,B
BCA3: 16 00                             LD      D,00h
BCA5: 21 00 00                          LD      HL,0000h
BCA8: 06 1A                             LD      B,1Ah
BCAA: B7                                OR      A
BCAB: CA B1 BC                          JP      Z,LBCB1
BCAE: 19                         LBCAE: ADD     HL,DE
BCAF: 10 FD                             DJNZ    LBCAE
BCB1: C1                         LBCB1: POP     BC
BCB2: 59                                LD      E,C
BCB3: 19                                ADD     HL,DE
BCB4: 2B                                DEC     HL
BCB5: 7D                                LD      A,L
BCB6: E6 0F                             AND     0Fh
BCB8: 4F                                LD      C,A
BCB9: 29                                ADD     HL,HL
BCBA: 29                                ADD     HL,HL
BCBB: 29                                ADD     HL,HL
BCBC: 29                                ADD     HL,HL
BCBD: 44                                LD      B,H
BCBE: C5                         LBCBE: PUSH    BC
BCBF: CD 06 E8                          CALL    0E806h
BCC2: C1                                POP     BC
BCC3: 78                                LD      A,B
BCC4: 4F                                LD      C,A
BCC5: DD BE 0C                          CP      (IX+0Ch)
BCC8: 32 EC BF                          LD      (0BFECh),A
BCCB: C4 03 E8                          CALL    NZ,0E803h
BCCE: C9                                RET

                                        ; --- START PROC LBCCF ---
BCCF: 3A E9 BF                   LBCCF: LD      A,(0BFE9h)
BCD2: E6 C0                             AND     0C0h
BCD4: FE C0                             CP      0C0h
BCD6: C0                                RET     NZ
BCD7: 21 5B BD                          LD      HL,0BD5Bh
BCDA: 06 80                             LD      B,80h
BCDC: 7E                         LBCDC: LD      A,(HL)
BCDD: 2F                                CPL
BCDE: 77                                LD      (HL),A
BCDF: 23                                INC     HL
BCE0: 10 FA                             DJNZ    LBCDC
BCE2: C9                                RET

                                        ; Entry Point
                                        ; --- START PROC LBCE3 ---
BCE3: DD 21 E0 BF                LBCE3: LD      IX,0BFE0h
BCE7: DD 66 01                          LD      H,(IX+01h)
BCEA: DD 6E 00                          LD      L,(IX+00h)
BCED: 11 05 00                          LD      DE,0005h
BCF0: 19                                ADD     HL,DE
BCF1: 56                                LD      D,(HL)
BCF2: 23                                INC     HL
BCF3: 66                                LD      H,(HL)
BCF4: 6A                                LD      L,D
BCF5: C9                                RET

                                        ; Entry Point
                                        ; --- START PROC LBCF6 ---
BCF6: 0E BD                      LBCF6: LD      C,0BDh
BCF8: 2A F6 BC                          LD      HL,(LBCF6)
BCFB: 7E                                LD      A,(HL)
BCFC: B7                                OR      A
BCFD: FA 05 BD                          JP      M,LBD05
BD00: 23                                INC     HL
BD01: 22 F6 BC                          LD      (LBCF6),HL
BD04: C9                                RET

BD05: 21 36 E4                   LBD05: LD      HL,0E436h
BD08: 22 0A BA                          LD      (LBA09+1),HL    ; reference not aligned to instruction
BD0B: E6 7F                             AND     7Fh     ; ''
BD0D: C9                                RET

BD0E: 49 6E 69 7A 69 6F 20 4C    LBD0E: DB      "Inizio Lavoro"
BD16: 61 76 6F 72 6F
BD1B: 8D                                DB      8Dh

                                        ; Entry Point
                                        ; --- START PROC LBD1C ---
BD1C: 21 25 BD                   LBD1C: LD      HL,0BD25h
BD1F: CD 09 E0                          CALL    0E009h
BD22: C3 00 E0                          JP      0E000h

BD25: 44 49 53 4B 20 46 55 4C    LBD25: DB      "DISK FULL"
BD2D: 4C
BD2E: 0D                                DB      0Dh
BD2F: 0A                                DB      0Ah
BD30: A0                                DB      0A0h

                                        ; Entry Point
                                        ; --- START PROC LBD31 ---
BD31: 29                         LBD31: ADD     HL,HL
BD32: 11 80 B6                          LD      DE,0B680h
BD35: 19                                ADD     HL,DE
BD36: C9                         LBD36: RET

                                        ; Entry Point
                                        ; --- START PROC LBD37 ---
BD37: 60                         LBD37: LD      H,B
BD38: 69                                LD      L,C
BD39: 22 BE BB                          LD      (LBBBD+1),HL    ; reference not aligned to instruction
BD3C: C9                                RET

                                        ; Entry Point
                                        ; --- START PROC LBD3D ---
BD3D: 60                         LBD3D: LD      H,B
BD3E: 69                         LBD3E: LD      L,C
BD3F: 22 C0 BB                   LBD3F: LD      (LBBC0),HL
BD42: C9                                RET

                                        ; Entry Point
                                        ; --- START PROC LBD43 ---
BD43: 7A                         LBD43: LD      A,D
BD44: B7                                OR      A
BD45: CA 4E B9                   LBD45: JP      Z,0B94Eh
BD48: EB                                EX      DE,HL
BD49: 09                                ADD     HL,BC
BD4A: 6E                         LBD4A: LD      L,(HL)
BD4B: 26 00                             LD      H,00h
BD4D: C9                                RET

                                        ; Entry Point
                                        ; --- START PROC LBD4E ---
BD4E: 69                         LBD4E: LD      L,C
BD4F: 60                                LD      H,B
BD50: C9                                RET

                                        ; Entry Point
                                        ; --- START PROC LBD51 ---
BD51: 60                         LBD51: LD      H,B
BD52: 69                         LBD52: LD      L,C
BD53: 22 DD BB                          LD      (LBBDD),HL
BD56: C9                                RET

                                        ; Entry Point
                                        ; --- START PROC LBD57 ---
BD57: CD 11 BB                   LBD57: CALL    LBB11
BD5A: AF                                XOR     A
BD5B: 32 D1 BB                          LD      (LBBD1),A
BD5E: 3E 01                             LD      A,01h
BD60: 32 DB BB                          LD      (LBBDB),A
BD63: 32 DA BB                          LD      (LBBDA),A
BD66: 3E 02                             LD      A,02h
BD68: 32 DC BB                          LD      (LBBDC),A
BD6B: C3 E3 B9                          JP      0B9E3h

BD6E: CD                         LBD6E: DB      0CDh
BD6F: 11                                DB      11h
BD70: BB                                DB      0BBh
BD71: AF                                DB      0AFh
BD72: 32                                DB      32h     ; '2'
BD73: DB                                DB      0DBh
BD74: BB                                DB      0BBh
BD75: 79                                DB      79h     ; 'y'
BD76: 32                                DB      32h     ; '2'
BD77: DC                                DB      0DCh
BD78: BB                                DB      0BBh
BD79: FE                                DB      0FEh
BD7A: 02                                DB      02h
BD7B: C2                                DB      0C2h
BD7C: 95                                DB      95h
BD7D: B9                                DB      0B9h
BD7E: 3E                                DB      3Eh     ; '>'
BD7F: 08                                DB      08h
BD80: 32                                DB      32h     ; '2'
BD81: D1                                DB      0D1h
BD82: BB                                DB      0BBh
BD83: 3A                                DB      3Ah     ; ':'
BD84: BD                                DB      0BDh
BD85: BB                                DB      0BBh
BD86: 32                                DB      32h     ; '2'
BD87: D2                                DB      0D2h
BD88: BB                                DB      0BBh
BD89: 2A                                DB      2Ah     ; '*'
BD8A: BE                                DB      0BEh
BD8B: BB                                DB      0BBh
BD8C: 22                                DB      22h     ; '"'
BD8D: D3                                DB      0D3h
BD8E: BB                                DB      0BBh
BD8F: 3A                                DB      3Ah     ; ':'
BD90: C0                                DB      0C0h
BD91: BB                                DB      0BBh
BD92: 32                                DB      32h     ; '2'
BD93: D5                                DB      0D5h
BD94: BB                                DB      0BBh
BD95: 3A                                DB      3Ah     ; ':'
BD96: D1                                DB      0D1h
BD97: BB                                DB      0BBh
BD98: B7                                DB      0B7h
BD99: CA                                DB      0CAh
BD9A: D4                                DB      0D4h
BD9B: B9                                DB      0B9h
BD9C: 3D                                DB      3Dh     ; '='
BD9D: 32                                DB      32h     ; '2'
BD9E: D1                                DB      0D1h
BD9F: BB                                DB      0BBh
BDA0: 3A                                DB      3Ah     ; ':'
BDA1: BD                                DB      0BDh
BDA2: BB                                DB      0BBh
BDA3: 21                                DB      21h     ; '!'
BDA4: D2                                DB      0D2h
BDA5: BB                                DB      0BBh
BDA6: BE                                DB      0BEh
BDA7: C2                                DB      0C2h
BDA8: D4                                DB      0D4h
BDA9: B9                                DB      0B9h
BDAA: 21                                DB      21h     ; '!'
BDAB: D3                                DB      0D3h
BDAC: BB                                DB      0BBh
BDAD: CD                                DB      0CDh
BDAE: A7                                DB      0A7h
BDAF: BA                                DB      0BAh
BDB0: C2                                DB      0C2h
BDB1: D4                                DB      0D4h
BDB2: B9                                DB      0B9h
BDB3: 3A                                DB      3Ah     ; ':'
BDB4: C0                                DB      0C0h
BDB5: BB                                DB      0BBh
BDB6: 21                                DB      21h     ; '!'
BDB7: D5                                DB      0D5h
BDB8: BB                                DB      0BBh
BDB9: BE                                DB      0BEh
BDBA: C2                                DB      0C2h
BDBB: D4                                DB      0D4h
BDBC: B9                                DB      0B9h
BDBD: 34                                DB      34h     ; '4'
BDBE: 7E                                DB      7Eh     ; '~'
BDBF: FE                                DB      0FEh
BDC0: 10                                DB      10h
BDC1: DA                                DB      0DAh
BDC2: CD                                DB      0CDh
BDC3: B9                                DB      0B9h
BDC4: 36                                DB      36h     ; '6'
BDC5: 00                                DB      00h
BDC6: 2A                                DB      2Ah     ; '*'
BDC7: D3                                DB      0D3h
BDC8: BB                                DB      0BBh
BDC9: 23                                DB      23h     ; '#'
BDCA: 22                                DB      22h     ; '"'
BDCB: D3                                DB      0D3h
BDCC: BB                                DB      0BBh
BDCD: AF                                DB      0AFh
BDCE: 32                                DB      32h     ; '2'
BDCF: DA                                DB      0DAh
BDD0: BB                                DB      0BBh
BDD1: C3                                DB      0C3h
BDD2: E3                                DB      0E3h
BDD3: B9                                DB      0B9h

                                        ; Entry Point
                                        ; --- START PROC LBDD4 ---
BDD4: AF                         LBDD4: XOR     A
BDD5: 32 D1 BB                          LD      (LBBD1),A
BDD8: FD CB 00 7E                       BIT     7,(IY+00h)
BDDC: C2 E0 B9                          JP      NZ,0B9E0h
BDDF: 3C                                INC     A
BDE0: 32 DA BB                          LD      (LBBDA),A
BDE3: AF                                XOR     A
BDE4: 32 D9 BB                          LD      (LBBD9),A
BDE7: 2A C0 BB                          LD      HL,(LBBC0)
BDEA: 7D                                LD      A,L
BDEB: FD CB 00 7E                       BIT     7,(IY+00h)
BDEF: C2 FA B9                          JP      NZ,0B9FAh
BDF2: 29                                ADD     HL,HL
BDF3: 29                                ADD     HL,HL
BDF4: 29                                ADD     HL,HL
BDF5: 29                                ADD     HL,HL
BDF6: 29                                ADD     HL,HL
BDF7: 29                                ADD     HL,HL
BDF8: 29                                ADD     HL,HL
BDF9: 7C                                LD      A,H
BDFA: 32 CB BB                          LD      (LBBCB),A
BDFD: 21 CC BB                          LD      HL,0BBCCh

references to external address 0000h:
        BA33 JP 0000h
        BA36 JP 0000h
        BA39 JP 0000h
        BA3C JP 0000h
        BA3F JP 0000h
        BA42 JP 0000h
        BA45 JP 0000h
        BA48 JP 0000h
        BA4B JP 0000h
        BA4E JP 0000h
        BA51 JP 0000h
        BBAE LD (0000h),A
        BCA5 LD HL,0000h

references to external address 0001h:
        BBB4 LD (0001h),HL

references to external address 0003h:
        BB33 LD A,(0003h)
        BB61 LD A,(0003h)

references to external address 0004h:
        BBC7 LD A,(0004h)

references to external address 0005h:
        BBB7 LD (0005h),A
        BCED LD DE,0005h

references to external address 0006h:
        BBBD LD (0006h),HL

references to external address 0A400h:
        BBCB JP 0A400h

references to external address 0B94Eh:
        BD45 JP Z,0B94Eh

references to external address 0B9E0h:
        BDDC JP NZ,0B9E0h

references to external address 0B9E3h:
        BD6B JP 0B9E3h

references to external address 0B9FAh:
        BDEF JP NZ,0B9FAh

references to external address 0BFE9h:
        BC8D LD (0BFE9h),A
        BCCF LD A,(0BFE9h)

references to external address 0BFEAh:
        BC0A LD HL,(0BFEAh)
        BC11 LD (0BFEAh),HL
        BC18 LD (0BFEAh),HL
        BC59 LD (0BFEAh),HL

references to external address 0BFECh:
        BCC8 LD (0BFECh),A

references to external address 0E000h:
        BD22 JP 0E000h

references to external address 0E003h:
        BB2A CALL 0E003h
        BB2F CALL 0E003h

references to external address 0E006h:
        BB7B CALL 0E006h

references to external address 0E009h:
        BBA9 CALL 0E009h
        BD1F CALL 0E009h

references to external address 0E400h:
        BA00 JP 0E400h

references to external address 0E40Ah:
        BA03 JP 0E40Ah

references to external address 0E4D2h:
        BBF7 CALL 0E4D2h
        BC3C CALL 0E4D2h

references to external address 0E4EAh:
        BC4B CALL 0E4EAh

references to external address 0E549h:
        BBC3 CALL 0E549h

references to external address 0E59Fh:
        BA0C JP 0E59Fh

references to external address 0E5C8h:
        BA0F JP 0E5C8h

references to external address 0E5E7h:
        BA2D JP 0E5E7h

references to external address 0E612h:
        BA12 JP 0E612h

references to external address 0E614h:
        BA15 JP 0E614h

references to external address 0E617h:
        BB5E CALL 0E617h

references to external address 0E62Fh:
        BB77 CALL 0E62Fh
        BB7E CALL 0E62Fh

references to external address 0E641h:
        BA18 JP 0E641h

references to external address 0E658h:
        BA1B JP 0E658h

references to external address 0E677h:
        BA1E JP 0E677h

references to external address 0E67Dh:
        BA21 JP 0E67Dh

references to external address 0E683h:
        BA30 JP 0E683h

references to external address 0E691h:
        BA24 JP 0E691h

references to external address 0E697h:
        BA27 JP 0E697h

references to external address 0E6AEh:
        BA2A JP 0E6AEh

references to external address 0E803h:
        BB96 CALL 0E803h
        BCCB CALL NZ,0E803h

references to external address 0E806h:
        BCBF CALL 0E806h

references to external address 0E809h:
        BC90 CALL NZ,0E809h

references to external address 0E80Fh:
        BC04 CALL 0E80Fh

references to external address 0E812h:
        BC14 CALL 0E812h
        BC42 CALL 0E812h

possible references to internal address BA03:
        BBB1 LD HL,0BA03h

possible references to internal address BA60:
        BC5C LD HL,0BA60h

possible references to internal address BB5E:
        BB0F LD HL,0BB5Eh

possible references to internal address BBCC:
        BDFD LD HL,0BBCCh

possible references to internal address BBCE:
        BBA6 LD HL,0BBCEh

possible references to internal address BD25:
        BD1C LD HL,0BD25h

possible references to internal address BD31:
        BC52 LD IY,0BD31h
        ----------
        BC67 LD (LBD31),DE

possible references to internal address BD37:
        BBEC LD HL,0BD37h

possible references to internal address BD5B:
        BC56 LD HL,0BD5Bh
        BCD7 LD HL,0BD5Bh

possible references to external address 0000h:
        BCA5 LD HL,0000h
        ----------
        BA33 JP 0000h
        BA36 JP 0000h
        BA39 JP 0000h
        BA3C JP 0000h
        BA3F JP 0000h
        BA42 JP 0000h
        BA45 JP 0000h
        BA48 JP 0000h
        BA4B JP 0000h
        BA4E JP 0000h
        BA51 JP 0000h
        BBAE LD (0000h),A

possible references to external address 0005h:
        BCED LD DE,0005h
        ----------
        BBB7 LD (0005h),A

possible references to external address 0080h:
        BBC0 LD BC,0080h

possible references to external address 0AC06h:
        BBBA LD HL,0AC06h

possible references to external address 0B680h:
        BD32 LD DE,0B680h

possible references to external address 0BFE0h:
        BCE3 LD IX,0BFE0h

possible references to external address 0E436h:
        BD05 LD HL,0E436h

possible references to external address 0FE00h:
        BC0E LD HL,0FE00h

references to port 78h
        BB75 IN A,(78h)

references to port 7Ah
        BB48 IN A,(7Ah)
        BB57 IN A,(7Ah)
        BB6E IN A,(7Ah)
        BB46 OUT (7Ah),A
        BB55 OUT (7Ah),A
        BB6C OUT (7Ah),A

references to port 0FFh
        BB3D IN A,(0FFh)

Procedures (60):
  Proc  Length  References Dependants
  LBA00  0003            0          1
  LBA03  0003            0          1
  LBA06  0003            0          1
  LBA09  0003            2          1
  LBA0C  0003            0          1
  LBA0F  0003            0          1
  LBA12  0003            0          1
  LBA15  0003            0          1
  LBA18  0003            0          1
  LBA1B  0003            0          1
  LBA1E  0003            0          1
  LBA21  0003            0          1
  LBA24  0003            0          1
  LBA27  0003            0          1
  LBA2A  0003            0          1
  LBA2D  0003            0          1
  LBA30  0003            0          1
  LBA33  0003            0          1
  LBA36  0003            0          1
  LBA39  0003            0          1
  LBA3C  0003            0          1
  LBA3F  0003            0          1
  LBA42  0003            0          1
  LBA45  0003            0          1
  LBA48  0003            0          1
  LBA4B  0003            0          1
  LBA4E  0003            0          1
  LBA51  0003            0          1
  LBB02  0016            1          0
  LBB11  0007            1          0
  LBB28  000B            0          1
  LBB33  001A            1          1
  LBB40  0005            2          0
  LBB4C  0008            1          1
  LBB54  000A            0          1
  LBB5E  0024            0          3
  LBB6B  0003            1          1
  LBB6C  000F            2          2
  LBB82  000E            0          2
  LBB90  000F            0          2
  LBB9F  002F            1          3
  LBBEB  000C            0          0
  LBBF7  0045            0          6
  LBC3C  0012            0          5
  LBC4B  0004            1          1
  LBC4F  0010            0          1
  LBC5C  0010            1          0
  LBC6C  0063            2          4
  LBCCF  0014            3          0
  LBCE3  0013            0          0
  LBCF6  0018            2          0
  LBD1C  0009            0          2
  LBD31  0006            1          0
  LBD37  0006            0          0
  LBD3D  0006            1          0
  LBD43  000B            0          1
  LBD4E  0003            0          0
  LBD51  0006            0          0
  LBD57  0017            0          2
  LBDD4  002C            0          2

Call Graph:
LBA00 - Entry Point
  0E400h - External
LBA03 - Entry Point
  0E40Ah - External
LBA06 - Entry Point
  LBB33
    LBB4C
      LBB40
LBA09 - Entry Point
  LBB02
LBA0C - Entry Point
  0E59Fh - External
LBA0F - Entry Point
  0E5C8h - External
LBA12 - Entry Point
  0E612h - External
LBA15 - Entry Point
  0E614h - External
LBA18 - Entry Point
  0E641h - External
LBA1B - Entry Point
  0E658h - External
LBA1E - Entry Point
  0E677h - External
LBA21 - Entry Point
  0E67Dh - External
LBA24 - Entry Point
  0E691h - External
LBA27 - Entry Point
  0E697h - External
LBA2A - Entry Point
  0E6AEh - External
LBA2D - Entry Point
  0E5E7h - External
LBA30 - Entry Point
  0E683h - External
LBA33 - Entry Point
  0000h - External
LBA36 - Entry Point
  0000h - External
LBA39 - Entry Point
  0000h - External
LBA3C - Entry Point
  0000h - External
LBA3F - Entry Point
  0000h - External
LBA42 - Entry Point
  0000h - External
LBA45 - Entry Point
  0000h - External
LBA48 - Entry Point
  0000h - External
LBA4B - Entry Point
  0000h - External
LBA4E - Entry Point
  0000h - External
LBA51 - Entry Point
  0000h - External
LBB28 - Entry Point
  0E003h - External
LBB54 - Entry Point
  LBB4C
    LBB40
LBB5E - Entry Point
  0E617h - External
  0E62Fh - External
  0E006h - External
LBB82 - Entry Point
  LBB9F
    0E009h - External
    0E549h - External
    0A400h - External
  LBB6C
    LBB6B
      LBB6C - Recursive
    0E62Fh - External
LBB90 - Entry Point
  0E803h - External
  LBB6C
    LBB6B
      LBB6C - Recursive
    0E62Fh - External
LBBEB - Entry Point
LBBF7 - Entry Point
  0E4D2h - External
  LBC6C
    LBC5C
    0E809h - External
    0E806h - External
    0E803h - External
  LBCCF
  0E80Fh - External
  0E812h - External
  LBC4B
    0E4EAh - External
LBC3C - Entry Point
  0E4D2h - External
  LBC6C
    LBC5C
    0E809h - External
    0E806h - External
    0E803h - External
  0E812h - External
  LBCCF
  LBC4B
    0E4EAh - External
LBC4F - Entry Point
  LBC5C
LBCE3 - Entry Point
LBCF6 - Entry Point
LBD1C - Entry Point
  0E009h - External
  0E000h - External
LBD31 - Entry Point
LBD37 - Entry Point
LBD3D - Entry Point
LBD43 - Entry Point
  0B94Eh - External
LBD4E - Entry Point
LBD51 - Entry Point
LBD57 - Entry Point
  LBB11
  0B9E3h - External
LBDD4 - Entry Point
  0B9E0h - External
  0B9FAh - External
