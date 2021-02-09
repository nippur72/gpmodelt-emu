                                        ; Entry Point
                                        ; --- START PROC L0100 ---
0100: 31 80 00                   L0100: LD      SP,0080h
0103: 0E 21                             LD      C,21h   ; '!'
0105: CD 09 E8                          CALL    0E809h
0108: CD 00 E8                          CALL    0E800h
010B: 06 1A                             LD      B,1Ah
010D: 0E 00                             LD      C,00h
010F: 16 01                             LD      D,01h
0111: 21 00 A4                          LD      HL,0A400h
                                        ; --- START PROC L0114 ---
0114: C5                         L0114: PUSH    BC
0115: D5                                PUSH    DE
0116: E5                                PUSH    HL
0117: 4A                                LD      C,D
0118: CD 06 E8                          CALL    0E806h
011B: E1                                POP     HL
011C: E5                                PUSH    HL
011D: CD 0C E8                          CALL    0E80Ch
0120: CD B1 01                          CALL    L01B1
0123: E1                                POP     HL
0124: 11 00 01                          LD      DE,0100h
0127: 19                                ADD     HL,DE
0128: D1                                POP     DE
0129: C1                                POP     BC
012A: 05                                DEC     B
012B: CA 44 01                          JP      Z,L0144
012E: 14                                INC     D
012F: 7A                                LD      A,D
0130: FE 10                             CP      10h
0132: C3 14 01                          JP      L0114

                                        ; Entry Point
                                        ; --- START PROC L0135 ---
0135: 16 00                      L0135: LD      D,00h
0137: 0C                                INC     C
0138: C5                                PUSH    BC
0139: D5                                PUSH    DE
013A: E5                                PUSH    HL
013B: CD 03 E8                          CALL    0E803h
013E: E1                                POP     HL
013F: D1                                POP     DE
0140: C1                                POP     BC
0141: C3 14 01                          JP      L0114

                                        ; --- START PROC L0144 ---
0144: 00                         L0144: NOP
0145: 00                                NOP
0146: 00                                NOP
0147: C3 C0 01                          JP      L01C0

014A: 00                         L014A: DB      00h
014B: 00                                DB      00h
014C: 00                                DB      00h
014D: 0C                                DB      0Ch
014E: 09                                DB      09h
014F: 20                                DB      20h     ; ' '
0150: 09                                DB      09h
0151: 09                                DB      09h
0152: 47 20 45 20 4E 20 45 20           DB      "G E N E R A L   P R O C E S S O R"
015A: 52 20 41 20 4C 20 20 20
0162: 50 20 52 20 4F 20 43 20
016A: 45 20 53 20 53 20 4F 20
0172: 52
0173: 0D                                DB      0Dh
0174: 0A                                DB      0Ah
0175: 0A                                DB      0Ah
0176: 0A                                DB      0Ah
0177: 09                                DB      09h
0178: 09                                DB      09h
0179: 09                                DB      09h
017A: 44 72 69 76 65 20 64 69           DB      "Drive disponibili:"
0182: 73 70 6F 6E 69 62 69 6C
018A: 69 3A
018C: 0D                                DB      0Dh
018D: 0A                                DB      0Ah
018E: 0A                                DB      0Ah
018F: 41                                DB      41h     ; 'A'
0190: 09                                DB      09h
0191: 52 69 67 2E 20 49                 DB      "Rig. I"
0197: 09                                DB      09h
0198: 09                                DB      09h
0199: 42                                DB      42h     ; 'B'
019A: 09                                DB      09h
019B: 62 61 63 6B 2D 75 70              DB      "back-up"
01A2: 09                                DB      09h
01A3: 09                                DB      09h
01A4: 43                                DB      43h     ; 'C'
01A5: 09                                DB      09h
01A6: 52 69 67 2E 20 49 49              DB      "Rig. II"
01AD: 0D                                DB      0Dh
01AE: 0A                                DB      0Ah
01AF: 0A                                DB      0Ah
01B0: A0                                DB      0A0h

                                        ; --- START PROC L01B1 ---
01B1: CD 12 E8                   L01B1: CALL    0E812h
01B4: C8                                RET     Z
01B5: 00                                NOP
01B6: 00                                NOP
01B7: 00                                NOP
01B8: 21 E0 01                          LD      HL,01E0h
01BB: CD 09 E0                          CALL    0E009h
01BE: 18 FE                      L01BE: JR      L01BE

                                        ; --- START PROC L01C0 ---
01C0: 00                         L01C0: NOP
01C1: 00                                NOP
01C2: 00                                NOP
01C3: 00                                NOP
01C4: 21 4D 01                          LD      HL,014Dh
01C7: CD 09 E0                          CALL    0E009h
01CA: C3 00 BA                          JP      0BA00h

01CD: 01                         L01CD: DB      01h
01CE: 80                                DB      80h
01CF: AC                                DB      0ACh
01D0: 00                                DB      00h
01D1: 00                                DB      00h
01D2: 00                                DB      00h
01D3: 00                                DB      00h
01D4: 00                                DB      00h
01D5: 00                                DB      00h
01D6: 00                                DB      00h
01D7: 00                                DB      00h
01D8: 00                                DB      00h
01D9: 00                                DB      00h
01DA: 00                                DB      00h
01DB: 00                                DB      00h
01DC: 00                                DB      00h
01DD: 00                                DB      00h
01DE: 00                                DB      00h
01DF: 00                                DB      00h
01E0: 45 72 72 6F 72 65 20 64           DB      "Errore di caricamento DOS"
01E8: 69 20 63 61 72 69 63 61
01F0: 6D 65 6E 74 6F 20 44 4F
01F8: 53
01F9: 00                                DB      00h
01FA: 00                                DB      00h
01FB: 00                                DB      00h
01FC: 00                                DB      00h
01FD: 00                                DB      00h
01FE: 00                                DB      00h
01FF: 00                                DB      00h

references to external address 0BA00h:
        01CA JP 0BA00h

references to external address 0E009h:
        01BB CALL 0E009h
        01C7 CALL 0E009h

references to external address 0E800h:
        0108 CALL 0E800h

references to external address 0E803h:
        013B CALL 0E803h

references to external address 0E806h:
        0118 CALL 0E806h

references to external address 0E809h:
        0105 CALL 0E809h

references to external address 0E80Ch:
        011D CALL 0E80Ch

references to external address 0E812h:
        01B1 CALL 0E812h

possible references to internal address 0100:
        0124 LD DE,0100h

possible references to internal address 014D:
        01C4 LD HL,014Dh

possible references to internal address 01E0:
        01B8 LD HL,01E0h

possible references to external address 0080h:
        0100 LD SP,0080h

possible references to external address 0A400h:
        0111 LD HL,0A400h

Procedures (6):
  Proc  Length  References Dependants
  L0100  0035            0          6
  L0114  0021            2          4
  L0135  000F            0          2
  L0144  0006            1          1
  L01B1  000F            1          2
  L01C0  000D            1          2

Call Graph:
L0100 - Entry Point
  0E809h - External
  0E800h - External
  0E806h - External
  0E80Ch - External
  L01B1
    0E812h - External
    0E009h - External
  L0144
    L01C0
      0E009h - External
      0BA00h - External
L0135 - Entry Point
  0E803h - External
  L0114
    0E806h - External
    0E80Ch - External
    L01B1
      0E812h - External
      0E009h - External
    L0144
      L01C0
        0E009h - External
        0BA00h - External
