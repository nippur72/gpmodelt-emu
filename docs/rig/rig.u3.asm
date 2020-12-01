                                        ; Entry Point
                                        ; --- START PROC LE800 ---
E800: C3 30 E8                   LE800: JP      LE830

                                        ; Entry Point
                                        ; --- START PROC LE803 ---
E803: C3 31 E9                   LE803: JP      LE931

                                        ; Entry Point
                                        ; --- START PROC LE806 ---
E806: C3 65 E9                   LE806: JP      LE965

                                        ; Entry Point
                                        ; --- START PROC LE809 ---
E809: C3 75 E9                   LE809: JP      LE975

                                        ; Entry Point
                                        ; --- START PROC LE80C ---
E80C: C3 E1 E9                   LE80C: JP      LE9E1

                                        ; Entry Point
                                        ; --- START PROC LE80F ---
E80F: C3 EB E9                   LE80F: JP      LE9EB

                                        ; Entry Point
                                        ; --- START PROC LE812 ---
E812: C3 7E EA                   LE812: JP      LEA7E

                                        ; Entry Point
                                        ; --- START PROC LE815 ---
E815: C3 50 EB                   LE815: JP      LEB50

                                        ; Entry Point
                                        ; --- START PROC LE818 ---
E818: C3 EF EA                   LE818: JP      LEAEF

                                        ; Entry Point
                                        ; --- START PROC LE81B ---
E81B: C3 17 E9                   LE81B: JP      LE917

                                        ; Entry Point
                                        ; --- START PROC LE81E ---
E81E: C3 00 00                   LE81E: JP      0000h

                                        ; --- START PROC LE821 ---
E821: C3 50 E8                   LE821: JP      LE850

                                        ; --- START PROC LE824 ---
E824: C3 78 E8                   LE824: JP      LE878

                                        ; --- START PROC LE827 ---
E827: C3 55 EB                   LE827: JP      LEB55

                                        ; --- START PROC LE82A ---
E82A: C3 59 EB                   LE82A: JP      LEB59

                                        ; --- START PROC LE82D ---
E82D: C3 5D EB                   LE82D: JP      LEB5D

                                        ; --- START PROC LE830 ---
E830: CD 27 E8                   LE830: CALL    LE827
E833: DD 36 0C 00                       LD      (IX+0Ch),00h
E837: DD CB 09 6E                       BIT     5,(IX+09h)
E83B: C0                                RET     NZ
E83C: DD CB 09 5E                LE83C: BIT     3,(IX+09h)
E840: 28 04                             JR      Z,LE846
E842: 3E FB                             LD      A,0FBh
E844: 18 02                             JR      LE848

E846: 3E F0                      LE846: LD      A,0F0h
E848: D3 BC                      LE848: OUT     (0BCh),A
E84A: CD 6B EB                          CALL    LEB6B
E84D: C8                                RET     Z
E84E: 18 EC                             JR      LE83C

                                        ; --- START PROC LE850 ---
E850: 3E FC                      LE850: LD      A,0FCh
E852: D3 6D                             OUT     (6Dh),A ; 'm'
E854: 3E FE                             LD      A,0FEh
E856: D3 6D                             OUT     (6Dh),A ; 'm'
E858: C9                                RET

                                        ; --- START PROC LE859 ---
E859: 3E FF                      LE859: LD      A,0FFh
E85B: DD 77 18                          LD      (IX+18h),A
E85E: DD 77 19                          LD      (IX+19h),A
E861: DD 77 1A                          LD      (IX+1Ah),A
E864: DD 77 1B                          LD      (IX+1Bh),A
E867: DD 36 16 FE                       LD      (IX+16h),0FEh
E86B: DD 36 17 DF                       LD      (IX+17h),0DFh
E86F: 06 06                             LD      B,06h
E871: CD 24 E8                          CALL    LE824
E874: CD C4 E8                          CALL    LE8C4
E877: C9                                RET

                                        ; --- START PROC LE878 ---
E878: DD E5                      LE878: PUSH    IX
E87A: E1                                POP     HL
E87B: 2E F6                             LD      L,0F6h
E87D: 0E 6C                             LD      C,6Ch   ; 'l'
E87F: DB 6D                      LE87F: IN      A,(6Dh) ; 'm'
E881: CB 47                             BIT     0,A
E883: 28 FA                             JR      Z,LE87F
E885: 3E FE                             LD      A,0FEh
E887: D3 6C                             OUT     (6Ch),A ; 'l'
E889: 3E EE                             LD      A,0EEh
E88B: D3 6D                             OUT     (6Dh),A ; 'm'
E88D: 3E EA                             LD      A,0EAh
E88F: D3 6D                             OUT     (6Dh),A ; 'm'
E891: DB 6D                      LE891: IN      A,(6Dh) ; 'm'
E893: CB 47                             BIT     0,A
E895: 20 FA                             JR      NZ,LE891
E897: 3E EE                             LD      A,0EEh
E899: D3 6D                             OUT     (6Dh),A ; 'm'
E89B: DB 6D                      LE89B: IN      A,(6Dh) ; 'm'
E89D: CB 57                             BIT     2,A
E89F: 20 FA                             JR      NZ,LE89B
                                        ; --- START PROC LE8A1 ---
E8A1: DB 6D                      LE8A1: IN      A,(6Dh) ; 'm'
E8A3: CB 4F                             BIT     1,A
E8A5: 20 03                             JR      NZ,LE8AA
                                        ; --- START PROC LE8A7 ---
E8A7: AF                         LE8A7: XOR     A
E8A8: 3C                                INC     A
E8A9: C9                                RET

                                        ; --- START PROC LE8AA ---
E8AA: CB 5F                      LE8AA: BIT     3,A
E8AC: 20 F3                             JR      NZ,LE8A1
E8AE: ED A3                             OUTI
E8B0: CD BB E8                          CALL    LE8BB
E8B3: 20 EC                             JR      NZ,LE8A1
E8B5: 3E FE                             LD      A,0FEh
E8B7: D3 6D                             OUT     (6Dh),A ; 'm'
E8B9: AF                                XOR     A
E8BA: C9                                RET

                                        ; --- START PROC LE8BB ---
E8BB: 3E EF                      LE8BB: LD      A,0EFh
E8BD: D3 6D                             OUT     (6Dh),A ; 'm'
E8BF: 3E EE                             LD      A,0EEh
E8C1: D3 6D                             OUT     (6Dh),A ; 'm'
E8C3: C9                                RET

                                        ; --- START PROC LE8C4 ---
E8C4: 3E FE                      LE8C4: LD      A,0FEh
E8C6: D3 6D                             OUT     (6Dh),A ; 'm'
E8C8: DB 6D                             IN      A,(6Dh) ; 'm'
E8CA: E6 14                             AND     14h
E8CC: 20 F6                             JR      NZ,LE8C4
E8CE: DB 6D                      LE8CE: IN      A,(6Dh) ; 'm'
E8D0: CB 4F                             BIT     1,A
E8D2: 20 02                             JR      NZ,LE8D6
E8D4: 3C                                INC     A
E8D5: C9                                RET

E8D6: CB 5F                      LE8D6: BIT     3,A
E8D8: 20 F4                             JR      NZ,LE8CE
E8DA: DB 6C                             IN      A,(6Ch) ; 'l'
E8DC: 2F                                CPL
E8DD: 47                                LD      B,A
E8DE: CD F5 E8                          CALL    LE8F5
E8E1: DB 6D                             IN      A,(6Dh) ; 'm'
E8E3: CB 4F                             BIT     1,A
E8E5: C0                                RET     NZ
E8E6: DB 6D                      LE8E6: IN      A,(6Dh) ; 'm'
E8E8: CB 5F                             BIT     3,A
E8EA: 20 FA                             JR      NZ,LE8E6
E8EC: CD F5 E8                          CALL    LE8F5
E8EF: AF                                XOR     A
E8F0: CB 48                             BIT     1,B
E8F2: C8                                RET     Z
E8F3: 3C                                INC     A
E8F4: C9                                RET

                                        ; --- START PROC LE8F5 ---
E8F5: 3E FF                      LE8F5: LD      A,0FFh
E8F7: D3 6D                             OUT     (6Dh),A ; 'm'
E8F9: 3E FE                             LD      A,0FEh
E8FB: D3 6D                             OUT     (6Dh),A ; 'm'
E8FD: C9                                RET

                                        ; --- START PROC LE8FE ---
E8FE: DD 6E 0A                   LE8FE: LD      L,(IX+0Ah)
E901: DD 66 0B                          LD      H,(IX+0Bh)
E904: DB 6D                      LE904: IN      A,(6Dh) ; 'm'
E906: CB 5F                             BIT     3,A
E908: 20 FA                             JR      NZ,LE904
E90A: CB 57                             BIT     2,A
E90C: 28 99                             JR      Z,LE8A7
E90E: ED A2                             INI
E910: CD F5 E8                          CALL    LE8F5
E913: 20 EF                             JR      NZ,LE904
E915: AF                                XOR     A
E916: C9                                RET

                                        ; --- START PROC LE917 ---
E917: DD 6E 0A                   LE917: LD      L,(IX+0Ah)
E91A: DD 66 0B                          LD      H,(IX+0Bh)
E91D: DB 6D                      LE91D: IN      A,(6Dh) ; 'm'
E91F: CB 5F                             BIT     3,A
E921: 20 FA                             JR      NZ,LE91D
E923: CB 57                             BIT     2,A
E925: CA A7 E8                          JP      Z,LE8A7
E928: ED A3                             OUTI
E92A: CD BB E8                          CALL    LE8BB
E92D: 20 EE                             JR      NZ,LE91D
E92F: AF                                XOR     A
E930: C9                                RET

                                        ; --- START PROC LE931 ---
E931: CD 27 E8                   LE931: CALL    LE827
E934: DD 71 0C                          LD      (IX+0Ch),C
E937: DD CB 09 6E                       BIT     5,(IX+09h)
E93B: C0                                RET     NZ
E93C: DD 7E 0C                   LE93C: LD      A,(IX+0Ch)
E93F: 2F                                CPL
E940: D3 BF                             OUT     (0BFh),A
E942: DD CB 09 5E                       BIT     3,(IX+09h)
E946: 28 04                             JR      Z,LE94C
E948: 3E EB                             LD      A,0EBh
E94A: 18 02                             JR      LE94E

E94C: 3E E0                      LE94C: LD      A,0E0h
E94E: D3 BC                      LE94E: OUT     (0BCh),A
E950: CD 6B EB                          CALL    LEB6B
E953: 20 07                             JR      NZ,LE95C
E955: DD 7E 0C                          LD      A,(IX+0Ch)
E958: 2F                                CPL
E959: D3 BD                             OUT     (0BDh),A
E95B: C9                                RET

E95C: 3E F3                      LE95C: LD      A,0F3h
E95E: D3 BC                             OUT     (0BCh),A
E960: CD D5 EB                          CALL    LEBD5
E963: 18 D7                             JR      LE93C

                                        ; --- START PROC LE965 ---
E965: CD 27 E8                   LE965: CALL    LE827
E968: DD 71 0E                          LD      (IX+0Eh),C
E96B: DD CB 09 6E                       BIT     5,(IX+09h)
E96F: C0                                RET     NZ
E970: 79                                LD      A,C
E971: 2F                                CPL
E972: D3 BE                             OUT     (0BEh),A
E974: C9                                RET

                                        ; --- START PROC LE975 ---
E975: CD 27 E8                   LE975: CALL    LE827
E978: CB 69                             BIT     5,C
E97A: 28 04                             JR      Z,LE980
E97C: DD 71 09                          LD      (IX+09h),C
E97F: C9                                RET

E980: DD 71 09                   LE980: LD      (IX+09h),C
E983: CD C6 E9                          CALL    LE9C6
E986: D3 3F                             OUT     (3Fh),A ; '?'
E988: CD 2A E8                          CALL    LE82A
E98B: DD E5                      LE98B: PUSH    IX
E98D: E1                                POP     HL
E98E: 2E F6                             LD      L,0F6h
E990: 0E BF                             LD      C,0BFh
E992: 3E 3B                             LD      A,3Bh   ; ';'
E994: D3 BC                             OUT     (0BCh),A
E996: CD AC E9                          CALL    LE9AC
E999: 20 F0                             JR      NZ,LE98B
E99B: FE 00                             CP      00h
E99D: C2 00 E8                          JP      NZ,LE800
E9A0: DD 7E 16                          LD      A,(IX+16h)
E9A3: D3 BD                             OUT     (0BDh),A
E9A5: 2F                                CPL
E9A6: DD 77 0C                          LD      (IX+0Ch),A
E9A9: C9                                RET

                                        ; --- START PROC LE9AA ---
E9AA: ED A2                      LE9AA: INI
                                        ; --- START PROC LE9AC ---
E9AC: DB 3F                      LE9AC: IN      A,(3Fh) ; '?'
E9AE: 07                                RLCA
E9AF: 38 F9                             JR      C,LE9AA
E9B1: DB 3F                             IN      A,(3Fh) ; '?'
E9B3: 07                                RLCA
E9B4: 38 F4                             JR      C,LE9AA
E9B6: DB 3F                             IN      A,(3Fh) ; '?'
E9B8: 07                                RLCA
E9B9: 38 EF                             JR      C,LE9AA
E9BB: DB 3F                             IN      A,(3Fh) ; '?'
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

                                        ; --- START PROC LE9E1 ---
E9E1: CD 27 E8                   LE9E1: CALL    LE827
E9E4: DD 75 0A                          LD      (IX+0Ah),L
E9E7: DD 74 0B                          LD      (IX+0Bh),H
E9EA: C9                                RET

                                        ; --- START PROC LE9EB ---
E9EB: CD 2D E8                   LE9EB: CALL    LE82D
E9EE: DD CB 09 6E                       BIT     5,(IX+09h)
E9F2: 28 4E                             JR      Z,LEA42
E9F4: DD 36 11 05                       LD      (IX+11h),05h
E9F8: DD 36 16 F5                LE9F8: LD      (IX+16h),0F5h
E9FC: 3E FF                             LD      A,0FFh
E9FE: DD CB 09 46                       BIT     0,(IX+09h)
EA02: 28 02                             JR      Z,LEA06
EA04: CB AF                             RES     5,A
EA06: DD CB 09 4E                LEA06: BIT     1,(IX+09h)
EA0A: 28 02                             JR      Z,LEA0E
EA0C: CB B7                             RES     6,A
EA0E: DD 77 17                   LEA0E: LD      (IX+17h),A
EA11: DD 7E 0C                          LD      A,(IX+0Ch)
EA14: 2F                                CPL
EA15: DD 77 18                          LD      (IX+18h),A
EA18: DD 7E 0E                          LD      A,(IX+0Eh)
EA1B: 2F                                CPL
EA1C: DD 77 19                          LD      (IX+19h),A
EA1F: DD 36 1A FE                       LD      (IX+1Ah),0FEh
EA23: DD 36 1B FF                       LD      (IX+1Bh),0FFh
EA27: 06 06                             LD      B,06h
EA29: CD 24 E8                          CALL    LE824
EA2C: 20 09                             JR      NZ,LEA37
EA2E: 06 00                             LD      B,00h
EA30: CD 1B E8                          CALL    LE81B
EA33: CC C4 E8                          CALL    Z,LE8C4
EA36: C8                                RET     Z
EA37: CD 50 E8                   LEA37: CALL    LE850
EA3A: DD 35 11                          DEC     (IX+11h)
EA3D: 20 B9                             JR      NZ,LE9F8
EA3F: AF                                XOR     A
EA40: 3C                                INC     A
EA41: C9                                RET

EA42: 0E BF                      LEA42: LD      C,0BFh
EA44: DD 6E 0A                          LD      L,(IX+0Ah)
EA47: DD 66 0B                          LD      H,(IX+0Bh)
EA4A: 3E 5F                             LD      A,5Fh   ; '_'
EA4C: D3 BC                             OUT     (0BCh),A
EA4E: 18 02                             JR      LEA52

EA50: ED A3                      LEA50: OUTI
EA52: DB 3F                      LEA52: IN      A,(3Fh) ; '?'
EA54: 07                                RLCA
EA55: 38 F9                             JR      C,LEA50
EA57: DB 3F                             IN      A,(3Fh) ; '?'
EA59: 07                                RLCA
EA5A: 38 F4                             JR      C,LEA50
EA5C: DB 3F                             IN      A,(3Fh) ; '?'
EA5E: 07                                RLCA
EA5F: 38 EF                             JR      C,LEA50
EA61: DB 3F                             IN      A,(3Fh) ; '?'
EA63: 07                                RLCA
EA64: 38 EA                             JR      C,LEA50
EA66: DB 3F                             IN      A,(3Fh) ; '?'
EA68: 07                                RLCA
EA69: 38 E5                             JR      C,LEA50
EA6B: DB 3F                             IN      A,(3Fh) ; '?'
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

                                        ; --- START PROC LEA7E ---
EA7E: CD 2A E8                   LEA7E: CALL    LE82A
EA81: DD CB 09 6E                       BIT     5,(IX+09h)
EA85: 28 51                             JR      Z,LEAD8
EA87: DD 36 11 05                       LD      (IX+11h),05h
EA8B: DD 36 16 F7                LEA8B: LD      (IX+16h),0F7h
EA8F: 3E FF                             LD      A,0FFh
EA91: DD CB 09 46                       BIT     0,(IX+09h)
EA95: 28 02                             JR      Z,LEA99
EA97: CB AF                             RES     5,A
EA99: DD CB 09 4E                LEA99: BIT     1,(IX+09h)
EA9D: 28 02                             JR      Z,LEAA1
EA9F: CB B7                             RES     6,A
EAA1: DD 77 17                   LEAA1: LD      (IX+17h),A
EAA4: DD 7E 0C                          LD      A,(IX+0Ch)
EAA7: 2F                                CPL
EAA8: DD 77 18                          LD      (IX+18h),A
EAAB: DD 7E 0E                          LD      A,(IX+0Eh)
EAAE: 2F                                CPL
EAAF: DD 77 19                          LD      (IX+19h),A
EAB2: DD 36 1A FE                       LD      (IX+1Ah),0FEh
EAB6: DD 36 1B FF                       LD      (IX+1Bh),0FFh
EABA: 06 06                             LD      B,06h
EABC: CD 24 E8                          CALL    LE824
EABF: 20 09                             JR      NZ,LEACA
EAC1: 06 00                             LD      B,00h
EAC3: CD FE E8                          CALL    LE8FE
EAC6: CC C4 E8                          CALL    Z,LE8C4
EAC9: C8                                RET     Z
EACA: CD 50 E8                   LEACA: CALL    LE850
EACD: CD 59 E8                          CALL    LE859
EAD0: DD 35 11                          DEC     (IX+11h)
EAD3: 20 B6                             JR      NZ,LEA8B
EAD5: AF                                XOR     A
EAD6: 3C                                INC     A
EAD7: C9                                RET

EAD8: 0E BF                      LEAD8: LD      C,0BFh
EADA: DD 6E 0A                          LD      L,(IX+0Ah)
EADD: DD 66 0B                          LD      H,(IX+0Bh)
EAE0: 3E 7F                             LD      A,7Fh   ; ''
EAE2: D3 BC                             OUT     (0BCh),A
EAE4: CD AC E9                          CALL    LE9AC
EAE7: 20 EF                             JR      NZ,LEAD8
EAE9: FE 00                             CP      00h
EAEB: C8                                RET     Z
EAEC: AF                                XOR     A
EAED: 3C                                INC     A
EAEE: C9                                RET

                                        ; --- START PROC LEAEF ---
EAEF: 3E 2F                      LEAEF: LD      A,2Fh   ; '/'
EAF1: D3 BC                             OUT     (0BCh),A
EAF3: CD 21 E8                          CALL    LE821
EAF6: CD 55 EB                          CALL    LEB55
EAF9: 3E FF                             LD      A,0FFh
EAFB: DD 77 16                          LD      (IX+16h),A
EAFE: DD 77 18                          LD      (IX+18h),A
EB01: DD 77 19                          LD      (IX+19h),A
EB04: DD 77 1A                          LD      (IX+1Ah),A
EB07: DD 77 1B                          LD      (IX+1Bh),A
EB0A: DD 36 17 DF                       LD      (IX+17h),0DFh
EB0E: 06 06                             LD      B,06h
EB10: CD 24 E8                          CALL    LE824
EB13: CD C4 E8                          CALL    LE8C4
EB16: 28 17                             JR      Z,LEB2F
EB18: 21 20 EB                          LD      HL,0EB20h
EB1B: CD 09 E0                          CALL    0E009h
EB1E: 18 FE                      LEB1E: JR      LEB1E

EB20: 44 52 49 56 45 20 4E 4F    LEB20: DB      "DRIVE NOT READ"
EB28: 54 20 52 45 41 44
EB2E: D9                                DB      0D9h

                                        ; --- START PROC LEB2F ---
EB2F: 0E 21                      LEB2F: LD      C,21h   ; '!'
                                        ; --- START PROC LEB31 ---
EB31: CD 09 E8                   LEB31: CALL    LE809
EB34: 0E 00                             LD      C,00h
EB36: CD 06 E8                          CALL    LE806
EB39: CD 21 E8                          CALL    LE821
EB3C: CD 00 E8                          CALL    LE800
EB3F: 21 00 01                          LD      HL,0100h
EB42: CD 0C E8                          CALL    LE80C
EB45: DD F9                             LD      SP,IX
EB47: CD 12 E8                          CALL    LE812
EB4A: C2 4D E0                          JP      NZ,0E04Dh
EB4D: C3 00 01                          JP      0100h

                                        ; --- START PROC LEB50 ---
EB50: 0E 20                      LEB50: LD      C,20h   ; ' '
EB52: C3 31 EB                          JP      LEB31

                                        ; --- START PROC LEB55 ---
EB55: 06 98                      LEB55: LD      B,98h
EB57: 18 06                             JR      LEB5F

                                        ; --- START PROC LEB59 ---
EB59: 06 9E                      LEB59: LD      B,9Eh
EB5B: 18 02                             JR      LEB5F

                                        ; --- START PROC LEB5D ---
EB5D: 06 DE                      LEB5D: LD      B,0DEh
                                        ; --- START PROC LEB5F ---
EB5F: DD 21 E0 BF                LEB5F: LD      IX,0BFE0h
EB63: DD 70 10                          LD      (IX+10h),B
EB66: DD 36 11 0F                       LD      (IX+11h),0Fh
EB6A: C9                                RET

                                        ; --- START PROC LEB6B ---
EB6B: DB 3F                      LEB6B: IN      A,(3Fh) ; '?'
EB6D: CB 77                             BIT     6,A
EB6F: 28 FA                             JR      Z,LEB6B
EB71: DB BC                             IN      A,(0BCh)
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
EBBC: D3 BC                             OUT     (0BCh),A
EBBE: CD D5 EB                          CALL    LEBD5
EBC1: DD 7E 0C                          LD      A,(IX+0Ch)
EBC4: 2F                                CPL
EBC5: D3 BF                             OUT     (0BFh),A
EBC7: 3E E3                             LD      A,0E3h
EBC9: D3 BC                             OUT     (0BCh),A
EBCB: CD D5 EB                          CALL    LEBD5
EBCE: DD 7E 0C                          LD      A,(IX+0Ch)
EBD1: 2F                                CPL
EBD2: D3 BD                             OUT     (0BDh),A
EBD4: C9                                RET

                                        ; --- START PROC LEBD5 ---
EBD5: DB 3F                      LEBD5: IN      A,(3Fh) ; '?'
EBD7: CB 77                             BIT     6,A
EBD9: 28 FA                             JR      Z,LEBD5
EBDB: DB BC                             IN      A,(0BCh)
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
EBEB: DB 3F                      LEBEB: IN      A,(3Fh) ; '?'
EBED: CB 77                             BIT     6,A
EBEF: 28 FA                             JR      Z,LEBEB
EBF1: DB BC                             IN      A,(0BCh)
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

references to external address 0E009h:
        EB1B CALL 0E009h

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
        E9AC IN A,(3Fh)
        E9B1 IN A,(3Fh)
        E9B6 IN A,(3Fh)
        E9BB IN A,(3Fh)
        EA52 IN A,(3Fh)
        EA57 IN A,(3Fh)
        EA5C IN A,(3Fh)
        EA61 IN A,(3Fh)
        EA66 IN A,(3Fh)
        EA6B IN A,(3Fh)
        EB6B IN A,(3Fh)
        EBD5 IN A,(3Fh)
        EBEB IN A,(3Fh)
        E986 OUT (3Fh),A

references to port 6Ch
        E8DA IN A,(6Ch)
        E887 OUT (6Ch),A

references to port 6Dh
        E87F IN A,(6Dh)
        E891 IN A,(6Dh)
        E89B IN A,(6Dh)
        E8A1 IN A,(6Dh)
        E8C8 IN A,(6Dh)
        E8CE IN A,(6Dh)
        E8E1 IN A,(6Dh)
        E8E6 IN A,(6Dh)
        E904 IN A,(6Dh)
        E91D IN A,(6Dh)
        E852 OUT (6Dh),A
        E856 OUT (6Dh),A
        E88B OUT (6Dh),A
        E88F OUT (6Dh),A
        E899 OUT (6Dh),A
        E8B7 OUT (6Dh),A
        E8BD OUT (6Dh),A
        E8C1 OUT (6Dh),A
        E8C6 OUT (6Dh),A
        E8F7 OUT (6Dh),A
        E8FB OUT (6Dh),A

references to port 0BCh
        EB71 IN A,(0BCh)
        EBDB IN A,(0BCh)
        EBF1 IN A,(0BCh)
        E848 OUT (0BCh),A
        E94E OUT (0BCh),A
        E95E OUT (0BCh),A
        E994 OUT (0BCh),A
        EA4C OUT (0BCh),A
        EAE2 OUT (0BCh),A
        EAF1 OUT (0BCh),A
        EBBC OUT (0BCh),A
        EBC9 OUT (0BCh),A

references to port 0BDh
        E959 OUT (0BDh),A
        E9A3 OUT (0BDh),A
        EBD2 OUT (0BDh),A

references to port 0BEh
        E972 OUT (0BEh),A

references to port 0BFh
        E940 OUT (0BFh),A
        EBC5 OUT (0BFh),A

Procedures (50):
  Proc  Length  References Dependants
  LE800  0003            2          1
  LE803  0003            0          1
  LE806  0003            1          1
  LE809  0003            1          1
  LE80C  0003            1          1
  LE80F  0003            0          1
  LE812  0003            1          1
  LE815  0003            0          1
  LE818  0003            0          1
  LE81B  0003            1          1
  LE81E  0003            0          1
  LE821  0003            2          1
  LE824  0003            4          1
  LE827  0003            5          1
  LE82A  0003            2          1
  LE82D  0003            1          1
  LE830  0020            1          2
  LE850  0009            3          0
  LE859  001F            1          2
  LE878  0030            1          2
  LE8A1  0007            2          2
  LE8A7  0003            2          0
  LE8AA  0011            1          2
  LE8BB  0009            2          0
  LE8C4  0031            5          1
  LE8F5  0009            3          0
  LE8FE  0019            1          2
  LE917  001A            1          2
  LE931  0034            1          3
  LE965  0010            1          1
  LE975  0035            1          5
  LE9AA  0004            4          1
  LE9AC  001A            3          2
  LE9C6  001B            1          0
  LE9E1  000A            1          1
  LE9EB  0093            1          6
  LEA7E  0071            1          7
  LEAEF  0045            1          7
  LEB2F  0005            1          1
  LEB31  001F            1          8
  LEB50  0005            1          1
  LEB55  0004            2          1
  LEB59  0004            1          1
  LEB5D  0006            1          1
  LEB5F  000C            2          0
  LEB6B  004F            5          3
  LEBBA  001B            2          1
  LEBD5  0009            4          0
  LEBDE  000D            0          0
  LEBEB  0015            1          2

Call Graph:
LE800 - Entry Point
  LE830
    LE827
      LEB55
        LEB5F
    LEB6B
      0E003h - External
      0E015h - External
      LEBBA
        LEBD5
LE803 - Entry Point
  LE931
    LE827
      LEB55
        LEB5F
    LEB6B
      0E003h - External
      0E015h - External
      LEBBA
        LEBD5
    LEBD5
LE806 - Entry Point
  LE965
    LE827
      LEB55
        LEB5F
LE809 - Entry Point
  LE975
    LE827
      LEB55
        LEB5F
    LE9C6
    LE82A
      LEB59
        LEB5F
    LE9AC
      LE9AA
        LE9AC - Recursive
      LEB6B
        0E003h - External
        0E015h - External
        LEBBA
          LEBD5
    LE800
      LE830
        LE827
          LEB55
            LEB5F
        LEB6B
          0E003h - External
          0E015h - External
          LEBBA
            LEBD5
LE80C - Entry Point
  LE9E1
    LE827
      LEB55
        LEB5F
LE80F - Entry Point
  LE9EB
    LE82D
      LEB5D
        LEB5F
    LE824
      LE878
        LE8AA
          LE8A1
            LE8AA - Recursive
            LE8A7
          LE8BB
        LE8A7
    LE81B
      LE917
        LE8A7
        LE8BB
    LE8C4
      LE8F5
    LE850
    LEB6B
      0E003h - External
      0E015h - External
      LEBBA
        LEBD5
LE812 - Entry Point
  LEA7E
    LE82A
      LEB59
        LEB5F
    LE824
      LE878
        LE8AA
          LE8A1
            LE8AA - Recursive
            LE8A7
          LE8BB
        LE8A7
    LE8FE
      LE8A7
      LE8F5
    LE8C4
      LE8F5
    LE850
    LE859
      LE824
        LE878
          LE8AA
            LE8A1
              LE8AA - Recursive
              LE8A7
            LE8BB
          LE8A7
      LE8C4
        LE8F5
    LE9AC
      LE9AA
        LE9AC - Recursive
      LEB6B
        0E003h - External
        0E015h - External
        LEBBA
          LEBD5
LE815 - Entry Point
  LEB50
    LEB31
      LE809
        LE975
          LE827
            LEB55
              LEB5F
          LE9C6
          LE82A
            LEB59
              LEB5F
          LE9AC
            LE9AA
              LE9AC - Recursive
            LEB6B
              0E003h - External
              0E015h - External
              LEBBA
                LEBD5
          LE800
            LE830
              LE827
                LEB55
                  LEB5F
              LEB6B
                0E003h - External
                0E015h - External
                LEBBA
                  LEBD5
      LE806
        LE965
          LE827
            LEB55
              LEB5F
      LE821
        LE850
      LE800
        LE830
          LE827
            LEB55
              LEB5F
          LEB6B
            0E003h - External
            0E015h - External
            LEBBA
              LEBD5
      LE80C
        LE9E1
          LE827
            LEB55
              LEB5F
      LE812
        LEA7E
          LE82A
            LEB59
              LEB5F
          LE824
            LE878
              LE8AA
                LE8A1
                  LE8AA - Recursive
                  LE8A7
                LE8BB
              LE8A7
          LE8FE
            LE8A7
            LE8F5
          LE8C4
            LE8F5
          LE850
          LE859
            LE824
              LE878
                LE8AA
                  LE8A1
                    LE8AA - Recursive
                    LE8A7
                  LE8BB
                LE8A7
            LE8C4
              LE8F5
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
  LEAEF
    LE821
      LE850
    LEB55
      LEB5F
    LE824
      LE878
        LE8AA
          LE8A1
            LE8AA - Recursive
            LE8A7
          LE8BB
        LE8A7
    LE8C4
      LE8F5
    LEB2F
      LEB31
        LE809
          LE975
            LE827
              LEB55
                LEB5F
            LE9C6
            LE82A
              LEB59
                LEB5F
            LE9AC
              LE9AA
                LE9AC - Recursive
              LEB6B
                0E003h - External
                0E015h - External
                LEBBA
                  LEBD5
            LE800
              LE830
                LE827
                  LEB55
                    LEB5F
                LEB6B
                  0E003h - External
                  0E015h - External
                  LEBBA
                    LEBD5
        LE806
          LE965
            LE827
              LEB55
                LEB5F
        LE821
          LE850
        LE800
          LE830
            LE827
              LEB55
                LEB5F
            LEB6B
              0E003h - External
              0E015h - External
              LEBBA
                LEBD5
        LE80C
          LE9E1
            LE827
              LEB55
                LEB5F
        LE812
          LEA7E
            LE82A
              LEB59
                LEB5F
            LE824
              LE878
                LE8AA
                  LE8A1
                    LE8AA - Recursive
                    LE8A7
                  LE8BB
                LE8A7
            LE8FE
              LE8A7
              LE8F5
            LE8C4
              LE8F5
            LE850
            LE859
              LE824
                LE878
                  LE8AA
                    LE8A1
                      LE8AA - Recursive
                      LE8A7
                    LE8BB
                  LE8A7
              LE8C4
                LE8F5
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
    0E009h - External
    LEB31
      LE809
        LE975
          LE827
            LEB55
              LEB5F
          LE9C6
          LE82A
            LEB59
              LEB5F
          LE9AC
            LE9AA
              LE9AC - Recursive
            LEB6B
              0E003h - External
              0E015h - External
              LEBBA
                LEBD5
          LE800
            LE830
              LE827
                LEB55
                  LEB5F
              LEB6B
                0E003h - External
                0E015h - External
                LEBBA
                  LEBD5
      LE806
        LE965
          LE827
            LEB55
              LEB5F
      LE821
        LE850
      LE800
        LE830
          LE827
            LEB55
              LEB5F
          LEB6B
            0E003h - External
            0E015h - External
            LEBBA
              LEBD5
      LE80C
        LE9E1
          LE827
            LEB55
              LEB5F
      LE812
        LEA7E
          LE82A
            LEB59
              LEB5F
          LE824
            LE878
              LE8AA
                LE8A1
                  LE8AA - Recursive
                  LE8A7
                LE8BB
              LE8A7
          LE8FE
            LE8A7
            LE8F5
          LE8C4
            LE8F5
          LE850
          LE859
            LE824
              LE878
                LE8AA
                  LE8A1
                    LE8AA - Recursive
                    LE8A7
                  LE8BB
                LE8A7
            LE8C4
              LE8F5
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
    LE8A7
    LE8BB
LE81E - Entry Point
  0000h - External
LEBDE - Entry Point
LEBEB - Entry Point
  0EC21h - External
  0E003h - External
