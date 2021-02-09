E400: AF                                XOR     A
E401: 32 03 00                          LD      (0003h),A
E404: 32 04 00                          LD      (0004h),A
E407: C3 51 E4                          JP      LE451

E40A: 31 80 00                   LE40A: LD      SP,0080h
E40D: 0E 21                             LD      C,21h   ; '!'
E40F: CD 09 E8                          CALL    0E809h
E412: CD 00 E8                          CALL    LE7FF+1 ; reference not aligned to instruction
E415: 0E 00                             LD      C,00h
E417: 06 16                             LD      B,16h
E419: 16 01                             LD      D,01h
E41B: 21 00 A4                          LD      HL,0A400h
E41E: C5                         LE41E: PUSH    BC
E41F: D5                                PUSH    DE
E420: E5                                PUSH    HL
E421: 4A                                LD      C,D
E422: CD 06 E8                          CALL    0E806h
E425: C1                                POP     BC
E426: C5                                PUSH    BC
E427: CD 0C E8                          CALL    0E80Ch
E42A: CD 12 E8                   LE42A: CALL    0E812h
E42D: C2 2A E4                          JP      NZ,LE42A
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
E448: CD 03 E8                          CALL    LE7FF+4 ; reference not aligned to instruction
E44B: E1                                POP     HL
E44C: D1                                POP     DE
E44D: C1                                POP     BC
E44E: C3 1E E4                          JP      LE41E

E451: AF                         LE451: XOR     A
E452: 32 96 BB                          LD      (0BB96h),A
E455: 32 9B BB                          LD      (0BB9Bh),A
E458: 21 88 E4                          LD      HL,0E488h
E45B: CD 09 E0                          CALL    0E009h
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
E4C0: CD 0F E8                   LE4C0: CALL    0E80Fh
E4C3: C2 E3 E4                          JP      NZ,LE4E3
E4C6: 2A EA BF                          LD      HL,(0BFEAh)
E4C9: E5                                PUSH    HL
E4CA: 21 00 FE                   LE4CA: LD      HL,0FE00h
E4CD: 22 EA BF                          LD      (0BFEAh),HL
E4D0: CD 12 E8                          CALL    0E812h
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
E4FE: CD 12 E8                          CALL    0E812h
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
E546: DD BE 09                          CP      (IX+09h)
E549: 32 E9 BF                          LD      (0BFE9h),A
E54C: C4 09 E8                          CALL    NZ,0E809h
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
E57B: CD 06 E8                          CALL    0E806h
E57E: C1                                POP     BC
E57F: 78                                LD      A,B
E580: 4F                                LD      C,A
E581: DD BE 0C                          CP      (IX+0Ch)
E584: 32 EC BF                          LD      (0BFECh),A
E587: C4 03 E8                          CALL    NZ,LE7FF+4      ; reference not aligned to instruction
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
E5B2: CD 03 E0                          CALL    0E003h
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
E5E1: CD 0C E0                          CALL    0E00Ch
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
E7D4: 30 63                             JR      NC,0E839h
E7D6: 30 68                             JR      NC,0E840h
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
E7E3: 20 6E                             JR      NZ,0E853h
E7E5: 6F                                LD      L,A
E7E6: 2C                                INC     L
E7E7: 20 72                             JR      NZ,0E85Bh
E7E9: 69                                LD      L,C
E7EA: 74                                LD      (HL),H
E7EB: 6F                                LD      L,A
E7EC: 72                                LD      (HL),D
E7ED: 6E                                LD      L,(HL)
E7EE: 61                                LD      H,C
E7EF: 0D                                DEC     C
E7F0: 0A                                LD      A,(BC)
E7F1: 3B                                DEC     SP
E7F2: 20 63                             JR      NZ,0E857h
E7F4: 69                                LD      L,C
E7F5: 63                                LD      H,E
E7F6: 6C                                LD      L,H
E7F7: 6F                                LD      L,A
E7F8: 20 64                             JR      NZ,0E85Eh
E7FA: 69                                LD      L,C
E7FB: 20 69                             JR      NZ,0E866h
E7FD: 6E                                LD      L,(HL)
E7FE: 76                                HALT
E7FF: 65                         LE7FF: LD      H,L

references to external address 0000h:
        E460 LD (0000h),A
        E561 LD HL,0000h
        E641 LD BC,0000h
        E647 LD BC,0000h
        E658 LD HL,0000h

references to external address 0001h:
        E466 LD (0001h),HL

references to external address 0003h:
        E401 LD (0003h),A
        E5A2 LD A,(0003h)
        E5CB LD A,(0003h)
        E5E7 LD A,(0003h)

references to external address 0004h:
        E404 LD (0004h),A
        E481 LD A,(0004h)

references to external address 0005h:
        E469 LD (0005h),A

references to external address 0006h:
        E46F LD (0006h),HL

references to external address 0A400h:
        E41B LD HL,0A400h
        E485 JP 0A400h

references to external address 0BA54h:
        E4BC LD A,(0BA54h)

references to external address 0BB40h:
        E60F JP 0BB40h

references to external address 0BB54h:
        E5F1 JP Z,0BB54h

references to external address 0BB82h:
        E50E LD IY,0BB82h
        E523 LD (0BB82h),DE

references to external address 0BB87h:
        E50B LD A,(0BB87h)
        E65F LD (0BB87h),A
        E6C3 LD A,(0BB87h)
        E6E0 LD A,(0BB87h)
        E747 LD A,(0BB87h)
        E76B LD A,(0BB87h)

references to external address 0BB88h:
        E4A8 LD HL,0BB88h
        E679 LD (0BB88h),HL
        E6C9 LD HL,(0BB88h)
        E771 LD HL,(0BB88h)

references to external address 0BB8Ah:
        E67F LD (0BB8Ah),HL
        E6CF LD A,(0BB8Ah)
        E6F3 LD A,(0BB8Ah)
        E727 LD HL,(0BB8Ah)
        E792 LD A,(0BB8Ah)

references to external address 0BB8Eh:
        E52C LD A,(0BB8Eh)
        E74A LD HL,0BB8Eh
        E76E LD (0BB8Eh),A

references to external address 0BB8Fh:
        E528 LD A,(0BB8Fh)
        E751 LD HL,0BB8Fh
        E774 LD (0BB8Fh),HL

references to external address 0BB91h:
        E555 LD A,(0BB91h)
        E75D LD HL,0BB91h
        E77A LD (0BB91h),A

references to external address 0BB95h:
        E73A LD (0BB95h),A
        E75A LD A,(0BB95h)
        E777 LD A,(0BB95h)

references to external address 0BB96h:
        E452 LD (0BB96h),A
        E654 LD (0BB96h),A
        E73D LD HL,0BB96h

references to external address 0BB97h:
        E64D LD A,(0BB97h)
        E764 LD A,(0BB97h)
        E785 LD (0BB97h),A
        E7B1 LD (0BB97h),A
        E7C9 LD (0BB97h),A

references to external address 0BB9Bh:
        E455 LD (0BB9Bh),A
        E69B LD (0BB9Bh),A
        E6C0 LD (0BB9Bh),A
        E6D5 LD A,(0BB9Bh)
        E6DD LD (0BB9Bh),A
        E715 LD (0BB9Bh),A

references to external address 0BB9Ch:
        E6C6 LD (0BB9Ch),A
        E6E3 LD HL,0BB9Ch

references to external address 0BB9Dh:
        E6CC LD (0BB9Dh),HL
        E6EA LD HL,0BB9Dh
        E706 LD HL,(0BB9Dh)
        E70A LD (0BB9Dh),HL

references to external address 0BB9Fh:
        E6D2 LD (0BB9Fh),A
        E6F6 LD HL,0BB9Fh

references to external address 0BBA3h:
        E4E6 LD (0BBA3h),A
        E4EF LD (0BBA3h),A
        E501 LD (0BBA3h),A
        E724 LD (0BBA3h),A
        E7C2 LD A,(0BBA3h)
        E7CF LD A,(0BBA3h)

references to external address 0BBA4h:
        E6A3 LD (0BBA4h),A
        E70E LD (0BBA4h),A
        E720 LD (0BBA4h),A
        E77D LD A,(0BBA4h)

references to external address 0BBA5h:
        E6A0 LD (0BBA5h),A
        E6B2 LD (0BBA5h),A
        E7A8 LD A,(0BBA5h)

references to external address 0BBA6h:
        E6A8 LD (0BBA6h),A
        E6B6 LD (0BBA6h),A
        E7BD LD A,(0BBA6h)

references to external address 0BBA7h:
        E693 LD (0BBA7h),HL
        E7A3 LD HL,(0BBA7h)

references to external address 0BFD0h:
        E617 LD (0BFD0h),SP
        E62A LD SP,0BFD0h
        E630 LD SP,(0BFD0h)

references to external address 0BFD2h:
        E61B LD (0BFD2h),HL
        E63D LD HL,(0BFD2h)

references to external address 0BFD4h:
        E61E LD (0BFD4h),DE
        E639 LD DE,(0BFD4h)

references to external address 0BFD6h:
        E622 LD (0BFD6h),BC
        E635 LD BC,(0BFD6h)

references to external address 0BFD8h:
        E626 LD (0BFD8h),A

references to external address 0BFDCh:
        E65C LD (0BFDCh),A
        E668 LD A,(0BFDCh)

references to external address 0BFE9h:
        E549 LD (0BFE9h),A
        E58B LD A,(0BFE9h)

references to external address 0BFEAh:
        E4C6 LD HL,(0BFEAh)
        E4CD LD (0BFEAh),HL
        E4D4 LD (0BFEAh),HL
        E515 LD (0BFEAh),HL

references to external address 0BFECh:
        E584 LD (0BFECh),A

references to external address 0E003h:
        E5B2 CALL 0E003h

references to external address 0E009h:
        E45B CALL 0E009h

references to external address 0E00Ch:
        E5E1 CALL 0E00Ch

references to external address 0E800h:
        E412 CALL LE7FF+1

references to external address 0E803h:
        E448 CALL LE7FF+4
        E587 CALL NZ,LE7FF+4

references to external address 0E806h:
        E422 CALL 0E806h
        E57B CALL 0E806h

references to external address 0E809h:
        E40F CALL 0E809h
        E54C CALL NZ,0E809h

references to external address 0E80Ch:
        E427 CALL 0E80Ch

references to external address 0E80Fh:
        E4C0 CALL 0E80Fh

references to external address 0E812h:
        E42A CALL 0E812h
        E4D0 CALL 0E812h
        E4FE CALL 0E812h

possible references to internal address E488:
        E458 LD HL,0E488h

possible references to external address 0000h:
        E561 LD HL,0000h
        E641 LD BC,0000h
        E647 LD BC,0000h
        E658 LD HL,0000h
        ----------
        E460 LD (0000h),A

possible references to external address 0080h:
        E40A LD SP,0080h
        E472 LD BC,0080h

possible references to external address 0100h:
        E431 LD DE,0100h

possible references to external address 0A400h:
        E41B LD HL,0A400h
        ----------
        E485 JP 0A400h

possible references to external address 0AC06h:
        E46C LD HL,0AC06h

possible references to external address 0BA03h:
        E463 LD HL,0BA03h

possible references to external address 0BA55h:
        E478 LD HL,0BA55h

possible references to external address 0BA61h:
        E518 LD HL,0BA61h

possible references to external address 0BA6Bh:
        E672 LD DE,0BA6Bh

possible references to external address 0BB82h:
        E50E LD IY,0BB82h
        ----------
        E523 LD (0BB82h),DE

possible references to external address 0BB88h:
        E4A8 LD HL,0BB88h
        ----------
        E679 LD (0BB88h),HL
        E6C9 LD HL,(0BB88h)
        E771 LD HL,(0BB88h)

possible references to external address 0BB8Eh:
        E74A LD HL,0BB8Eh
        ----------
        E52C LD A,(0BB8Eh)
        E76E LD (0BB8Eh),A

possible references to external address 0BB8Fh:
        E751 LD HL,0BB8Fh
        ----------
        E528 LD A,(0BB8Fh)
        E774 LD (0BB8Fh),HL

possible references to external address 0BB91h:
        E75D LD HL,0BB91h
        ----------
        E555 LD A,(0BB91h)
        E77A LD (0BB91h),A

possible references to external address 0BB96h:
        E73D LD HL,0BB96h
        ----------
        E452 LD (0BB96h),A
        E654 LD (0BB96h),A

possible references to external address 0BB9Ch:
        E6E3 LD HL,0BB9Ch
        ----------
        E6C6 LD (0BB9Ch),A

possible references to external address 0BB9Dh:
        E6EA LD HL,0BB9Dh
        ----------
        E6CC LD (0BB9Dh),HL
        E706 LD HL,(0BB9Dh)
        E70A LD (0BB9Dh),HL

possible references to external address 0BB9Fh:
        E6F6 LD HL,0BB9Fh
        ----------
        E6D2 LD (0BB9Fh),A

possible references to external address 0BBACh:
        E512 LD HL,0BBACh
        E593 LD HL,0BBACh
        E788 LD DE,0BBACh

possible references to external address 0BFD0h:
        E62A LD SP,0BFD0h
        ----------
        E617 LD (0BFD0h),SP
        E630 LD SP,(0BFD0h)

possible references to external address 0FE00h:
        E4CA LD HL,0FE00h

possible references to external address 0FFE0h:
        E601 LD IY,0FFE0h

references to port 5Dh
        E5FD IN A,(5Dh)

references to port 78h
        E5C3 OUT (78h),A

references to port 7Ah
        E5BB IN A,(7Ah)
        E5B9 OUT (7Ah),A

Procedures (13):
  Proc  Length  References Dependants
  LE4A7  000C            2          0
  LE4B3  0045            2          6
  LE4F8  0012            2          5
  LE507  0004            4          1
  LE50B  0010            2          1
  LE518  0010            1          0
  LE528  0063            2          4
  LE58B  0014            3          0
  LE617  0018            4          0
  LE62F  0012            1          0
  LE677  0006            1          0
  LE67D  0006            1          0
  LE691  0006            1          0

Call Graph:
