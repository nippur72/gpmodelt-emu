SA_DATA_PORT   EQU $6C
SA_CTRL_PORT   EQU $6D

SA_OUT_PIN_RESET EQU 0FBh    ; RES is BIT 2

;**************************************************
; 0 BSY
; 1 MSG
; 2 CD
; 3 REQ
; 4 IO


IX_RETRYCOUNT  EQU $11  ; number of retry for disk ops
IX_CURRDRIVE   EQU $09  ; current drive number
IX_DSKBUFPTR   EQU $0A  ; (word) pointer disk sector buffer

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


EPROM2_PRINTSTRING EQU $E009     ; print string routine in rom set 2

; control port write to pins
; 0 ACK
; 1 RESET (used by restore)
; 2 SEL
; 3 -
; 4 ?ATN  (used by send command)
; 5 -
; 6 -
; 7 -
;
; control port read pins
; 0 BSY
; 1 ERR
; 2 CD oppure IO
; 3 REQ
; 4 CD oppure IO
; 5 -
; 6 -
; 7 -

E000: C3 1B E0                   LE000: JP      LE01B
E003: C3 F4 E0                   LE003: JP      LE0F4
E006: C3 AA E0                   LE006: JP      LE0AA
E009: C3 C4 E0                   EPROM2_PRINTSTRING: JP      LE0C4
E00C: C3 30 E3                   LE00C: JP      LE330
E00F: C3 CF E0                   LE00F: JP      LE0CF
E012: C3 E4 E0                   LE012: JP      LE0E4
E015: C3 4F E3                   LE015: JP      LE34F

E018: C3 64 E0                   LE018: JP      LE064

E01B: 31 E0 BF                   LE01B: LD      SP,0BFE0h
E01E: DB FF                             IN      A,(0FFh)
E020: CD 12 E0                          CALL    LE012
E023: CD 0F E0                          CALL    LE00F
E026: 21 BA E3                          LD      HL,0E3BAh
E029: CD 09 E0                          CALL    EPROM2_PRINTSTRING
E02C: CD 06 E0                          CALL    LE006
E02F: CD 03 E0                          CALL    LE003
E032: E6 DF                             AND     0DFh
E034: 5F                                LD      E,A
E035: CD 06 E0                          CALL    LE006
E038: FE 0D                             CP      0Dh
E03A: C2 00 E0                          JP      NZ,LE000
E03D: 7B                                LD      A,E
E03E: FE 42                             CP      42h     ; 'B'
E040: CA 18 E8                          JP      Z,BOOT_FROM_SA0
E043: FE 52                             CP      52h     ; 'R'
E045: CA 00 01                          JP      Z,0100h
E048: FE 54                             CP      54h     ; 'T'
E04A: CA BB E0                          JP      Z,LE0BB
E04D: FE 46                      LE04D: CP      46h     ; 'F'
E04F: CA 85 E3                          JP      Z,LE385
E052: FE 4D                             CP      4Dh     ; 'M'
E054: CA 6C E0                          JP      Z,LE06C
E057: FE 43                             CP      43h     ; 'C'
E059: CA 15 E8                          JP      Z,BOOT_UNIT_20_0
E05C: FE 53                             CP      53h     ; 'S'
E05E: CA 00 EC                          JP      Z,LEC00
E061: C3 1B E0                          JP      LE01B

E064: E5                         LE064: PUSH    HL
E065: F5                                PUSH    AF
E066: CD 77 E1                          CALL    LE177
E069: F1                                POP     AF
E06A: E1                                POP     HL
E06B: C9                                RET

E06C: 01 00 00                   LE06C: LD      BC,0000h
E06F: CD 06 E0                   LE06F: CALL    LE006
E072: CD 03 E0                          CALL    LE003
E075: FE 0D                             CP      0Dh
E077: CA 98 E0                          JP      Z,LE098
E07A: FE 40                             CP      40h     ; '@'
E07C: 38 04                             JR      C,LE082
E07E: E6 0F                             AND     0Fh
E080: C6 09                             ADD     A,09h
E082: E6 0F                      LE082: AND     0Fh
E084: CB 21                             SLA     C
E086: CB 10                             RL      B
E088: CB 21                             SLA     C
E08A: CB 10                             RL      B
E08C: CB 21                             SLA     C
E08E: CB 10                             RL      B
E090: CB 21                             SLA     C
E092: CB 10                             RL      B
E094: B1                                OR      C
E095: 4F                                LD      C,A
E096: 18 D7                             JR      LE06F

E098: 3E 0A                      LE098: LD      A,0Ah
E09A: CD 03 E0                          CALL    LE003
E09D: CD 15 E0                   LE09D: CALL    LE015
E0A0: CD 06 E0                   LE0A0: CALL    LE006
E0A3: FE 0D                             CP      0Dh
E0A5: 20 F9                             JR      NZ,LE0A0
E0A7: 03                                INC     BC
E0A8: 18 F3                             JR      LE09D

                                        ; --- START PROC LE0AA ---
E0AA: DB FF                      LE0AA: IN      A,(0FFh)
E0AC: 07                                RLCA
E0AD: 38 FB                             JR      C,LE0AA
E0AF: 0F                                RRCA
E0B0: 2F                                CPL
E0B1: F5                                PUSH    AF
E0B2: DB FF                      LE0B2: IN      A,(0FFh)
E0B4: 07                                RLCA
E0B5: 30 FB                             JR      NC,LE0B2
E0B7: F1                                POP     AF
E0B8: E6 7F                             AND     7Fh     ; ''
E0BA: C9                                RET

E0BB: CD 06 E0                   LE0BB: CALL    LE006
E0BE: CD 03 E0                          CALL    LE003
E0C1: C3 BB E0                          JP      LE0BB

                                        ; --- START PROC LE0C4 ---
E0C4: 7E                         LE0C4: LD      A,(HL)
E0C5: CD 03 E0                          CALL    LE003
E0C8: CB 7F                             BIT     7,A
E0CA: 23                                INC     HL
E0CB: CA 09 E0                          JP      Z,EPROM2_PRINTSTRING
E0CE: C9                                RET

                                        ; --- START PROC LE0CF ---
E0CF: 3E 00                      LE0CF: LD      A,00h
E0D1: 32 E3 BF                          LD      (0BFE3h),A
E0D4: 32 E2 BF                          LD      (0BFE2h),A
E0D7: 32 E0 BF                          LD      (0BFE0h),A
E0DA: 32 E1 BF                          LD      (0BFE1h),A
E0DD: 32 E4 BF                          LD      (0BFE4h),A
E0E0: 32 E5 BF                          LD      (0BFE5h),A
E0E3: C9                                RET

                                        ; --- START PROC LE0E4 ---
E0E4: 3E FF                      LE0E4: LD      A,0FFh
E0E6: D3 5F                             OUT     (5Fh),A ; '_'
E0E8: 3E FB                             LD      A,0FBh
E0EA: D3 5F                             OUT     (5Fh),A ; '_'
E0EC: 3E FF                             LD      A,0FFh
E0EE: D3 5E                             OUT     (5Eh),A ; '^'
E0F0: AF                                XOR     A
E0F1: D3 5E                             OUT     (5Eh),A ; '^'
E0F3: C9                                RET

                                        ; --- START PROC LE0F4 ---
E0F4: E5                         LE0F4: PUSH    HL
E0F5: F5                                PUSH    AF
E0F6: E6 7F                             AND     7Fh     ; ''
E0F8: F5                                PUSH    AF
E0F9: CD 77 E1                          CALL    LE177
E0FC: 3A E1 BF                          LD      A,(0BFE1h)
E0FF: FE 00                             CP      00h
E101: C2 A6 E2                          JP      NZ,LE2A6
E104: 3A E5 BF                          LD      A,(0BFE5h)
E107: FE 00                             CP      00h
E109: C2 D7 E2                          JP      NZ,LE2D7
E10C: F1                                POP     AF
E10D: FE 0D                             CP      0Dh
E10F: CA 2E E2                          JP      Z,LE22E
E112: FE 0A                             CP      0Ah
E114: CA 1C E2                          JP      Z,LE21C
E117: FE 02                             CP      02h
E119: CA 2C E3                          JP      Z,LE32C
E11C: FE 03                             CP      03h
E11E: CA 25 E3                          JP      Z,LE325
E121: FE 16                             CP      16h
E123: CA 9F E2                          JP      Z,LE29F
E126: FE 0C                             CP      0Ch
E128: CA 0A E3                          JP      Z,LE30A
E12B: FE 08                             CP      08h
E12D: CA 5B E2                          JP      Z,LE25B
E130: FE 0F                             CP      0Fh
E132: CA 7A E2                          JP      Z,LE27A
E135: FE 0E                             CP      0Eh
E137: CA 3B E2                          JP      Z,LE23B
E13A: FE 0B                             CP      0Bh
E13C: CA 87 E2                          JP      Z,LE287
E13F: FE 09                             CP      09h
E141: CA 91 E2                          JP      Z,LE291
E144: FE 04                             CP      04h
E146: CA 97 E3                          JP      Z,LE397
E149: FE 1B                             CP      1Bh
E14B: CA D0 E2                          JP      Z,LE2D0
E14E: F5                                PUSH    AF
E14F: 3A E4 BF                          LD      A,(0BFE4h)
E152: B7                                OR      A
E153: CA 63 E1                          JP      Z,LE163
E156: F1                                POP     AF
E157: FE 61                             CP      61h     ; 'a'
E159: 38 09                             JR      C,LE164
E15B: FE 7B                             CP      7Bh     ; '{'
E15D: 30 05                             JR      NC,LE164
E15F: E6 1F                             AND     1Fh
E161: 18 01                             JR      LE164

E163: F1                         LE163: POP     AF
E164: C5                         LE164: PUSH    BC
E165: 47                                LD      B,A
E166: 3A E0 BF                          LD      A,(0BFE0h)
E169: E6 80                             AND     80h
E16B: 80                                ADD     A,B
E16C: 77                                LD      (HL),A
E16D: CD A1 E1                          CALL    LE1A1
E170: CD 77 E1                          CALL    LE177
E173: C1                                POP     BC
E174: F1                                POP     AF
E175: E1                                POP     HL
E176: C9                                RET

                                        ; --- START PROC LE177 ---
E177: CD 7F E1                   LE177: CALL    LE17F
E17A: 7E                                LD      A,(HL)
E17B: C6 80                             ADD     A,80h
E17D: 77                                LD      (HL),A
E17E: C9                                RET

                                        ; --- START PROC LE17F ---
E17F: C5                         LE17F: PUSH    BC
E180: F5                                PUSH    AF
E181: 21 00 C0                          LD      HL,0C000h
E184: 06 00                             LD      B,00h
E186: 3A E3 BF                          LD      A,(0BFE3h)
E189: 4F                                LD      C,A
E18A: 09                                ADD     HL,BC
E18B: CD 91 E1                          CALL    LE191
E18E: F1                                POP     AF
E18F: C1                                POP     BC
E190: C9                                RET

                                        ; --- START PROC LE191 ---
E191: 3A E2 BF                   LE191: LD      A,(0BFE2h)
E194: B7                                OR      A
E195: C8                                RET     Z
E196: 47                                LD      B,A
                                        ; --- START PROC LE197 ---
E197: 3E 80                      LE197: LD      A,80h
E199: 85                                ADD     A,L
E19A: 6F                                LD      L,A
E19B: 30 01                             JR      NC,LE19E
E19D: 24                                INC     H
E19E: 10 F7                      LE19E: DJNZ    LE197
E1A0: C9                                RET

                                        ; --- START PROC LE1A1 ---
E1A1: F5                         LE1A1: PUSH    AF
E1A2: 3A E3 BF                          LD      A,(0BFE3h)
E1A5: FE 4F                             CP      4Fh     ; 'O'
E1A7: 28 06                             JR      Z,LE1AF
E1A9: 3C                                INC     A
E1AA: 32 E3 BF                          LD      (0BFE3h),A
E1AD: F1                         LE1AD: POP     AF
E1AE: C9                                RET

E1AF: 3A E2 BF                   LE1AF: LD      A,(0BFE2h)
E1B2: FE 17                             CP      17h
E1B4: 28 0B                             JR      Z,LE1C1
E1B6: 3C                                INC     A
E1B7: 32 E2 BF                          LD      (0BFE2h),A
E1BA: 3E 00                      LE1BA: LD      A,00h
E1BC: 32 E3 BF                          LD      (0BFE3h),A
E1BF: 18 EC                             JR      LE1AD

E1C1: CD C6 E1                   LE1C1: CALL    LE1C6
E1C4: 18 F4                             JR      LE1BA

                                        ; --- START PROC LE1C6 ---
E1C6: C5                         LE1C6: PUSH    BC
E1C7: 0E 00                             LD      C,00h
E1C9: 06 00                             LD      B,00h
E1CB: CD D9 E1                   LE1CB: CALL    LE1D9
E1CE: 0C                                INC     C
E1CF: 3E 17                             LD      A,17h
E1D1: B9                                CP      C
E1D2: 20 F7                             JR      NZ,LE1CB
E1D4: CD FB E1                          CALL    LE1FB
E1D7: C1                                POP     BC
E1D8: C9                                RET

                                        ; --- START PROC LE1D9 ---
E1D9: F5                         LE1D9: PUSH    AF
E1DA: C5                                PUSH    BC
E1DB: E5                                PUSH    HL
E1DC: D5                                PUSH    DE
E1DD: 21 00 C0                          LD      HL,0C000h
E1E0: E5                                PUSH    HL
E1E1: 79                                LD      A,C
E1E2: B7                                OR      A
E1E3: 28 04                             JR      Z,LE1E9
E1E5: 47                                LD      B,A
E1E6: CD 97 E1                          CALL    LE197
E1E9: E5                         LE1E9: PUSH    HL
E1EA: D1                                POP     DE
E1EB: E1                                POP     HL
E1EC: 41                                LD      B,C
E1ED: 04                                INC     B
E1EE: CD 97 E1                          CALL    LE197
E1F1: 01 50 00                          LD      BC,0050h
E1F4: ED B0                             LDIR
                                        ; --- START PROC LE1F6 ---
E1F6: D1                         LE1F6: POP     DE
E1F7: E1                                POP     HL
E1F8: C1                                POP     BC
E1F9: F1                                POP     AF
E1FA: C9                                RET

                                        ; --- START PROC LE1FB ---
E1FB: F5                         LE1FB: PUSH    AF
E1FC: C5                                PUSH    BC
E1FD: E5                                PUSH    HL
E1FE: D5                                PUSH    DE
E1FF: 21 00 C0                          LD      HL,0C000h
E202: 79                                LD      A,C
E203: B7                                OR      A
E204: 28 04                             JR      Z,LE20A
E206: 47                                LD      B,A
E207: CD 97 E1                          CALL    LE197
E20A: E5                         LE20A: PUSH    HL
E20B: D1                                POP     DE
E20C: 13                                INC     DE
E20D: 3A E0 BF                          LD      A,(0BFE0h)
E210: E6 80                             AND     80h
E212: F6 20                             OR      20h     ; ' '
E214: 77                                LD      (HL),A
E215: 01 7F 00                          LD      BC,007Fh
E218: ED B0                             LDIR
E21A: 18 DA                             JR      LE1F6

                                        ; --- START PROC LE21C ---
E21C: 3A E2 BF                   LE21C: LD      A,(0BFE2h)
E21F: FE 17                             CP      17h
E221: 28 06                             JR      Z,LE229
E223: 3C                                INC     A
E224: 32 E2 BF                          LD      (0BFE2h),A
E227: 18 0C                             JR      LE235

E229: CD C6 E1                   LE229: CALL    LE1C6
E22C: 18 07                             JR      LE235

                                        ; --- START PROC LE22E ---
E22E: 3E 00                      LE22E: LD      A,00h
E230: 32 E3 BF                          LD      (0BFE3h),A
E233: 18 00                             JR      LE235

                                        ; --- START PROC LE235 ---
E235: CD 77 E1                   LE235: CALL    LE177
E238: F1                                POP     AF
E239: E1                                POP     HL
E23A: C9                                RET

                                        ; --- START PROC LE23B ---
E23B: 3A E3 BF                   LE23B: LD      A,(0BFE3h)
E23E: FE 4F                             CP      4Fh     ; 'O'
E240: 28 07                             JR      Z,LE249
E242: 3C                                INC     A
E243: 32 E3 BF                          LD      (0BFE3h),A
E246: C3 35 E2                          JP      LE235

E249: 3A E2 BF                   LE249: LD      A,(0BFE2h)
E24C: FE 17                             CP      17h
E24E: 28 09                             JR      Z,LE259
E250: 3C                                INC     A
E251: 32 E2 BF                          LD      (0BFE2h),A
E254: 3E 00                             LD      A,00h
E256: 32 E3 BF                          LD      (0BFE3h),A
                                        ; --- START PROC LE259 ---
E259: 18 DA                      LE259: JR      LE235

                                        ; --- START PROC LE25B ---
E25B: 3A E3 BF                   LE25B: LD      A,(0BFE3h)
E25E: FE 00                             CP      00h
E260: 28 06                             JR      Z,LE268
E262: 3D                                DEC     A
E263: 32 E3 BF                          LD      (0BFE3h),A
E266: 18 CD                             JR      LE235

E268: 3A E2 BF                   LE268: LD      A,(0BFE2h)
E26B: FE 00                             CP      00h
E26D: 28 09                             JR      Z,LE278
E26F: 3D                                DEC     A
E270: 32 E2 BF                          LD      (0BFE2h),A
E273: 3E 4F                             LD      A,4Fh   ; 'O'
E275: 32 E3 BF                          LD      (0BFE3h),A
                                        ; --- START PROC LE278 ---
E278: 18 BB                      LE278: JR      LE235

                                        ; --- START PROC LE27A ---
E27A: 3A E2 BF                   LE27A: LD      A,(0BFE2h)
E27D: FE 00                             CP      00h
E27F: 28 B4                             JR      Z,LE235
E281: 3D                                DEC     A
E282: 32 E2 BF                          LD      (0BFE2h),A
E285: 18 AE                             JR      LE235

                                        ; --- START PROC LE287 ---
E287: 3E 00                      LE287: LD      A,00h
E289: 32 E3 BF                          LD      (0BFE3h),A
E28C: 32 E2 BF                          LD      (0BFE2h),A
E28F: 18 A4                             JR      LE235

                                        ; --- START PROC LE291 ---
E291: CD A1 E1                   LE291: CALL    LE1A1
E294: 3A E3 BF                          LD      A,(0BFE3h)
E297: E6 07                             AND     07h
E299: FE 07                             CP      07h
E29B: 20 F4                             JR      NZ,LE291
                                        ; --- START PROC LE29D ---
E29D: 18 96                      LE29D: JR      LE235

                                        ; --- START PROC LE29F ---
E29F: 3E 01                      LE29F: LD      A,01h
E2A1: 32 E1 BF                          LD      (0BFE1h),A
E2A4: 18 8F                             JR      LE235

                                        ; --- START PROC LE2A6 ---
E2A6: FE 01                      LE2A6: CP      01h
E2A8: C2 BE E2                          JP      NZ,LE2BE
E2AB: F1                                POP     AF
E2AC: CB 27                             SLA     A
E2AE: CB 27                             SLA     A
E2B0: CB 27                             SLA     A
E2B2: CB 27                             SLA     A
E2B4: 32 E0 BF                          LD      (0BFE0h),A
E2B7: 3E 02                             LD      A,02h
E2B9: 32 E1 BF                          LD      (0BFE1h),A
E2BC: 18 DF                             JR      LE29D

E2BE: F1                         LE2BE: POP     AF
E2BF: E6 0F                             AND     0Fh
E2C1: 47                                LD      B,A
E2C2: 3A E0 BF                          LD      A,(0BFE0h)
E2C5: B0                                OR      B
E2C6: 32 E0 BF                          LD      (0BFE0h),A
E2C9: 3E 00                             LD      A,00h
E2CB: 32 E1 BF                          LD      (0BFE1h),A
E2CE: 18 CD                             JR      LE29D

                                        ; --- START PROC LE2D0 ---
E2D0: 3E 01                      LE2D0: LD      A,01h
E2D2: 32 E5 BF                          LD      (0BFE5h),A
E2D5: 18 C6                             JR      LE29D

                                        ; --- START PROC LE2D7 ---
E2D7: FE 01                      LE2D7: CP      01h
E2D9: C2 ED E2                          JP      NZ,LE2ED
E2DC: F1                                POP     AF
E2DD: FE 3D                             CP      3Dh     ; '='
E2DF: CA E5 E2                          JP      Z,LE2E5
E2E2: C3 02 E3                          JP      LE302

E2E5: 3E 02                      LE2E5: LD      A,02h
E2E7: 32 E5 BF                          LD      (0BFE5h),A
E2EA: C3 9D E2                          JP      LE29D

E2ED: FE 02                      LE2ED: CP      02h
E2EF: C2 FE E2                          JP      NZ,LE2FE
E2F2: F1                                POP     AF
E2F3: 32 E3 BF                          LD      (0BFE3h),A
E2F6: 3E 03                             LD      A,03h
E2F8: 32 E5 BF                          LD      (0BFE5h),A
E2FB: C3 9D E2                          JP      LE29D

E2FE: F1                         LE2FE: POP     AF
E2FF: 32 E2 BF                          LD      (0BFE2h),A
E302: 3E 00                      LE302: LD      A,00h
E304: 32 E5 BF                          LD      (0BFE5h),A
E307: C3 9D E2                          JP      LE29D

                                        ; --- START PROC LE30A ---
E30A: C5                         LE30A: PUSH    BC
E30B: 0E 17                             LD      C,17h
E30D: 06 00                             LD      B,00h
E30F: CD FB E1                   LE30F: CALL    LE1FB
E312: 0D                                DEC     C
E313: C2 0F E3                          JP      NZ,LE30F
E316: CD FB E1                          CALL    LE1FB
E319: 3E 00                             LD      A,00h
E31B: 32 E2 BF                          LD      (0BFE2h),A
E31E: 32 E3 BF                          LD      (0BFE3h),A
E321: C1                                POP     BC
E322: C3 9D E2                          JP      LE29D

                                        ; --- START PROC LE325 ---
E325: AF                         LE325: XOR     A
                                        ; --- START PROC LE326 ---
E326: 32 E4 BF                   LE326: LD      (0BFE4h),A
E329: C3 9D E2                          JP      LE29D

                                        ; --- START PROC LE32C ---
E32C: 3E 01                      LE32C: LD      A,01h
E32E: 18 F6                             JR      LE326

                                        ; --- START PROC LE330 ---
E330: F5                         LE330: PUSH    AF
E331: C5                                PUSH    BC
E332: 4F                                LD      C,A
E333: DB 5D                      LE333: IN      A,(5Dh) ; ']'
E335: 07                                RLCA
E336: 07                                RLCA
E337: 47                                LD      B,A
E338: 3A E0 BF                          LD      A,(0BFE0h)
E33B: EE 04                             XOR     04h
E33D: A0                                AND     B
E33E: E6 0C                             AND     0Ch
E340: 20 F1                             JR      NZ,LE333
E342: 79                                LD      A,C
E343: D3 5C                             OUT     (5Ch),A ; '\'
E345: 3A E0 BF                          LD      A,(0BFE0h)
E348: EE 08                             XOR     08h
E34A: D3 5D                             OUT     (5Dh),A ; ']'
E34C: C1                                POP     BC
E34D: F1                                POP     AF
E34E: C9                                RET

                                        ; --- START PROC LE34F ---
E34F: F5                         LE34F: PUSH    AF
E350: 0A                                LD      A,(BC)
E351: CB 2F                             SRA     A
E353: CB 2F                             SRA     A
E355: CB 2F                             SRA     A
E357: CB 2F                             SRA     A
E359: E6 0F                             AND     0Fh
E35B: FE 0A                             CP      0Ah
E35D: 38 07                             JR      C,LE366
E35F: C6 37                             ADD     A,37h   ; '7'
E361: CD 03 E0                          CALL    LE003
E364: 18 05                             JR      LE36B

E366: C6 30                      LE366: ADD     A,30h   ; '0'
E368: CD 03 E0                          CALL    LE003
E36B: 0A                         LE36B: LD      A,(BC)
E36C: E6 0F                             AND     0Fh
E36E: FE 0A                             CP      0Ah
E370: 38 07                             JR      C,LE379
E372: C6 37                             ADD     A,37h   ; '7'
E374: CD 03 E0                          CALL    LE003
E377: 18 05                             JR      LE37E

E379: C6 30                      LE379: ADD     A,30h   ; '0'
E37B: CD 03 E0                          CALL    LE003
E37E: 3E 20                      LE37E: LD      A,20h   ; ' '
E380: CD 03 E0                          CALL    LE003
E383: F1                                POP     AF
E384: C9                                RET

E385: 3E 30                      LE385: LD      A,30h   ; '0'
E387: 32 00 C0                          LD      (0C000h),A
E38A: 21 00 C0                          LD      HL,0C000h
E38D: 11 01 C0                          LD      DE,0C001h
E390: 01 00 0C                          LD      BC,0C00h
E393: ED B0                             LDIR
E395: 18 FE                      LE395: JR      LE395

                                        ; --- START PROC LE397 ---
E397: 21 D0 BF                   LE397: LD      HL,0BFD0h
E39A: 06 18                             LD      B,18h
E39C: 11 30 00                   LE39C: LD      DE,0030h
E39F: 19                                ADD     HL,DE
E3A0: C5                                PUSH    BC
E3A1: 06 50                             LD      B,50h   ; 'P'
E3A3: 7E                         LE3A3: LD      A,(HL)
E3A4: CD 30 E3                          CALL    LE330
E3A7: 23                                INC     HL
E3A8: 10 F9                             DJNZ    LE3A3
E3AA: 3E 0D                             LD      A,0Dh
E3AC: CD 30 E3                          CALL    LE330
E3AF: 3E 0A                             LD      A,0Ah
E3B1: CD 30 E3                          CALL    LE330
E3B4: C1                                POP     BC
E3B5: 10 E5                             DJNZ    LE39C
E3B7: C3 35 E2                          JP      LE235

E3BA: 0C                         LE3BA: INC     C
E3BB: 47                                LD      B,A
E3BC: 20 45                             JR      NZ,LE401+2      ; reference not aligned to instruction
E3BE: 20 4E                             JR      NZ,LE40D+1      ; reference not aligned to instruction
E3C0: 20 45                             JR      NZ,LE407
E3C2: 20 52                             JR      NZ,LE415+1      ; reference not aligned to instruction
E3C4: 20 41                             JR      NZ,LE407
E3C6: 20 4C                             JR      NZ,LE412+2      ; reference not aligned to instruction
E3C8: 20 20                             JR      NZ,LE3EA
E3CA: 20 50                             JR      NZ,LE41B+1      ; reference not aligned to instruction
E3CC: 20 52                             JR      NZ,LE420
E3CE: 20 4F                             JR      NZ,LE41F
E3D0: 20 43                             JR      NZ,LE415
E3D2: 20 45                             JR      NZ,LE419
E3D4: 20 53                             JR      NZ,LE427+2      ; reference not aligned to instruction
E3D6: 20 53                             JR      NZ,LE42A+1      ; reference not aligned to instruction
E3D8: 20 4F                             JR      NZ,LE427+2      ; reference not aligned to instruction
E3DA: 20 52                             JR      NZ,LE42D+1      ; reference not aligned to instruction
E3DC: 0D                                DEC     C
E3DD: 0A                                LD      A,(BC)
E3DE: 4D                                LD      C,L
E3DF: 4F                                LD      C,A
E3E0: 44                                LD      B,H
E3E1: 2E 54                             LD      L,54h   ; 'T'
E3E3: 20 32                             JR      NZ,LE417
E3E5: 34                                INC     (HL)
E3E6: 58                                LD      E,B
E3E7: 38 30                             JR      C,LE419
E3E9: 0D                                DEC     C
E3EA: 0A                         LE3EA: LD      A,(BC)
                                        ; --- START PROC LE3EB ---
E3EB: 72                         LE3EB: LD      (HL),D
E3EC: 65                                LD      H,L
E3ED: 76                                HALT
E3EE: 2E 20                             LD      L,20h   ; ' '
E3F0: 32 34 20                          LD      (2034h),A
E3F3: 64                                LD      H,H
E3F4: 69                                LD      L,C
E3F5: 63                                LD      H,E
E3F6: 2F                                CPL
E3F7: 38 31                             JR      C,LE42A
E3F9: 3E A0                             LD      A,0A0h
E3FB: 02                                LD      (BC),A
E3FC: 03                                INC     BC
E3FD: E0                                RET     PO
E3FE: 3E 20                             LD      A,20h   ; ' '
E400: AF                                XOR     A
E401: 32 03 00                   LE401: LD      (0003h),A
E404: 32 04 00                          LD      (0004h),A
E407: C3 51 E4                   LE407: JP      LE451

E40A: 31 80 00                   LE40A: LD      SP,0080h
E40D: 0E 21                      LE40D: LD      C,21h   ; '!'
E40F: CD 09 E8                          CALL    RIG_SETDRIVE
E412: CD 00 E8                   LE412: CALL    RIG_INITD
E415: 0E 00                      LE415: LD      C,00h
E417: 06 16                      LE417: LD      B,16h
E419: 16 01                      LE419: LD      D,01h
E41B: 21 00 A4                   LE41B: LD      HL,0A400h
E41E: C5                         LE41E: PUSH    BC
E41F: D5                         LE41F: PUSH    DE
E420: E5                         LE420: PUSH    HL
E421: 4A                                LD      C,D
E422: CD 06 E8                          CALL    RIG_SETSECTOR
E425: C1                                POP     BC
E426: C5                                PUSH    BC
E427: CD 0C E8                   LE427: CALL    RIG_SETDMA
E42A: CD 12 E8                   LE42A: CALL    RIG_READSECTOR
E42D: C2 2A E4                   LE42D: JP      NZ,LE42A
E430: E1                                POP     HL
E431: 11 00 01                          LD      DE,0100h
E434: 19                                ADD     HL,DE
E435: D1                                POP     DE
E436: C1                                POP     BC
E437: 05                                DEC     B
E438: CA 51 E4                          JP      Z,LE451
E43B: 14                                INC     D
E43C: 7A                                LD      A,D
E43D: FE 10                             CP      10h
E43F: C3 1E E4                          JP      LE41E

E442: 16 00                      LE442: LD      D,00h
E444: 0C                                INC     C
E445: C5                                PUSH    BC
E446: D5                                PUSH    DE
E447: E5                                PUSH    HL
E448: CD 03 E8                          CALL    RIG_SETTRACK
E44B: E1                                POP     HL
E44C: D1                                POP     DE
E44D: C1                                POP     BC
E44E: C3 1E E4                          JP      LE41E

E451: AF                         LE451: XOR     A
E452: 32 96 BB                          LD      (0BB96h),A
E455: 32 9B BB                          LD      (0BB9Bh),A
E458: 21 88 E4                          LD      HL,0E488h
E45B: CD 09 E0                          CALL    EPROM2_PRINTSTRING
E45E: 3E C3                             LD      A,0C3h
E460: 32 00 00                          LD      (0000h),A
E463: 21 03 BA                          LD      HL,0BA03h
E466: 22 01 00                          LD      (0001h),HL
E469: 32 05 00                          LD      (0005h),A
E46C: 21 06 AC                          LD      HL,0AC06h
E46F: 22 06 00                          LD      (0006h),HL
E472: 01 80 00                          LD      BC,0080h
E475: CD 91 E6                          CALL    LE691
E478: 21 55 BA                          LD      HL,0BA55h
E47B: 0E 7A                             LD      C,7Ah   ; 'z'
E47D: 06 0B                             LD      B,0Bh
E47F: ED B3                             OTIR
E481: 3A 04 00                          LD      A,(0004h)
E484: 4F                                LD      C,A
E485: C3 00 A4                          JP      0A400h

E488: 44                         LE488: LD      B,H
E489: 4F                                LD      C,A
E48A: 53                                LD      D,E
E48B: 20 34                             JR      NZ,LE4C0+1      ; reference not aligned to instruction
E48D: 38 6B                             JR      C,LE4F8+2       ; reference not aligned to instruction
E48F: 0D                                DEC     C
E490: 0A                                LD      A,(BC)
E491: 62                                LD      H,D
E492: 6C                                LD      L,H
E493: 6B                                LD      L,E
E494: 20 3D                             JR      NZ,LE4D3
E496: 20 32                             JR      NZ,LE4CA
E498: 0D                                DEC     C
E499: 0A                                LD      A,(BC)
E49A: 72                                LD      (HL),D
E49B: 65                                LD      H,L
E49C: 76                                HALT
E49D: 2E 20                             LD      L,20h   ; ' '
E49F: 61                                LD      H,C
E4A0: 70                                LD      (HL),B
E4A1: 72                                LD      (HL),D
E4A2: 2F                                CPL
E4A3: 38 32                             JR      C,LE4D7
E4A5: 0D                                DEC     C
E4A6: 8A                                ADC     A,D
                                        ; --- START PROC LE4A7 ---
E4A7: EB                         LE4A7: EX      DE,HL
E4A8: 21 88 BB                          LD      HL,0BB88h
E4AB: 1A                                LD      A,(DE)
E4AC: BE                                CP      (HL)
E4AD: C0                                RET     NZ
E4AE: 13                                INC     DE
E4AF: 23                                INC     HL
E4B0: 1A                                LD      A,(DE)
E4B1: BE                                CP      (HL)
E4B2: C9                                RET

                                        ; --- START PROC LE4B3 ---
E4B3: CD 17 E6                   LE4B3: CALL    LE617
E4B6: CD 28 E5                          CALL    LE528
E4B9: CD 8B E5                          CALL    LE58B
E4BC: 3A 54 BA                          LD      A,(0BA54h)
E4BF: F5                                PUSH    AF
E4C0: CD 0F E8                   LE4C0: CALL    RIG_WRITESECTOR
E4C3: C2 E3 E4                          JP      NZ,LE4E3
E4C6: 2A EA BF                          LD      HL,(0BFEAh)
E4C9: E5                                PUSH    HL
E4CA: 21 00 FE                   LE4CA: LD      HL,0FE00h
E4CD: 22 EA BF                          LD      (0BFEAh),HL
E4D0: CD 12 E8                          CALL    RIG_READSECTOR
E4D3: E1                         LE4D3: POP     HL
E4D4: 22 EA BF                          LD      (0BFEAh),HL
E4D7: CA EC E4                   LE4D7: JP      Z,LE4EC
E4DA: F1                                POP     AF
E4DB: 3D                                DEC     A
E4DC: CA E4 E4                          JP      Z,LE4E4
E4DF: F5                                PUSH    AF
E4E0: C3 C0 E4                          JP      LE4C0

E4E3: F1                         LE4E3: POP     AF
E4E4: 3E FF                      LE4E4: LD      A,0FFh
E4E6: 32 A3 BB                          LD      (0BBA3h),A
E4E9: C3 F2 E4                          JP      LE4F2

E4EC: F1                         LE4EC: POP     AF
E4ED: 3E 00                             LD      A,00h
E4EF: 32 A3 BB                          LD      (0BBA3h),A
E4F2: CD 8B E5                   LE4F2: CALL    LE58B
E4F5: C3 07 E5                          JP      LE507

                                        ; --- START PROC LE4F8 ---
E4F8: CD 17 E6                   LE4F8: CALL    LE617
E4FB: CD 28 E5                          CALL    LE528
E4FE: CD 12 E8                          CALL    RIG_READSECTOR
E501: 32 A3 BB                          LD      (0BBA3h),A
E504: CD 8B E5                          CALL    LE58B
                                        ; --- START PROC LE507 ---
E507: CD 2F E6                   LE507: CALL    LE62F
E50A: C9                                RET

                                        ; --- START PROC LE50B ---
E50B: 3A 87 BB                   LE50B: LD      A,(0BB87h)
E50E: FD 21 82 BB                       LD      IY,0BB82h
E512: 21 AC BB                          LD      HL,0BBACh
E515: 22 EA BF                          LD      (0BFEAh),HL
                                        ; --- START PROC LE518 ---
E518: 21 61 BA                   LE518: LD      HL,0BA61h
E51B: 5F                                LD      E,A
E51C: 16 00                             LD      D,00h
E51E: 19                                ADD     HL,DE
E51F: 19                                ADD     HL,DE
E520: 5E                                LD      E,(HL)
E521: 23                                INC     HL
E522: 56                                LD      D,(HL)
E523: ED 53 82 BB                       LD      (0BB82h),DE
E527: C9                                RET

                                        ; --- START PROC LE528 ---
E528: 3A 8F BB                   LE528: LD      A,(0BB8Fh)
E52B: 4F                                LD      C,A
E52C: 3A 8E BB                          LD      A,(0BB8Eh)
E52F: CD 18 E5                          CALL    LE518
E532: 7A                                LD      A,D
E533: B7                                OR      A
E534: CA 42 E5                          JP      Z,LE542
E537: 81                                ADD     A,C
E538: FA 42 E5                          JP      M,LE542
E53B: FD 86 01                          ADD     A,(IY+01h)
E53E: 2F                                CPL
E53F: 4F                                LD      C,A
E540: CB C3                             SET     0,E
E542: 51                         LE542: LD      D,C
E543: D5                                PUSH    DE
E544: 7B                                LD      A,E
E545: 4F                                LD      C,A
E546: DD BE 09                          CP      (IX+IX_CURRDRIVE)
E549: 32 E9 BF                          LD      (0BFE9h),A
E54C: C4 09 E8                          CALL    NZ,RIG_SETDRIVE
E54F: C1                                POP     BC
E550: 3E C0                             LD      A,0C0h
E552: A1                                AND     C
E553: FE 80                             CP      80h
E555: 3A 91 BB                          LD      A,(0BB91h)
E558: 4F                                LD      C,A
E559: C2 7A E5                          JP      NZ,LE57A
E55C: C5                                PUSH    BC
E55D: 78                                LD      A,B
E55E: 58                                LD      E,B
E55F: 16 00                             LD      D,00h
E561: 21 00 00                          LD      HL,0000h
E564: 06 1A                             LD      B,1Ah
E566: B7                                OR      A
E567: CA 6D E5                          JP      Z,LE56D
E56A: 19                         LE56A: ADD     HL,DE
E56B: 10 FD                             DJNZ    LE56A
E56D: C1                         LE56D: POP     BC
E56E: 59                                LD      E,C
E56F: 19                                ADD     HL,DE
E570: 2B                                DEC     HL
E571: 7D                                LD      A,L
E572: E6 0F                             AND     0Fh
E574: 4F                                LD      C,A
E575: 29                                ADD     HL,HL
E576: 29                                ADD     HL,HL
E577: 29                                ADD     HL,HL
E578: 29                                ADD     HL,HL
E579: 44                                LD      B,H
E57A: C5                         LE57A: PUSH    BC
E57B: CD 06 E8                          CALL    RIG_SETSECTOR
E57E: C1                                POP     BC
E57F: 78                                LD      A,B
E580: 4F                                LD      C,A
E581: DD BE 0C                          CP      (IX+0Ch)
E584: 32 EC BF                          LD      (0BFECh),A
E587: C4 03 E8                          CALL    NZ,RIG_SETTRACK
E58A: C9                                RET

                                        ; --- START PROC LE58B ---
E58B: 3A E9 BF                   LE58B: LD      A,(0BFE9h)
E58E: E6 C0                             AND     0C0h
E590: FE C0                             CP      0C0h
E592: C0                                RET     NZ
E593: 21 AC BB                          LD      HL,0BBACh
E596: 06 80                             LD      B,80h
E598: 7E                         LE598: LD      A,(HL)
E599: 2F                                CPL
E59A: 77                                LD      (HL),A
E59B: 23                                INC     HL
E59C: 10 FA                             DJNZ    LE598
E59E: C9                                RET

E59F: CD 17 E6                   LE59F: CALL    LE617
E5A2: 3A 03 00                          LD      A,(0003h)
E5A5: E6 03                             AND     03h
E5A7: FE 01                             CP      01h
E5A9: CA B8 E5                          JP      Z,LE5B8
E5AC: FE 02                             CP      02h
E5AE: CA E0 E5                          JP      Z,LE5E0
E5B1: 79                         LE5B1: LD      A,C
E5B2: CD 03 E0                          CALL    LE003
E5B5: C3 07 E5                          JP      LE507

E5B8: AF                         LE5B8: XOR     A
E5B9: D3 7A                             OUT     (7Ah),A ; 'z'
E5BB: DB 7A                             IN      A,(7Ah) ; 'z'
E5BD: E6 04                             AND     04h
E5BF: CA B8 E5                          JP      Z,LE5B8
E5C2: 79                                LD      A,C
E5C3: D3 78                             OUT     (78h),A ; 'x'
E5C5: C3 07 E5                          JP      LE507

E5C8: CD 17 E6                   LE5C8: CALL    LE617
E5CB: 3A 03 00                          LD      A,(0003h)
E5CE: E6 C0                             AND     0C0h
E5D0: CA E0 E5                          JP      Z,LE5E0
E5D3: FE 40                             CP      40h     ; '@'
E5D5: CA B8 E5                          JP      Z,LE5B8
E5D8: FE 80                             CP      80h
E5DA: CA E0 E5                          JP      Z,LE5E0
E5DD: C3 B1 E5                          JP      LE5B1

E5E0: 79                         LE5E0: LD      A,C
E5E1: CD 0C E0                          CALL    LE00C
E5E4: C3 07 E5                          JP      LE507

E5E7: 3A 03 00                   LE5E7: LD      A,(0003h)
E5EA: E6 C0                             AND     0C0h
E5EC: CA FD E5                          JP      Z,LE5FD
E5EF: FE 40                             CP      40h     ; '@'
E5F1: CA 54 BB                          JP      Z,0BB54h
E5F4: FE 80                             CP      80h
E5F6: CA FD E5                          JP      Z,LE5FD
E5F9: AF                                XOR     A
E5FA: C3 0E E6                          JP      LE60E

E5FD: DB 5D                      LE5FD: IN      A,(5Dh) ; ']'
E5FF: 07                                RLCA
E600: 07                                RLCA
E601: FD 21 E0 FF                       LD      IY,0FFE0h
E605: 47                                LD      B,A
E606: FD 7E 06                          LD      A,(IY+06h)
E609: EE 04                             XOR     04h
E60B: A0                                AND     B
E60C: E6 C0                             AND     0C0h
E60E: 2F                         LE60E: CPL
E60F: C3 40 BB                          JP      0BB40h

E612: 79                         LE612: LD      A,C
E613: C9                                RET

E614: 3E 1A                      LE614: LD      A,1Ah
E616: C9                                RET

                                        ; --- START PROC LE617 ---
E617: ED 73 D0 BF                LE617: LD      (0BFD0h),SP
E61B: 22 D2 BF                          LD      (0BFD2h),HL
E61E: ED 53 D4 BF                       LD      (0BFD4h),DE
E622: ED 43 D6 BF                       LD      (0BFD6h),BC
E626: 32 D8 BF                          LD      (0BFD8h),A
E629: D1                                POP     DE
E62A: 31 D0 BF                          LD      SP,0BFD0h
E62D: D5                                PUSH    DE
E62E: C9                                RET

                                        ; --- START PROC LE62F ---
E62F: E1                         LE62F: POP     HL
E630: ED 7B D0 BF                       LD      SP,(0BFD0h)
E634: E3                                EX      (SP),HL
E635: ED 4B D6 BF                       LD      BC,(0BFD6h)
E639: ED 5B D4 BF                       LD      DE,(0BFD4h)
E63D: 2A D2 BF                          LD      HL,(0BFD2h)
E640: C9                                RET

E641: 01 00 00                   LE641: LD      BC,0000h
E644: CD 77 E6                          CALL    LE677
E647: 01 00 00                          LD      BC,0000h
E64A: CD 7D E6                          CALL    LE67D
E64D: 3A 97 BB                          LD      A,(0BB97h)
E650: B7                                OR      A
E651: C2 57 E6                          JP      NZ,LE657
E654: 32 96 BB                          LD      (0BB96h),A
E657: C9                         LE657: RET

E658: 21 00 00                   LE658: LD      HL,0000h
E65B: 79                                LD      A,C
E65C: 32 DC BF                          LD      (0BFDCh),A
E65F: 32 87 BB                          LD      (0BB87h),A
E662: FE 02                             CP      02h
E664: C8                                RET     Z
E665: FE 05                             CP      05h
E667: D0                                RET     NC
E668: 3A DC BF                          LD      A,(0BFDCh)
E66B: 6F                                LD      L,A
E66C: 26 00                             LD      H,00h
E66E: 29                                ADD     HL,HL
E66F: 29                                ADD     HL,HL
E670: 29                                ADD     HL,HL
E671: 29                                ADD     HL,HL
E672: 11 6B BA                          LD      DE,0BA6Bh
E675: 19                                ADD     HL,DE
E676: C9                                RET

                                        ; --- START PROC LE677 ---
E677: 60                         LE677: LD      H,B
E678: 69                                LD      L,C
E679: 22 88 BB                          LD      (0BB88h),HL
E67C: C9                                RET

                                        ; --- START PROC LE67D ---
E67D: 60                         LE67D: LD      H,B
E67E: 69                                LD      L,C
E67F: 22 8A BB                          LD      (0BB8Ah),HL
E682: C9                                RET

E683: 7A                         LE683: LD      A,D
E684: B7                                OR      A
E685: CA 8E E6                          JP      Z,LE68E
E688: EB                                EX      DE,HL
E689: 09                                ADD     HL,BC
E68A: 6E                                LD      L,(HL)
E68B: 26 00                             LD      H,00h
E68D: C9                                RET

E68E: 69                         LE68E: LD      L,C
E68F: 60                                LD      H,B
E690: C9                                RET

                                        ; --- START PROC LE691 ---
E691: 60                         LE691: LD      H,B
E692: 69                                LD      L,C
E693: 22 A7 BB                          LD      (0BBA7h),HL
E696: C9                                RET

E697: CD 0B E5                   LE697: CALL    LE50B
E69A: AF                                XOR     A
E69B: 32 9B BB                          LD      (0BB9Bh),A
E69E: 3E 01                             LD      A,01h
E6A0: 32 A5 BB                          LD      (0BBA5h),A
E6A3: 32 A4 BB                          LD      (0BBA4h),A
E6A6: 3E 02                             LD      A,02h
E6A8: 32 A6 BB                          LD      (0BBA6h),A
E6AB: C3 23 E7                          JP      LE723

E6AE: CD 0B E5                   LE6AE: CALL    LE50B
E6B1: AF                                XOR     A
E6B2: 32 A5 BB                          LD      (0BBA5h),A
E6B5: 79                                LD      A,C
E6B6: 32 A6 BB                          LD      (0BBA6h),A
E6B9: FE 02                             CP      02h
E6BB: C2 D5 E6                          JP      NZ,LE6D5
E6BE: 3E 08                             LD      A,08h
E6C0: 32 9B BB                          LD      (0BB9Bh),A
E6C3: 3A 87 BB                          LD      A,(0BB87h)
E6C6: 32 9C BB                          LD      (0BB9Ch),A
E6C9: 2A 88 BB                          LD      HL,(0BB88h)
E6CC: 22 9D BB                          LD      (0BB9Dh),HL
E6CF: 3A 8A BB                          LD      A,(0BB8Ah)
E6D2: 32 9F BB                          LD      (0BB9Fh),A
E6D5: 3A 9B BB                   LE6D5: LD      A,(0BB9Bh)
E6D8: B7                                OR      A
E6D9: CA 14 E7                          JP      Z,LE714
E6DC: 3D                                DEC     A
E6DD: 32 9B BB                          LD      (0BB9Bh),A
E6E0: 3A 87 BB                          LD      A,(0BB87h)
E6E3: 21 9C BB                          LD      HL,0BB9Ch
E6E6: BE                                CP      (HL)
E6E7: C2 14 E7                          JP      NZ,LE714
E6EA: 21 9D BB                          LD      HL,0BB9Dh
E6ED: CD A7 E4                          CALL    LE4A7
E6F0: C2 14 E7                          JP      NZ,LE714
E6F3: 3A 8A BB                          LD      A,(0BB8Ah)
E6F6: 21 9F BB                          LD      HL,0BB9Fh
E6F9: BE                                CP      (HL)
E6FA: C2 14 E7                          JP      NZ,LE714
E6FD: 34                                INC     (HL)
E6FE: 7E                                LD      A,(HL)
E6FF: FE 10                             CP      10h
E701: DA 0D E7                          JP      C,LE70D
E704: 36 00                             LD      (HL),00h
E706: 2A 9D BB                          LD      HL,(0BB9Dh)
E709: 23                                INC     HL
E70A: 22 9D BB                          LD      (0BB9Dh),HL
E70D: AF                         LE70D: XOR     A
E70E: 32 A4 BB                          LD      (0BBA4h),A
E711: C3 23 E7                          JP      LE723

E714: AF                         LE714: XOR     A
E715: 32 9B BB                          LD      (0BB9Bh),A
E718: FD CB 00 7E                       BIT     7,(IY+00h)
E71C: C2 20 E7                          JP      NZ,LE720
E71F: 3C                                INC     A
E720: 32 A4 BB                   LE720: LD      (0BBA4h),A
E723: AF                         LE723: XOR     A
E724: 32 A3 BB                          LD      (0BBA3h),A
E727: 2A 8A BB                          LD      HL,(0BB8Ah)
E72A: 7D                                LD      A,L
E72B: FD CB 00 7E                       BIT     7,(IY+00h)
E72F: C2 3A E7                          JP      NZ,LE73A
E732: 29                                ADD     HL,HL
E733: 29                                ADD     HL,HL
E734: 29                                ADD     HL,HL
E735: 29                                ADD     HL,HL
E736: 29                                ADD     HL,HL
E737: 29                                ADD     HL,HL
E738: 29                                ADD     HL,HL
E739: 7C                                LD      A,H
E73A: 32 95 BB                   LE73A: LD      (0BB95h),A
E73D: 21 96 BB                          LD      HL,0BB96h
E740: 7E                                LD      A,(HL)
E741: 36 01                             LD      (HL),01h
E743: B7                                OR      A
E744: CA 6B E7                          JP      Z,LE76B
E747: 3A 87 BB                          LD      A,(0BB87h)
E74A: 21 8E BB                          LD      HL,0BB8Eh
E74D: BE                                CP      (HL)
E74E: C2 64 E7                          JP      NZ,LE764
E751: 21 8F BB                          LD      HL,0BB8Fh
E754: CD A7 E4                          CALL    LE4A7
E757: C2 64 E7                          JP      NZ,LE764
E75A: 3A 95 BB                          LD      A,(0BB95h)
E75D: 21 91 BB                          LD      HL,0BB91h
E760: BE                                CP      (HL)
E761: CA 88 E7                          JP      Z,LE788
E764: 3A 97 BB                   LE764: LD      A,(0BB97h)
E767: B7                                OR      A
E768: C4 B3 E4                          CALL    NZ,LE4B3
E76B: 3A 87 BB                   LE76B: LD      A,(0BB87h)
E76E: 32 8E BB                          LD      (0BB8Eh),A
E771: 2A 88 BB                          LD      HL,(0BB88h)
E774: 22 8F BB                          LD      (0BB8Fh),HL
E777: 3A 95 BB                          LD      A,(0BB95h)
E77A: 32 91 BB                          LD      (0BB91h),A
E77D: 3A A4 BB                          LD      A,(0BBA4h)
E780: B7                                OR      A
E781: C4 F8 E4                          CALL    NZ,LE4F8
E784: AF                                XOR     A
E785: 32 97 BB                          LD      (0BB97h),A
E788: 11 AC BB                   LE788: LD      DE,0BBACh
E78B: FD CB 00 7E                       BIT     7,(IY+00h)
E78F: C2 A3 E7                          JP      NZ,LE7A3
E792: 3A 8A BB                          LD      A,(0BB8Ah)
E795: E6 01                             AND     01h
E797: 6F                                LD      L,A
E798: 26 00                             LD      H,00h
E79A: 29                                ADD     HL,HL
E79B: 29                                ADD     HL,HL
E79C: 29                                ADD     HL,HL
E79D: 29                                ADD     HL,HL
E79E: 29                                ADD     HL,HL
E79F: 29                                ADD     HL,HL
E7A0: 29                                ADD     HL,HL
E7A1: 19                                ADD     HL,DE
E7A2: EB                                EX      DE,HL
E7A3: 2A A7 BB                   LE7A3: LD      HL,(0BBA7h)
E7A6: 0E 80                             LD      C,80h
E7A8: 3A A5 BB                          LD      A,(0BBA5h)
E7AB: B7                                OR      A
E7AC: C2 B5 E7                          JP      NZ,LE7B5
E7AF: 3E 01                             LD      A,01h
E7B1: 32 97 BB                          LD      (0BB97h),A
E7B4: EB                                EX      DE,HL
E7B5: 1A                         LE7B5: LD      A,(DE)
E7B6: 13                                INC     DE
E7B7: 77                                LD      (HL),A
E7B8: 23                                INC     HL
E7B9: 0D                                DEC     C
E7BA: C2 B5 E7                          JP      NZ,LE7B5
E7BD: 3A A6 BB                          LD      A,(0BBA6h)
E7C0: FE 01                             CP      01h
E7C2: 3A A3 BB                          LD      A,(0BBA3h)
E7C5: C0                                RET     NZ
E7C6: B7                                OR      A
E7C7: C0                                RET     NZ
E7C8: AF                                XOR     A
E7C9: 32 97 BB                          LD      (0BB97h),A
E7CC: CD B3 E4                          CALL    LE4B3
E7CF: 3A A3 BB                          LD      A,(0BBA3h)
E7D2: C9                                RET

E7D3: 09                         LE7D3: ADD     HL,BC
E7D4: 30 63                             JR      NC,LE837+2      ; reference not aligned to instruction
E7D6: 30 68                             JR      NC,LE840
E7D8: 0D                                DEC     C
E7D9: 0A                                LD      A,(BC)
E7DA: 09                                ADD     HL,BC
E7DB: 72                                LD      (HL),D
E7DC: 6E                                LD      L,(HL)
E7DD: 7A                                LD      A,D
E7DE: 09                                ADD     HL,BC
E7DF: 09                                ADD     HL,BC
E7E0: 3B                                DEC     SP
E7E1: 73                                LD      (HL),E
E7E2: 65                                LD      H,L
E7E3: 20 6E                             JR      NZ,LE852+1      ; reference not aligned to instruction
E7E5: 6F                                LD      L,A
E7E6: 2C                                INC     L
E7E7: 20 72                             JR      NZ,LE85A+1      ; reference not aligned to instruction
E7E9: 69                                LD      L,C
E7EA: 74                                LD      (HL),H
E7EB: 6F                                LD      L,A
E7EC: 72                                LD      (HL),D
E7ED: 6E                                LD      L,(HL)
E7EE: 61                                LD      H,C
E7EF: 0D                                DEC     C
E7F0: 0A                                LD      A,(BC)
E7F1: 3B                                DEC     SP
E7F2: 20 63                             JR      NZ,LE857
E7F4: 69                                LD      L,C
E7F5: 63                                LD      H,E
E7F6: 6C                                LD      L,H
E7F7: 6F                                LD      L,A
E7F8: 20 64                             JR      NZ,LE85D+1      ; reference not aligned to instruction
E7FA: 69                                LD      L,C
E7FB: 20 69                             JR      NZ,LE863+3      ; reference not aligned to instruction
E7FD: 6E                                LD      L,(HL)
E7FE: 76                                HALT
E7FF: 65                                LD      H,L


;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************

E800: C3 30 E8                   RIG_INITD:               JP      RIG_INITD1
E803: C3 E3 E8                   RIG_SETTRACK:            JP      RIG_SETTRACK1
E806: C3 17 E9                   RIG_SETSECTOR:           JP      RIG_SETSECTOR1
E809: C3 27 E9                   RIG_SETDRIVE:            JP      RIG_SETDRIVE1
E80C: C3 93 E9                   RIG_SETDMA:              JP      RIG_SETDMA1
E80F: C3 9D E9                   RIG_WRITESECTOR:         JP      RIG_WRITESECTOR1
E812: C3 A3 EA                   RIG_READSECTOR:          JP      RIG_READSECTOR1
E815: C3 6F EB                   BOOT_UNIT_20_0:          JP      BOOT_UNIT20
E818: C3 17 EB                   BOOT_FROM_SA0:           JP      BOOT_FROM_SA
E81B: C3 CB E8                   SA_WRITE_DATA_BYTES0:    JP      SA_WRITE_DATABYTES
E81E: C3 00 00                   COLD_BOOT:               JP      0000h
E821: C3 50 E8                   SA_CONTROLLER_RESET0:    JP      SA_CONTROLLER_RESET
E824: C3 74 E8                   SA_SEND_CMD0:            JP      SA_SEND_CMD
E827: C3 74 EB                   RIG_SET_IX_STATUS:       JP      RIG_SET_IX_STATUS1
E82A: C3 78 EB                   RIG_SET_IX_STATUS_READ:  JP      RIG_SET_IX_STATUS_READ1
E82D: C3 7C EB                   RIG_SET_IX_STATUS_WRITE: JP      RIG_SET_IX_STATUS_WRITE1

;**************************************************************************
                                 RIG_INITD1:
E830: CD 27 E8                          CALL    RIG_SET_IX_STATUS
E833: DD 36 0C 00                       LD      (IX+0Ch),00h
E837: DD CB 09 6E                LE837: BIT     5,(IX+IX_CURRDRIVE)
E83B: C0                                RET     NZ
E83C: DD CB 09 5E                LE83C: BIT     3,(IX+IX_CURRDRIVE)
E840: 28 04                      LE840: JR      Z,LE846
E842: 3E FB                             LD      A,0FBh
E844: 18 02                             JR      LE848

E846: 3E F0                      LE846: LD      A,0F0h
E848: D3 BC                      LE848: OUT     (FDCCMD),A
E84A: CD 8A EB                          CALL    LEB8A
E84D: C8                                RET     Z
E84E: 18 EC                             JR      LE83C

;**************************************************************************
                                 SA_CONTROLLER_RESET:

E850: 3E FB                             LD      A,SA_OUT_PIN_RESET
E852: D3 6D                      LE852: OUT     (SA_CTRL_PORT),A    ; assert RES
E854: C9                                RET

;**************************************************************************
                                 SA_SEND_COMMAND_TESTDRIVE:

E855: 3E FF                             LD      A,0FFh
E857: DD 77 18                   LE857: LD      (IX+18h),A
E85A: DD 77 19                   LE85A: LD      (IX+19h),A
E85D: DD 77 1A                   LE85D: LD      (IX+1Ah),A
E860: DD 77 1B                          LD      (IX+1Bh),A
E863: DD 36 16 FE                LE863: LD      (IX+16h),0FEh
E867: DD 36 17 DF                       LD      (IX+17h),0DFh
E86B: 06 06                             LD      B,06h
E86D: CD 24 E8                          CALL    SA_SEND_CMD0
E870: CD 96 E8                          CALL    SA_READ_STATUS_BYTE
E873: C9                                RET

;**************************************************************************
; send command bytes to SA controller
; B=numbero of bytes (usually 6)
; ?controller must be selected first
;
                                 SA_SEND_CMD:
E874: DD E5                             PUSH    IX
E876: E1                                POP     HL
E877: 2E F6                             LD      L,0F6h              ; HL = BFF6 points to command bytes buffer (IX+16h)

E879: 0E 6C                             LD      C,SA_DATA_PORT      ; sets ports for sending command bytes

E87B: DB 6D                      LE87B: IN      A,(SA_CTRL_PORT)    ;
E87D: CB 47                             BIT     0,A                 ;
E87F: 28 FA                             JR      Z,LE87B             ; wait until not BSY (bus free)

E881: 3E FC                      LE881: LD      A,0FCh
E883: D3 6D                             OUT     (SA_CTRL_PORT),A    ; assert SEL,B0
E885: DB 6D                             IN      A,(SA_CTRL_PORT)
E887: CB 47                             BIT     0,A
E889: 20 F6                             JR      NZ,LE881            ; loop if not BSY

E88B: DB 6D                      LE88B: IN      A,(SA_CTRL_PORT)
E88D: E6 1F                             AND     1Fh                 ; mask all bits
E88F: FE 12                             CP      12h                 ; check for -IO +REQ +CD -MESSAGE +BSY
E891: 20 F8                             JR      NZ,LE88B
E893: ED B3                             OTIR
E895: C9                                RET

;**************************************************************************
; read status byte and completion message from controller
; exit with condition NZ if error, Z if ok
; if the message byte is not 0 => error
; else the error condition is in bit 1 of status byte
;
                                 SA_READ_STATUS_BYTE:
E896: DB 6D                             IN      A,(SA_CTRL_PORT)
E898: E6 1F                             AND     1Fh                     ; mask all bits
E89A: FE 02                             CP      02h                     ; check for +IO +REQ +CD -MESSAGE +BSY
E89C: 20 F8                             JR      NZ,SA_READ_STATUS_BYTE

E89E: DB 6C                             IN      A,(SA_DATA_PORT)        ; get status byte
E8A0: 2F                                CPL                             ; fix negated logic
E8A1: 47                                LD      B,A                     ; save into B

E8A2: DB 6D                             IN      A,(SA_CTRL_PORT)
E8A4: E6 17                             AND     17h                     ; mask IO CD MESSAGE BSY
E8A6: FE 00                             CP      00h                     ; check for +IO ?REQ +CD +MESSAGE +BSY
E8A8: C0                                RET     NZ                      ; check for error NZ=error

E8A9: 00                                NOP
E8AA: DB 6C                             IN      A,(SA_DATA_PORT)        ; read message
E8AC: FE FF                             CP      0FFh                    ; is it 0 ?
E8AE: C0                                RET     NZ                      ; no, it's error, NZ=error
E8AF: AF                                XOR     A
E8B0: CB 48                             BIT     1,B                     ; status byte bit 1 indicates error, 1=NZ=error
E8B2: C9                                RET

;**************************************************************************
;read data bytes from controller. B=number of bytes to read
                                 SA_READ_DATABYTES:
E8B3: DD 6E 0A                          LD      L,(IX+IX_DSKBUFPTR+0)
E8B6: DD 66 0B                          LD      H,(IX+IX_DSKBUFPTR+1)
                                        ; --- START PROC LE8B9 ---
E8B9: 0E 6C                      LE8B9: LD      C,6Ch   ; 'l'
E8BB: DB 6D                      LE8BB: IN      A,(SA_CTRL_PORT) ; 'm'
E8BD: E6 1F                             AND     1Fh
E8BF: FE 02                             CP      02h
E8C1: CA 96 E8                          JP      Z,SA_READ_STATUS_BYTE
E8C4: FE 06                             CP      06h
E8C6: 20 F3                             JR      NZ,LE8BB
E8C8: ED B2                             INIR
E8CA: C9                                RET

;**************************************************************************
;write data bytes to controller. B=number of bytes to write
                                 SA_WRITE_DATABYTES:
E8CB: DD 6E 0A                          LD      L,(IX+IX_DSKBUFPTR+0)
E8CE: DD 66 0B                          LD      H,(IX+IX_DSKBUFPTR+1)
E8D1: 0E 6C                             LD      C,6Ch   ; 'l'
E8D3: DB 6D                      LE8D3: IN      A,(SA_CTRL_PORT) ; 'm'
E8D5: E6 1F                             AND     1Fh
E8D7: FE 02                             CP      02h
E8D9: CA 96 E8                          JP      Z,SA_READ_STATUS_BYTE
E8DC: FE 16                             CP      16h
E8DE: 20 F3                             JR      NZ,LE8D3
E8E0: ED B3                             OTIR
E8E2: C9                                RET

;**************************************************************************
;generic disk op
                                        ; --- START PROC RIG_SETTRACK1 ---
E8E3: CD 27 E8                   RIG_SETTRACK1: CALL    RIG_SET_IX_STATUS
E8E6: DD 71 0C                          LD      (IX+0Ch),C
E8E9: DD CB 09 6E                       BIT     5,(IX+IX_CURRDRIVE)
E8ED: C0                                RET     NZ
E8EE: DD 7E 0C                   LE8EE: LD      A,(IX+0Ch)
E8F1: 2F                                CPL
E8F2: D3 BF                             OUT     (0BFh),A
E8F4: DD CB 09 5E                       BIT     3,(IX+IX_CURRDRIVE)
E8F8: 28 04                             JR      Z,LE8FE
E8FA: 3E EB                             LD      A,0EBh
E8FC: 18 02                             JR      LE900
E8FE: 3E E0                      LE8FE: LD      A,0E0h
E900: D3 BC                      LE900: OUT     (FDCCMD),A
E902: CD 8A EB                          CALL    LEB8A
E905: 20 07                             JR      NZ,LE90E
E907: DD 7E 0C                          LD      A,(IX+0Ch)
E90A: 2F                                CPL
E90B: D3 BD                             OUT     (0BDh),A
E90D: C9                                RET
E90E: 3E F3                      LE90E: LD      A,0F3h
E910: D3 BC                             OUT     (FDCCMD),A
E912: CD F4 EB                          CALL    LEBF4
E915: 18 D7                             JR      LE8EE

;**************************************************************************
;generic disk op
                                        ; --- START PROC RIG_SETSECTOR1 ---
E917: CD 27 E8                   RIG_SETSECTOR1: CALL    RIG_SET_IX_STATUS
E91A: DD 71 0E                          LD      (IX+0Eh),C
E91D: DD CB 09 6E                       BIT     5,(IX+IX_CURRDRIVE)
E921: C0                                RET     NZ
E922: 79                                LD      A,C
E923: 2F                                CPL
E924: D3 BE                             OUT     (0BEh),A
E926: C9                                RET

;**************************************************************************
;generic disk op
                                        ; --- START PROC RIG_SETDRIVE1 ---
E927: CD 27 E8                   RIG_SETDRIVE1: CALL    RIG_SET_IX_STATUS
E92A: CB 69                             BIT     5,C
E92C: 28 04                             JR      Z,LE932
E92E: DD 71 09                          LD      (IX+IX_CURRDRIVE),C
E931: C9                                RET
E932: DD 71 09                   LE932: LD      (IX+IX_CURRDRIVE),C
E935: CD 78 E9                          CALL    LE978
E938: D3 3F                             OUT     (3Fh),A ; '?'
E93A: CD 2A E8                          CALL    RIG_SET_IX_STATUS_READ

;**************************************************************************
;generic disk op
E93D: DD E5                      LE93D: PUSH    IX
E93F: E1                                POP     HL
E940: 2E F6                             LD      L,0F6h
E942: 0E BF                             LD      C,0BFh
E944: 3E 3B                             LD      A,3Bh   ; ';'
E946: D3 BC                             OUT     (FDCCMD),A
E948: CD 5E E9                          CALL    LE95E
E94B: 20 F0                             JR      NZ,LE93D
E94D: FE 00                             CP      00h
E94F: C2 00 E8                          JP      NZ,RIG_INITD
E952: DD 7E 16                          LD      A,(IX+16h)
E955: D3 BD                             OUT     (0BDh),A
E957: 2F                                CPL
E958: DD 77 0C                          LD      (IX+0Ch),A
E95B: C9                                RET

;**************************************************************************
;generic disk op
                                        ; --- START PROC LE95C ---
E95C: ED A2                      LE95C: INI
                                        ; --- START PROC LE95E ---
E95E: DB 3F                      LE95E: IN      A,(3Fh) ; '?'
E960: 07                                RLCA
E961: 38 F9                             JR      C,LE95C
E963: DB 3F                             IN      A,(3Fh) ; '?'
E965: 07                                RLCA
E966: 38 F4                             JR      C,LE95C
E968: DB 3F                             IN      A,(3Fh) ; '?'
E96A: 07                                RLCA
E96B: 38 EF                             JR      C,LE95C
E96D: DB 3F                             IN      A,(3Fh) ; '?'
E96F: 07                                RLCA
E970: 38 EA                             JR      C,LE95C
E972: 07                                RLCA
E973: 30 E9                             JR      NC,LE95E
E975: C3 8A EB                          JP      LEB8A

;**************************************************************************

                                        ; --- START PROC LE978 ---
E978: 79                         LE978: LD      A,C
E979: E6 07                             AND     07h
E97B: 1F                                RRA
E97C: F6 FC                             OR      0FCh
E97E: CB 41                             BIT     0,C
E980: 28 02                             JR      Z,LE984
E982: CB 9F                             RES     3,A
E984: CB 79                      LE984: BIT     7,C
E986: 20 02                             JR      NZ,LE98A
E988: CB B7                             RES     6,A
E98A: CB 71                      LE98A: BIT     6,C
E98C: 20 02                             JR      NZ,LE990
E98E: CB A7                             RES     4,A
E990: CB BF                      LE990: RES     7,A
E992: C9                                RET

;**************************************************************************
;set buffer in HL
                                        ; --- START PROC RIG_SETDMA1 ---
E993: CD 27 E8                   RIG_SETDMA1: CALL    RIG_SET_IX_STATUS
E996: DD 75 0A                          LD      (IX+IX_DSKBUFPTR+0),L
E999: DD 74 0B                          LD      (IX+IX_DSKBUFPTR+1),H
E99C: C9                                RET

                                        ; --- START PROC RIG_WRITESECTOR1 ---
E99D: CD 2D E8                   RIG_WRITESECTOR1: CALL    RIG_SET_IX_STATUS_WRITE
E9A0: DD CB 09 6E                       BIT     5,(IX+IX_CURRDRIVE)
E9A4: 28 51                             JR      Z,LE9F7
E9A6: DD 36 11 05                       LD      (IX+IX_RETRYCOUNT),05h
E9AA: DD 36 16 F5                LE9AA: LD      (IX+16h),0F5h
E9AE: 3E FF                             LD      A,0FFh
E9B0: DD CB 09 46                       BIT     0,(IX+IX_CURRDRIVE)
E9B4: 28 02                             JR      Z,LE9B8
E9B6: CB AF                             RES     5,A
E9B8: DD CB 09 4E                LE9B8: BIT     1,(IX+IX_CURRDRIVE)
E9BC: 28 02                             JR      Z,LE9C0
E9BE: CB B7                             RES     6,A
E9C0: DD 77 17                   LE9C0: LD      (IX+17h),A
E9C3: DD 7E 0C                          LD      A,(IX+0Ch)
E9C6: 2F                                CPL
E9C7: DD 77 18                          LD      (IX+18h),A
E9CA: DD 7E 0E                          LD      A,(IX+0Eh)
E9CD: 2F                                CPL
E9CE: DD 77 19                          LD      (IX+19h),A
E9D1: DD 36 1A FE                       LD      (IX+1Ah),0FEh
E9D5: DD 36 1B FF                       LD      (IX+1Bh),0FFh
E9D9: 06 06                             LD      B,06h
E9DB: CD 24 E8                          CALL    SA_SEND_CMD0
E9DE: 20 0C                             JR      NZ,LE9EC
E9E0: 06 00                             LD      B,00h
E9E2: CD 1B E8                          CALL    SA_WRITE_DATA_BYTES0
E9E5: CC 96 E8                          CALL    Z,SA_READ_STATUS_BYTE
E9E8: C8                                RET     Z
E9E9: CD 33 EA                          CALL    SA_COMMAND_REQUEST_SENSE
E9EC: CD 50 E8                   LE9EC: CALL    SA_CONTROLLER_RESET
E9EF: DD 35 11                          DEC     (IX+IX_RETRYCOUNT)
E9F2: 20 B6                             JR      NZ,LE9AA
E9F4: AF                                XOR     A
E9F5: 3C                                INC     A
E9F6: C9                                RET

;**************************************************************************
;generic disk op
E9F7: 0E BF                      LE9F7: LD      C,0BFh
E9F9: DD 6E 0A                          LD      L,(IX+IX_DSKBUFPTR+0)
E9FC: DD 66 0B                          LD      H,(IX+IX_DSKBUFPTR+1)
E9FF: 3E 5F                             LD      A,5Fh   ; '_'
EA01: D3 BC                             OUT     (FDCCMD),A
EA03: 18 02                             JR      LEA07
EA05: ED A3                      LEA05: OUTI
EA07: DB 3F                      LEA07: IN      A,(3Fh) ; '?'
EA09: 07                                RLCA
EA0A: 38 F9                             JR      C,LEA05
EA0C: DB 3F                             IN      A,(3Fh) ; '?'
EA0E: 07                                RLCA
EA0F: 38 F4                             JR      C,LEA05
EA11: DB 3F                             IN      A,(3Fh) ; '?'
EA13: 07                                RLCA
EA14: 38 EF                             JR      C,LEA05
EA16: DB 3F                             IN      A,(3Fh) ; '?'
EA18: 07                                RLCA
EA19: 38 EA                             JR      C,LEA05
EA1B: DB 3F                             IN      A,(3Fh) ; '?'
EA1D: 07                                RLCA
EA1E: 38 E5                             JR      C,LEA05
EA20: DB 3F                             IN      A,(3Fh) ; '?'
EA22: 07                                RLCA
EA23: 38 E0                             JR      C,LEA05
EA25: 07                                RLCA
EA26: 30 DF                             JR      NC,LEA07
EA28: CD 8A EB                          CALL    LEB8A
EA2B: 20 CA                             JR      NZ,LE9F7
EA2D: FE 00                             CP      00h
EA2F: C8                                RET     Z
EA30: AF                                XOR     A
EA31: 3C                                INC     A
EA32: C9                                RET

;**************************************************************************
; ? command 03 REQUEST SENSE
                                        ; --- START PROC SA_COMMAND_REQUEST_SENSE ---
EA33: DD 21 E0 BF                SA_COMMAND_REQUEST_SENSE: LD      IX,0BFE0h
EA37: DD 36 16 FC                       LD      (IX+16h),0FCh
EA3B: DD 36 17 FF                       LD      (IX+17h),0FFh
EA3F: DD 36 18 FF                       LD      (IX+18h),0FFh
EA43: DD 36 19 FF                       LD      (IX+19h),0FFh
EA47: DD 36 1A FF                       LD      (IX+1Ah),0FFh
EA4B: DD 36 1B FF                       LD      (IX+1Bh),0FFh
EA4F: DD 7E 09                          LD      A,(IX+IX_CURRDRIVE)
EA52: FE 14                             CP      14h
EA54: 28 04                             JR      Z,LEA5A
EA56: DD CB 17 AE                       RES     5,(IX+17h)
EA5A: 06 06                      LEA5A: LD      B,06h
EA5C: CD 74 E8                          CALL    SA_SEND_CMD
EA5F: 06 04                             LD      B,04h
EA61: 21 FC BF                          LD      HL,0BFFCh
EA64: CD B9 E8                          CALL    LE8B9
EA67: CD 96 E8                          CALL    SA_READ_STATUS_BYTE
EA6A: 21 92 EA                          LD      HL,0EA92h
EA6D: CD 09 E0                          CALL    EPROM2_PRINTSTRING
EA70: 01 FC BF                          LD      BC,0BFFCh
EA73: 0A                                LD      A,(BC)
EA74: 2F                                CPL
EA75: 02                                LD      (BC),A
EA76: CD 15 E0                          CALL    LE015
EA79: 03                                INC     BC
EA7A: 0A                                LD      A,(BC)
EA7B: 2F                                CPL
EA7C: 02                                LD      (BC),A
EA7D: CD 15 E0                          CALL    LE015
EA80: 03                                INC     BC
EA81: 0A                                LD      A,(BC)
EA82: 2F                                CPL
EA83: 02                                LD      (BC),A
EA84: CD 15 E0                          CALL    LE015
EA87: 03                                INC     BC
EA88: 0A                                LD      A,(BC)
EA89: 2F                                CPL
EA8A: 02                                LD      (BC),A
EA8B: CD 15 E0                          CALL    LE015
EA8E: 00                                NOP
EA8F: 00                                NOP
EA90: 00                                NOP
EA91: C9                                RET

; message

EA92: 0D                         LEA92: DEC     C
EA93: 0A                                LD      A,(BC)
EA94: 44                                LD      B,H
EA95: 49                                LD      C,C
EA96: 53                                LD      D,E
EA97: 4B                                LD      C,E
EA98: 20 52                             JR      NZ,LEAEB+1      ; reference not aligned to instruction
EA9A: 45                                LD      B,L
EA9B: 54                                LD      D,H
EA9C: 52                                LD      D,D
EA9D: 59                                LD      E,C
EA9E: 2E 20                             LD      L,20h   ; ' '
EAA0: 53                                LD      D,E
EAA1: 3D                                DEC     A
EAA2: A0                                AND     B

;**************************************************************************
                                 RIG_READSECTOR1:
EAA3: CD 2A E8                          CALL    RIG_SET_IX_STATUS_READ
EAA6: DD CB 09 6E                       BIT     5,(IX+IX_CURRDRIVE)     ;
EAAA: 28 54                             JR      Z,LEB00                 ; if FDC then goto FDC

EAAC: DD 36 11 05                       LD      (IX+IX_RETRYCOUNT),05h  ; retry 5 times max
                                 READ_SECTOR_RETRY:
EAB0: DD 36 16 F7                       LD      (IX+16h),0F7h           ; command 08 READ

EAB4: 3E FF                             LD      A,0FFh                  ; sets the LUN according
EAB6: DD CB 09 46                       BIT     0,(IX+IX_CURRDRIVE)     ; to drive number
EABA: 28 02                             JR      Z,LEABE                 ;
EABC: CB AF                             RES     5,A                     ;
EABE: DD CB 09 4E                LEABE: BIT     1,(IX+IX_CURRDRIVE)     ;
EAC2: 28 02                             JR      Z,LEAC6                 ;
EAC4: CB B7                             RES     6,A                     ;
EAC6: DD 77 17                   LEAC6: LD      (IX+17h),A              ;

EAC9: DD 7E 0C                          LD      A,(IX+0Ch)              ; sets track number
EACC: 2F                                CPL                             ;
EACD: DD 77 18                          LD      (IX+18h),A              ;

EAD0: DD 7E 0E                          LD      A,(IX+0Eh)              ; set sector number
EAD3: 2F                                CPL                             ;
EAD4: DD 77 19                          LD      (IX+19h),A              ;

EAD7: DD 36 1A FE                       LD      (IX+1Ah),0FEh           ; set 1 sector read
EADB: DD 36 1B FF                       LD      (IX+1Bh),0FFh           ; control field, no parity, no retry
EADF: 06 06                             LD      B,06h                   ; 6 command bytes

EAE1: CD 24 E8                          CALL    SA_SEND_CMD0              ; send READ command
EAE4: 20 0C                             JR      NZ,LEAF2                  ; if error, reset and retry
EAE6: 06 00                             LD      B,00h                     ; 00=count 256 for INIR instruction
EAE8: CD B3 E8                          CALL    SA_READ_DATABYTES         ; read the data bytes and store in DMA buf
EAEB: CC 96 E8                   LEAEB: CALL    Z,SA_READ_STATUS_BYTE     ; if ok read status byte
EAEE: C8                                RET     Z                         ; and if ok exit

EAEF: CD 33 EA                          CALL    SA_COMMAND_REQUEST_SENSE  ; get error info
EAF2: CD 50 E8                   LEAF2: CALL    SA_CONTROLLER_RESET       ; resets the controller
EAF5: CD 55 E8                          CALL    SA_SEND_COMMAND_TESTDRIVE ; and test it
EAF8: DD 35 11                          DEC     (IX+IX_RETRYCOUNT)        ; decrement retry counter
EAFB: 20 B3                             JR      NZ,READ_SECTOR_RETRY      ; retry
EAFD: AF                                XOR     A
EAFE: 3C                                INC     A                         ; retry failed, exit with error (NZ)
EAFF: C9                                RET

;**************************************************************************
;generic disk op
EB00: 0E BF                      LEB00: LD      C,0BFh
EB02: DD 6E 0A                          LD      L,(IX+IX_DSKBUFPTR+0)
EB05: DD 66 0B                          LD      H,(IX+IX_DSKBUFPTR+1)
EB08: 3E 7F                             LD      A,7Fh   ; ''
EB0A: D3 BC                             OUT     (FDCCMD),A
EB0C: CD 5E E9                          CALL    LE95E
EB0F: 20 EF                             JR      NZ,LEB00
EB11: FE 00                             CP      00h
EB13: C8                                RET     Z
EB14: AF                                XOR     A
EB15: 3C                                INC     A
EB16: C9                                RET

;**************************************************************************
; boot from hard disk
                                 BOOT_FROM_SA:
EB17: 3E 2F                             LD      A,2Fh                 ; sends command $2F to FDC
EB19: D3 BC                             OUT     (FDCCMD),A            ;

EB1B: CD 50 E8                          CALL    SA_CONTROLLER_RESET   ; reset the SA controller
EB1E: CD 74 EB                          CALL    RIG_SET_IX_STATUS1    ; set IX and prepare for reading

EB21: 3E FF                             LD      A,0FFh                ; prepare command 00 (TEST DRIVE) per HDC
EB23: DD 77 16                          LD      (IX+16h),A
EB26: DD 77 18                          LD      (IX+18h),A
EB29: DD 77 19                          LD      (IX+19h),A
EB2C: DD 77 1A                          LD      (IX+1Ah),A
EB2F: DD 77 1B                          LD      (IX+1Bh),A
EB32: DD 36 17 DF                       LD      (IX+17h),0DFh         ; sets LUN=001 in the command bytes
EB36: 06 06                             LD      B,06h                 ; command is 6 bytes
EB38: CD 24 E8                          CALL    SA_SEND_CMD0          ; send the command to the controller
EB3B: CD 96 E8                          CALL    SA_READ_STATUS_BYTE   ; read the command result
EB3E: 28 0E                             JR      Z,LEB4E               ; if Z=0 no error, continue

EB40: 0E 0A                             LD      C,0Ah                 ; ?print error message via CP/M
EB42: 06 00                      LEB42: LD      B,00h                 ;
EB44: 3E 0C                      LEB44: LD      A,0Ch                 ;
EB46: CD 03 E4                          CALL    LE401+2               ;
EB49: 10 F9                             DJNZ    LEB44                 ;
EB4B: 0D                                DEC     C                     ;
EB4C: 20 F4                             JR      NZ,LEB42              ;

EB4E: 0E 21                      LEB4E: LD      C,21h                 ; selects drive unit
EB50: CD 09 E8                   LEB50: CALL    RIG_SETDRIVE
EB53: 0E 00                             LD      C,00h                 ; sector 0
EB55: CD 06 E8                          CALL    RIG_SETSECTOR
EB58: CD 21 E8                          CALL    SA_CONTROLLER_RESET0  ; reset controller
EB5B: CD 00 E8                          CALL    RIG_INITD             ; initialize system area
EB5E: 21 00 01                          LD      HL,0100h              ; set destination memory address at 0100H
EB61: CD 0C E8                          CALL    RIG_SETDMA
EB64: DD F9                             LD      SP,IX                 ; set temporary stack behind system area
EB66: CD 12 E8                          CALL    RIG_READSECTOR        ; read first sector into 0100H
EB69: C2 4D E0                          JP      NZ,LE04D              ; if error prints message
EB6C: C3 00 01                          JP      0100h                 ; else executes boot sector

;**************************************************************************


EB6F: 0E 20                      BOOT_UNIT20: LD      C,20h   ; ' '
EB71: C3 50 EB                          JP      LEB50

                                        ; --- START PROC RIG_SET_IX_STATUS1 ---
EB74: 06 98                      RIG_SET_IX_STATUS1: LD      B,98h
EB76: 18 06                             JR      LEB7E

                                        ; --- START PROC RIG_SET_IX_STATUS_READ1 ---
EB78: 06 9E                      RIG_SET_IX_STATUS_READ1: LD      B,9Eh
EB7A: 18 02                             JR      LEB7E

                                        ; --- START PROC RIG_SET_IX_STATUS_WRITE1 ---
EB7C: 06 DE                      RIG_SET_IX_STATUS_WRITE1: LD      B,0DEh
                                        ; --- START PROC LEB7E ---
EB7E: DD 21 E0 BF                LEB7E: LD      IX,0BFE0h
EB82: DD 70 10                          LD      (IX+10h),B
EB85: DD 36 11 0F                       LD      (IX+IX_RETRYCOUNT),0Fh
EB89: C9                                RET

                                        ; --- START PROC LEB8A ---
EB8A: DB 3F                      LEB8A: IN      A,(3Fh) ; '?'
EB8C: CB 77                             BIT     6,A
EB8E: 28 FA                             JR      Z,LEB8A
EB90: DB BC                             IN      A,(FDCCMD)
EB92: 57                                LD      D,A
EB93: DD 35 11                          DEC     (IX+IX_RETRYCOUNT)
EB96: 20 28                             JR      NZ,LEBC0
EB98: 3E 52                             LD      A,52h   ; 'R'
EB9A: CD 03 E4                          CALL    LE401+2 ; reference not aligned to instruction
EB9D: 3E 2D                             LD      A,2Dh   ; '-'
EB9F: CD 03 E4                          CALL    LE401+2 ; reference not aligned to instruction
EBA2: 01 E9 BF                          LD      BC,0BFE9h
EBA5: CD EB E3                          CALL    LE3EB
EBA8: 01 EC BF                          LD      BC,0BFECh
EBAB: CD EB E3                          CALL    LE3EB
EBAE: 01 EE BF                          LD      BC,0BFEEh
EBB1: CD EB E3                          CALL    LE3EB
EBB4: 03                                INC     BC
EBB5: CD EB E3                          CALL    LE3EB
EBB8: 03                                INC     BC
EBB9: CD EB E3                          CALL    LE3EB
EBBC: AF                                XOR     A
EBBD: 3E FF                             LD      A,0FFh
EBBF: C9                                RET

EBC0: 3E 0C                      LEBC0: LD      A,0Ch
EBC2: DD BE 11                          CP      (IX+IX_RETRYCOUNT)
EBC5: CC D9 EB                          CALL    Z,LEBD9
EBC8: 3E 05                             LD      A,05h
EBCA: DD BE 11                          CP      (IX+IX_RETRYCOUNT)
EBCD: CC D9 EB                          CALL    Z,LEBD9
EBD0: 7A                                LD      A,D
EBD1: 2F                                CPL
EBD2: DD 77 0F                          LD      (IX+0Fh),A
EBD5: DD A6 10                          AND     (IX+10h)
EBD8: C9                                RET

                                        ; --- START PROC LEBD9 ---
EBD9: 3E F3                      LEBD9: LD      A,0F3h
EBDB: D3 BC                             OUT     (FDCCMD),A
EBDD: CD F4 EB                          CALL    LEBF4
EBE0: DD 7E 0C                          LD      A,(IX+0Ch)
EBE3: 2F                                CPL
EBE4: D3 BF                             OUT     (0BFh),A
EBE6: 3E E3                             LD      A,0E3h
EBE8: D3 BC                             OUT     (FDCCMD),A
EBEA: CD F4 EB                          CALL    LEBF4
EBED: DD 7E 0C                          LD      A,(IX+0Ch)
EBF0: 2F                                CPL
EBF1: D3 BD                             OUT     (0BDh),A
EBF3: C9                                RET

                                        ; --- START PROC LEBF4 ---
EBF4: DB 3F                      LEBF4: IN      A,(3Fh) ; '?'
EBF6: CB 77                             BIT     6,A
EBF8: 28 FA                             JR      Z,LEBF4
EBFA: DB BC                             IN      A,(FDCCMD)
EBFC: C9                                RET

;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************
;***********************************************************************

; end of meaningful ROM

EBFD: C3 18 CD                   LEBFD: JP      0CD18h

EC00: 80                         LEC00: ADD     A,B
EC01: 9C                                SBC     A,H
EC02: 18 FE                      LEC02: JR      LEC02

EC04: 00                         LEC04: NOP
EC05: 80                                ADD     A,B
EC06: 5D                                LD      E,L
EC07: 18 FE                      LEC07: JR      LEC07

EC09: 27                         LEC09: DAA
EC0A: C2 19 1A                          JP      NZ,1A19h
EC0D: CD 9C 18                          CALL    189Ch
EC10: CD 48 19                          CALL    1948h
EC13: C8                                RET     Z
EC14: 80                                ADD     A,B
EC15: 00                                NOP
EC16: C2 00 18                          JP      NZ,1800h
EC19: 53                                LD      D,E
EC1A: 5F                                LD      E,A
EC1B: C3 00 1A                          JP      1A00h

EC1E: FE 23                      LEC1E: CP      23h     ; '#'
EC20: C2 42 1A                          JP      NZ,1A42h
EC23: CD 90 18                          CALL    1890h
EC26: CD 48 19                          CALL    1948h
EC29: CA 40 1A                          JP      Z,1A40h
EC2C: D6 30                             SUB     30h     ; '0'
EC2E: FE 0A                             CP      0Ah
EC30: D2 5D 18                          JP      NC,185Dh
EC33: 29                                ADD     HL,HL
EC34: 44                                LD      B,H
EC35: 4D                                LD      C,L
EC36: 29                                ADD     HL,HL
EC37: 00                                NOP
EC38: 09                                ADD     HL,BC
EC39: 4F                                LD      C,A
EC3A: 06 00                             LD      B,00h
EC3C: 09                                ADD     HL,BC
EC3D: C3 23 1A                          JP      1A23h

EC40: EB                         LEC40: EX      DE,HL
EC41: C9                                RET

EC42: FE 5E                      LEC42: CP      5Eh     ; '^'
EC44: C2 59 1A                          JP      NZ,1A59h
EC47: D5                                PUSH    DE
EC48: 2A F2 21                          LD      HL,(21F2h)
EC4B: 5E                                LD      E,(HL)
EC4C: 23                                INC     HL
EC4D: 56                                LD      D,(HL)
EC4E: 23                                INC     HL
EC4F: CD 90 18                          CALL    1890h
EC52: FE 5E                             CP      5Eh     ; '^'
EC54: CA 4B 1A                          JP      Z,1A4Bh
EC57: E1                                POP     HL
EC58: C9                                RET

EC59: CD 5A 19                   LEC59: CALL    195Ah
EC5C: 29                                ADD     HL,HL
EC5D: 29                                ADD     HL,HL
EC5E: 29                                ADD     HL,HL
EC5F: 29                                ADD     HL,HL
EC60: B5                                OR      L
EC61: 6F                                LD      L,A
EC62: CD 90 18                          CALL    1890h
EC65: CD 48 19                          CALL    1948h
EC68: C2 42 1A                          JP      NZ,1A42h
EC6B: EB                                EX      DE,HL
EC6C: C9                                RET

EC6D: EB                         LEC6D: EX      DE,HL
EC6E: 22 1E 21                          LD      (211Eh),HL
EC71: EB                                EX      DE,HL
EC72: 73                                LD      (HL),E
EC73: 23                                INC     HL
EC74: 72                                LD      (HL),D
EC75: 23                                INC     HL
EC76: E5                                PUSH    HL
EC77: 21 5D 21                          LD      HL,215Dh
EC7A: 34                                INC     (HL)
EC7B: E1                                POP     HL
EC7C: C9                                RET

EC7D: FE 2D                      LEC7D: CP      2Dh     ; '-'
EC7F: C2 88 1A                          JP      NZ,1A88h
EC82: 11 00 00                          LD      DE,0000h
EC85: C3 AE 1A                          JP      1AAEh

EC88: FE 2B                      LEC88: CP      2Bh     ; '+'
EC8A: C2 95 1A                          JP      NZ,1A95h
EC8D: EB                                EX      DE,HL
EC8E: 2A 1E 21                          LD      HL,(211Eh)
EC91: EB                                EX      DE,HL
EC92: C3 9D 1A                          JP      1A9Dh

EC95: CD D3 19                   LEC95: CALL    19D3h
EC98: FE 2B                             CP      2Bh     ; '+'
EC9A: C2 AB 1A                          JP      NZ,1AABh
EC9D: D5                                PUSH    DE
EC9E: CD 90 18                          CALL    1890h
ECA1: CD D3 19                          CALL    19D3h
ECA4: C1                                POP     BC
ECA5: EB                                EX      DE,HL
ECA6: 09                                ADD     HL,BC
ECA7: EB                                EX      DE,HL
ECA8: C3 98 1A                          JP      1A98h

ECAB: FE 2D                      LECAB: CP      2Dh     ; '-'
ECAD: C0                                RET     NZ
ECAE: CD 90 18                          CALL    1890h
ECB1: D5                                PUSH    DE
ECB2: CD D3 19                          CALL    19D3h
ECB5: C1                                POP     BC
ECB6: F5                                PUSH    AF
ECB7: 60                                LD      H,B
ECB8: 93                                SUB     E
ECB9: 5F                                LD      E,A
ECBA: 78                                LD      A,B
ECBB: 9A                                SBC     A,D
ECBC: 57                                LD      D,A
ECBD: F1                                POP     AF
ECBE: C3 98 1A                          JP      1A98h

ECC1: CD 90 18                   LECC1: CALL    1890h
ECC4: 21 4B 21                          LD      HL,214Bh
ECC7: 36 00                             LD      (HL),00h
ECC9: FE 57                             CP      57h     ; 'W'
ECCB: C2 D3 1A                          JP      NZ,1AD3h
ECCE: 36 FF                             LD      (HL),0FFh
ECD0: CD 90 18                          CALL    1890h
ECD3: 21 5D 21                          LD      HL,215Dh
ECD6: 36 00                             LD      (HL),00h
ECD8: 23                                INC     HL
ECD9: FE 0D                             CP      0Dh
ECDB: CA 15 1B                          JP      Z,1B15h
ECDE: FE 2C                             CP      2Ch     ; ','
ECE0: C2 EE 1A                          JP      NZ,1AEEh
ECE3: 3E 80                             LD      A,80h
ECE5: 32 5D 21                          LD      (215Dh),A
ECE8: 11 00 00                          LD      DE,0000h
ECEB: C3 F1 1A                          JP      1AF1h

ECEE: CD 7D 1A                   LECEE: CALL    1A7Dh
ECF1: CD 6D 1A                          CALL    1A6Dh
ECF4: FE 0D                             CP      0Dh
ECF6: CA 00 1B                          JP      Z,1B00h
ECF9: CD 90 18                          CALL    1890h
ECFC: CD 7D 1A                          CALL    1A7Dh
ECFF: CD 6D 1A                          CALL    1A6Dh
ED02: FE 0D                             CP      0Dh
ED04: 80                                ADD     A,B
ED05: 15                                DEC     D
ED06: 1B                                DEC     DE
ED07: CD 90 18                          CALL    1890h
ED0A: CD 7D 1A                          CALL    1A7Dh
ED0D: CD 6D 1A                          CALL    1A6Dh
ED10: FE 0D                             CP      0Dh
ED12: C2 5D 18                          JP      NZ,185Dh
ED15: 11 5D 21                          LD      DE,215Dh
ED18: 1A                                LD      A,(DE)
ED19: FE 81                             CP      81h
ED1B: CA 5D 18                          JP      Z,185Dh
ED1E: 13                                INC     DE
ED1F: B7                                OR      A
ED20: 07                                RLCA
ED21: 0F                                RRCA
ED22: C9                                RET

ED23: E5                         LED23: PUSH    HL
ED24: D5                                PUSH    DE
ED25: 21 4A 1D                          LD      HL,1D4Ah
ED28: 58                                LD      E,B
ED29: 16 00                             LD      D,00h
ED2B: 19                                ADD     HL,DE
ED2C: 4E                                LD      C,(HL)
ED2D: D1                                POP     DE
ED2E: E1                                POP     HL
ED2F: 7E                                LD      A,(HL)
ED30: 11 C0 21                          LD      DE,21C0h
ED33: B7                                OR      A
ED34: FA 3A 1B                          JP      M,1B3Ah
ED37: 00                                NOP
ED38: F0                                RET     P
ED39: 21 EB 7E                          LD      HL,7EEBh
ED3C: EB                                EX      DE,HL
ED3D: C9                                RET

ED3E: CD 23 1B                   LED3E: CALL    1B23h
ED41: 0D                                DEC     C
ED42: CA 49 1B                          JP      Z,1B49h
ED45: 1F                                RRA
ED46: C3 41 1B                          JP      1B41h

ED49: E6 01                      LED49: AND     01h
ED4B: C9                                RET

ED4C: D6 06                      LED4C: SUB     06h
ED4E: EB                                EX      DE,HL
ED4F: 5F                                LD      E,A
ED50: 16 00                             LD      D,00h
ED52: 19                                ADD     HL,DE
ED53: 5E                                LD      E,(HL)
ED54: 16 FF                             LD      D,0FFh
ED56: 21 F8 21                          LD      HL,21F8h
ED59: 19                                ADD     HL,DE
ED5A: C9                                RET

ED5B: CD 4C 1B                   LED5B: CALL    1B4Ch
ED5E: 5E                                LD      E,(HL)
ED5F: 23                                INC     HL
ED60: 56                                LD      D,(HL)
ED61: EB                                EX      DE,HL
ED62: C9                                RET

ED63: 78                         LED63: LD      A,B
ED64: FE 05                             CP      05h
ED66: D2 7D 1B                          JP      NC,1B7Dh
ED69: D5                                PUSH    DE
ED6A: CD 3E 1B                          CALL    1B3Eh
ED6D: D1                                POP     DE
ED6E: B7                                OR      A
ED6F: 3E 2D                             LD      A,2Dh   ; '-'
ED71: CA 79 18                          JP      Z,1879h
ED74: 7E                                LD      A,(HL)
ED75: B7                                OR      A
ED76: F2 79 18                          JP      P,1879h
ED79: 2F                                CPL
ED7A: C3 79 18                          JP      1879h

ED7D: F5                         LED7D: PUSH    AF
ED7E: 7E                                LD      A,(HL)
ED7F: B7                                OR      A
ED80: FA 8B 1B                          JP      M,1B8Bh
ED83: CD 79 18                          CALL    1879h
ED86: 3E 3D                             LD      A,3Dh   ; '='
ED88: C3 91 1B                          JP      1B91h

ED8B: 2F                         LED8B: CPL
ED8C: CD 79 18                          CALL    1879h
ED8F: 3E 27                             LD      A,27h   ; '''
ED91: CD 79 18                          CALL    1879h
ED94: F1                                POP     AF
ED95: C2 A8 1B                          JP      NZ,1BA8h
ED98: 7E                                LD      A,(HL)
ED99: B7                                OR      A
ED9A: 21 C1 21                          LD      HL,21C1h
ED9D: FA A3 1B                          JP      M,1BA3h
EDA0: 21 F1 21                          LD      HL,21F1h
EDA3: 7E                                LD      A,(HL)
EDA4: CD C1 18                          CALL    18C1h
EDA7: C9                                RET

EDA8: D5                         LEDA8: PUSH    DE
EDA9: CD 5B 1B                          CALL    1B5Bh
EDAC: CD 23 19                          CALL    1923h
EDAF: D1                                POP     DE
EDB0: C9                                RET

EDB1: CD D1 18                   LEDB1: CALL    18D1h
EDB4: CD 77 18                          CALL    1877h
EDB7: 06 00                             LD      B,00h
EDB9: C5                                PUSH    BC
EDBA: E5                                PUSH    HL
EDBB: CD 63 1B                          CALL    1B63h
EDBE: E1                                POP     HL
EDBF: C1                                POP     BC
EDC0: 04                                INC     B
EDC1: 23                                INC     HL
EDC2: 78                                LD      A,B
EDC3: FE 0B                             CP      0Bh
EDC5: D0                                RET     NC
EDC6: FE 05                             CP      05h
EDC8: DA B9 1B                          JP      C,1BB9h
EDCB: CD 77 18                          CALL    1877h
EDCE: C3 B9 1B                          JP      1BB9h

EDD1: 11 35 1D                   LEDD1: LD      DE,1D35h
EDD4: 21 2A 1D                          LD      HL,1D2Ah
EDD7: CD B1 1B                          CALL    1BB1h
EDDA: 11 45 1D                          LD      DE,1D45h
EDDD: 21 3A 1D                          LD      HL,1D3Ah
EDE0: CD B1 1B                          CALL    1BB1h
EDE3: CD 77 18                          CALL    1877h
EDE6: CD 20 1F                          CALL    1F20h
EDE9: F5                                PUSH    AF
EDEA: D5                                PUSH    DE
EDEB: C5                                PUSH    BC
EDEC: CD D6 13                          CALL    13D6h
EDEF: D2 19 1C                          JP      NC,1C19h
EDF2: 2A F6 21                          LD      HL,(21F6h)
EDF5: 22 0C 00                          LD      (000Ch),HL
EDF8: 21 10 00                          LD      HL,0010h
EDFB: 36 FF                             LD      (HL),0FFh
EDFD: CD 06 00                          CALL    0006h
EE00: C3 63 1C                          JP      1C63h

EE03: 0E 00                      LEE03: LD      C,00h
EE05: FE CB                             CP      0CBh
EE07: CA 12 1C                          JP      Z,1C12h
EE0A: FE DD                             CP      0DDh
EE0C: D8                                RET     C
EE0D: E6 CF                             AND     0CFh
EE0F: FE CD                             CP      0CDh
EE11: C0                                RET     NZ
EE12: 23                                INC     HL
EE13: 7E                                LD      A,(HL)
EE14: 00                                NOP
EE15: CD C1 18                          CALL    18C1h
EE18: C9                                RET

EE19: 2B                         LEE19: DEC     HL
EE1A: 22 66 21                          LD      (2166h),HL
EE1D: 2A F6 21                          LD      HL,(21F6h)
EE20: 7E                                LD      A,(HL)
EE21: CD C1 18                          CALL    18C1h
EE24: 7E                                LD      A,(HL)
EE25: CD 03 1C                          CALL    1C03h
EE28: 23                                INC     HL
EE29: CD 3A 19                          CALL    193Ah
EE2C: DA 63 1C                          JP      C,1C63h
EE2F: F5                                PUSH    AF
EE30: CD 77 18                          CALL    1877h
EE33: F1                                POP     AF
EE34: B3                                OR      E
EE35: CA 4A 1C                          JP      Z,1C4Ah
EE38: 5E                                LD      E,(HL)
EE39: 23                                INC     HL
EE3A: 56                                LD      D,(HL)
EE3B: 79                                LD      A,C
EE3C: FE 36                             CP      36h     ; '6'
EE3E: C2 44 1C                          JP      NZ,1C44h
EE41: 7A                                LD      A,D
EE42: 53                                LD      D,E
EE43: 5F                                LD      E,A
EE44: CD EA 18                          CALL    18EAh
EE47: C3 63 1C                          JP      1C63h

EE4A: 7E                         LEE4A: LD      A,(HL)
EE4B: CD C1 18                          CALL    18C1h
EE4E: 2A F6 21                          LD      HL,(21F6h)
EE51: 7E                                LD      A,(HL)
EE52: E6 C7                             AND     0C7h
EE54: FE 00                             CP      00h
EE56: C2 63 1C                          JP      NZ,1C63h
EE59: 23                                INC     HL
EE5A: 5E                                LD      E,(HL)
EE5B: 16 00                             LD      D,00h
EE5D: 2B                                DEC     HL
EE5E: 19                                ADD     HL,DE
EE5F: EB                                EX      DE,HL
EE60: CD EA 18                          CALL    18EAh
EE63: 2A F6 21                          LD      HL,(21F6h)
EE66: 7E                                LD      A,(HL)
EE67: 47                                LD      B,A
EE68: E6 C0                             AND     0C0h
EE6A: FE 80                             CP      80h
EE6C: C2 7A 1C                          JP      NZ,1C7Ah
EE6F: 78                                LD      A,B
EE70: E6 07                             AND     07h
EE72: FE 06                             CP      06h
EE74: C2 26 1D                          JP      NZ,1D26h
EE77: C3 A7 1C                          JP      1CA7h

EE7A: FE 40                      LEE7A: CP      40h     ; '@'
EE7C: C2 97 1C                          JP      NZ,1C97h
EE7F: 78                                LD      A,B
EE80: FE 76                             CP      76h     ; 'v'
EE82: CA 26 1D                          JP      Z,1D26h
EE85: E6 07                             AND     07h
EE87: FE 06                             CP      06h
EE89: CA B3 1C                          JP      Z,1CB3h
EE8C: 78                                LD      A,B
EE8D: E6 38                             AND     38h     ; '8'
EE8F: FE 30                             CP      30h     ; '0'
EE91: C2 26 1D                          JP      NZ,1D26h
EE94: C3 B3 1C                          JP      1CB3h

EE97: 78                         LEE97: LD      A,B
EE98: FE 36                             CP      36h     ; '6'
EE9A: CA B3 1C                          JP      Z,1CB3h
EE9D: FE 34                             CP      34h     ; '4'
EE9F: CA A7 1C                          JP      Z,1CA7h
EEA2: FE 35                             CP      35h     ; '5'
EEA4: C2 B9 1C                          JP      NZ,1CB9h
EEA7: 3E 3D                             LD      A,3Dh   ; '='
EEA9: CD 79 18                          CALL    1879h
EEAC: 2A F4 21                          LD      HL,(21F4h)
EEAF: 7E                                LD      A,(HL)
EEB0: CD C1 18                          CALL    18C1h
EEB3: 2A F4 21                          LD      HL,(21F4h)
EEB6: C3 CC 1C                          JP      1CCCh

EEB9: E6 E7                      LEEB9: AND     0E7h
EEBB: FE 02                             CP      02h
EEBD: C2 E0 1C                          JP      NZ,1CE0h
EEC0: 78                                LD      A,B
EEC1: E6 10                             AND     10h
EEC3: 2A EC 21                          LD      HL,(21ECh)
EEC6: C2 CC 1C                          JP      NZ,1CCCh
EEC9: 2A EE 21                          LD      HL,(21EEh)
EECC: 3A 4A 21                          LD      A,(214Ah)
EECF: B7                                OR      A
EED0: C2 26 1D                          JP      NZ,1D26h
EED3: EB                                EX      DE,HL
EED4: CD F3 20                          CALL    20F3h
EED7: CA 26 1D                          JP      Z,1D26h
EEDA: CD F9 18                          CALL    18F9h
EEDD: C3 26 1D                          JP      1D26h

EEE0: 78                         LEEE0: LD      A,B
EEE1: FE CB                             CP      0CBh
EEE3: C2 F4 1C                          JP      NZ,1CF4h
EEE6: 2A AE 21                          LD      HL,(21AEh)
EEE9: 7E                                LD      A,(HL)
EEEA: E6 07                             AND     07h
EEEC: FE 06                             CP      06h
EEEE: C2 26 1D                          JP      NZ,1D26h
EEF1: C3 B3 1C                          JP      1CB3h

EEF4: E6 DD                      LEEF4: AND     0DDh
EEF6: FE DD                             CP      0DDh
EEF8: C2 26 1D                          JP      NZ,1D26h
EEFB: 2A AE 21                          LD      HL,(21AEh)
EEFE: 7E                                LD      A,(HL)
EEFF: FE 39                             CP      39h     ; '9'
EF01: CA 26 1D                          JP      Z,1D26h
EF04: FE 34                             CP      34h     ; '4'
EF06: DA 26 1D                          JP      C,1D26h
EF09: FE CC                             CP      0CCh
EF0B: CA 26 1D                          JP      Z,1D26h
EF0E: 23                                INC     HL
EF0F: 5E                                LD      E,(HL)
EF10: 16 00                             LD      D,00h
EF12: 78                                LD      A,B
EF13: FE 80                             CP      80h
EF15: CA 00 1D                          JP      Z,1D00h
EF18: FD E5                             PUSH    IY
EF1A: E1                                POP     HL
EF1B: 19                                ADD     HL,DE
EF1C: C3 CC 1C                          JP      1CCCh

EF1F: DD E5                      LEF1F: PUSH    IX
EF21: E1                                POP     HL
EF22: 19                                ADD     HL,DE
EF23: C3 CC 1C                          JP      1CCCh

EF26: C1                         LEF26: POP     BC
EF27: D1                                POP     DE
EF28: F1                                POP     AF
EF29: C9                                RET

EF2A: 43                         LEF2A: LD      B,E
EF2B: 5A                                LD      E,D
EF2C: 4D                                LD      C,L
EF2D: 45                                LD      B,L
EF2E: 49                                LD      C,C
EF2F: 41                                LD      B,C
EF30: 42                                LD      B,D
EF31: 44                                LD      B,H
EF32: 48                                LD      C,B
EF33: 53                                LD      D,E
EF34: 50                                LD      D,B
EF35: F6 80                             OR      80h
EF37: FC FA FE                          CALL    M,0FEFAh
EF3A: BC                                CP      H
EF3B: A5                                AND     L
EF3C: B2                                OR      D
EF3D: BA                                CP      D
EF3E: B6                                OR      (HL)
EF3F: BE                                CP      (HL)
EF40: BD                                CP      L
EF41: BB                                CP      E
EF42: B7                                OR      A
EF43: 58                                LD      E,B
EF44: 59                                LD      E,C
EF45: C6 C4                             ADD     A,0C4h
EF47: C2 C0 BE                          JP      NZ,0BEC0h
EF4A: 01 07 08                          LD      BC,0807h
EF4D: 03                                INC     BC
EF4E: 05                                DEC     B
EF4F: 21 00 00                          LD      HL,0000h
EF52: 22 54 21                          LD      (2154h),HL
EF55: AF                                XOR     A
EF56: 32 53 21                          LD      (2153h),A
EF59: C9                                RET

EF5A: F3                         LEF5A: DI
EF5B: 22 F4 21                          LD      (21F4h),HL
EF5E: E1                                POP     HL
EF5F: 2B                                DEC     HL
EF60: 22 F6 21                          LD      (21F6h),HL
EF63: F5                                PUSH    AF
EF64: 21 02 00                          LD      HL,0002h
EF67: 39                                ADD     HL,SP
EF68: F1                                POP     AF
EF69: 31 F4 21                          LD      SP,21F4h
EF6C: E5                                PUSH    HL
EF6D: F5                                PUSH    AF
EF6E: C5                                PUSH    BC
EF6F: D5                                PUSH    DE
EF70: 21 00 00                          LD      HL,0000h
EF73: 39                                ADD     HL,SP
EF74: 31 C2 21                          LD      SP,21C2h
EF77: 08                                EX      AF,AF'
EF78: F5                                PUSH    AF
EF79: 08                                EX      AF,AF'
EF7A: D9                                EXX
EF7B: C5                                PUSH    BC
EF7C: D5                                PUSH    DE
EF7D: E5                                PUSH    HL
EF7E: D9                                EXX
EF7F: DD E5                             PUSH    IX
EF81: FD E5                             PUSH    IY
EF83: F9                                LD      SP,HL
EF84: 00                                NOP
EF85: 00                                NOP
EF86: 00                                NOP
EF87: FB                                EI
EF88: 2A F6 21                          LD      HL,(21F6h)
EF8B: 7E                                LD      A,(HL)
EF8C: FE FF                             CP      0FFh
EF8E: F5                                PUSH    AF
EF8F: E5                                PUSH    HL
EF90: 3A 20 21                          LD      A,(2120h)
EF93: 32 44 21                          LD      (2144h),A
EF96: 21 40 21                          LD      HL,2140h
EF99: 0E 08                             LD      C,08h
EF9B: E5                                PUSH    HL
EF9C: 7E                                LD      A,(HL)
EF9D: B7                                OR      A
EF9E: CA A8 1D                          JP      Z,1DA8h
EFA1: 23                                INC     HL
EFA2: 5E                                LD      E,(HL)
EFA3: 23                                INC     HL
EFA4: 56                                LD      D,(HL)
EFA5: 23                                INC     HL
EFA6: 7E                                LD      A,(HL)
EFA7: 12                                LD      (DE),A
EFA8: E1                                POP     HL
EFA9: 11 FC FF                          LD      DE,0FFFCh
EFAC: 19                                ADD     HL,DE
EFAD: 0D                                DEC     C
EFAE: C2 9B 1D                          JP      NZ,1D9Bh
EFB1: CD FD 1E                          CALL    1EFDh
EFB4: 21 56 21                          LD      HL,2156h
EFB7: 7E                                LD      A,(HL)
EFB8: 36 00                             LD      (HL),00h
EFBA: B7                                OR      A
EFBB: CA CB 1D                          JP      Z,1DCBh
EFBE: 3D                                DEC     A
EFBF: 47                                LD      B,A
EFC0: 23                                INC     HL
EFC1: 5E                                LD      E,(HL)
EFC2: 23                                INC     HL
EFC3: 56                                LD      D,(HL)
EFC4: 23                                INC     HL
EFC5: 7E                                LD      A,(HL)
EFC6: 12                                LD      (DE),A
EFC7: 78                                LD      A,B
EFC8: C3 BA 1D                          JP      1DBAh

EFCB: E1                         LEFCB: POP     HL
EFCC: F1                                POP     AF
EFCD: CA EF 1D                          JP      Z,1DEFh
EFD0: 23                                INC     HL
EFD1: 22 F6 21                          LD      (21F6h),HL
EFD4: EB                                EX      DE,HL
EFD5: 21 B5 0E                          LD      HL,0EB5h
EFD8: 4E                                LD      C,(HL)
EFD9: 23                                INC     HL
EFDA: 46                                LD      B,(HL)
EFDB: CD 17 11                          CALL    1117h
EFDE: DA EF 1D                          JP      C,1DEFh
EFE1: CD 4F 1D                          CALL    1D4Fh
EFE4: 2A 51 21                          LD      HL,(2151h)
EFE7: EB                                EX      DE,HL
EFE8: 3E 82                             LD      A,82h
EFEA: B7                                OR      A
EFEB: 37                                SCF
EFEC: C3 55 11                          JP      1155h

EFEF: 3A 23 21                   LEFEF: LD      A,(2123h)
EFF2: B7                                OR      A
EFF3: C2 94 1E                          JP      NZ,1E94h
EFF6: 21 24 21                          LD      HL,2124h
EFF9: 0E 08                             LD      C,08h
EFFB: E5                                PUSH    HL
EFFC: 7E                                LD      A,(HL)
EFFD: B7                                OR      A
EFFE: CA 51