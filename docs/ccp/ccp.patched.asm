
[m[32m]9;8;"USERNAME"\@]9;8;"COMPUTERNAME"\ [92mC:\Users\Nino1\Desktop\USB\GitHub\gpmodelt-emu\docs\ccp[90m
[90m$[m ]9;12\rem ..\..\..\..\z80\yazd\yazd.exe --addr:0xA400 --xref --lst --lowercase --mwr GP16_IMD.dsk.side0.ccp.bin 

[m[32m]9;8;"USERNAME"\@]9;8;"COMPUTERNAME"\ [92mC:\Users\Nino1\Desktop\USB\GitHub\gpmodelt-emu\docs\ccp[90m
[90m$[m ]9;12\..\..\..\..\z80\yazd\yazd.exe --addr:0xA400 --xref --lst --lowercase --mwr ccp.patched.bin 
                                        ; Referenced from A7D2, BB4D
A400: C3 5C A7                   LA400: jp      LA75C

A403: C3 58 A7                   LA403: jp      LA758

A406: 7F                         LA406: ld      a,a

                                        ; Referenced from A759, A77B
A407: 00                         LA407: nop
A408: 20 20                             jr      nz,LA42A
A40A: 20 20                             jr      nz,LA42B+1      ; reference not aligned to instruction
A40C: 20 20                             jr      nz,LA42E
A40E: 20 20                             jr      nz,LA430
A410: 20 20                             jr      nz,LA432
A412: 20 20                             jr      nz,LA433+1      ; reference not aligned to instruction
A414: 20 20                             jr      nz,LA436
A416: 20 20                             jr      nz,LA438
A418: 43                                ld      b,e
A419: 4F                                ld      c,a
A41A: 50                                ld      d,b
A41B: 59                                ld      e,c
A41C: 52                                ld      d,d
A41D: 49                                ld      c,c
A41E: 47                                ld      b,a
A41F: 48                                ld      c,b
A420: 54                                ld      d,h
A421: 20 28                             jr      nz,LA44B
A423: 43                                ld      b,e
A424: 29                                add     hl,hl
A425: 20 31                             jr      nz,LA458
A427: 39                                add     hl,sp
A428: 37                                scf
A429: 39                                add     hl,sp

                                        ; Referenced from A408
A42A: 2C                         LA42A: inc     l

                                        ; Referenced from A40A
A42B: 20 44                      LA42B: jr      nz,LA471
A42D: 49                                ld      c,c

                                        ; Referenced from A40C
A42E: 47                         LA42E: ld      b,a
A42F: 49                                ld      c,c

                                        ; Referenced from A40E
A430: 54                         LA430: ld      d,h
A431: 41                                ld      b,c

                                        ; Referenced from A410
A432: 4C                         LA432: ld      c,h

                                        ; Referenced from A412
A433: 20 52                      LA433: jr      nz,LA487
A435: 45                                ld      b,l

                                        ; Referenced from A414
A436: 53                         LA436: ld      d,e
A437: 45                                ld      b,l

                                        ; Referenced from A416
A438: 41                         LA438: ld      b,c
A439: 52                                ld      d,d
A43A: 43                                ld      b,e
A43B: 48                                ld      c,b
A43C: 20 20                             jr      nz,LA45E
A43E: 00                                nop
A43F: 00                                nop
A440: 00                                nop
A441: 00                                nop
A442: 00                                nop
A443: 00                                nop
A444: 00                                nop
A445: 00                                nop
A446: 00                                nop
A447: 00                                nop
A448: 00                                nop
A449: 00                                nop
A44A: 00                                nop

                                        ; Referenced from A421
A44B: 00                         LA44B: nop
A44C: 00                                nop
A44D: 00                                nop
A44E: 00                                nop
A44F: 00                                nop
A450: 00                                nop
A451: 00                                nop
A452: 00                                nop
A453: 00                                nop
A454: 00                                nop
A455: 00                                nop
A456: 00                                nop
A457: 00                                nop

                                        ; Referenced from A425
A458: 00                         LA458: nop
A459: 00                                nop
A45A: 00                                nop
A45B: 00                                nop
A45C: 00                                nop
A45D: 00                                nop

                                        ; Referenced from A43C
A45E: 00                         LA45E: nop
A45F: 00                                nop
A460: 00                                nop
A461: 00                                nop
A462: 00                                nop
A463: 00                                nop
A464: 00                                nop
A465: 00                                nop
A466: 00                                nop
A467: 00                                nop
A468: 00                                nop
A469: 00                                nop
A46A: 00                                nop
A46B: 00                                nop
A46C: 00                                nop
A46D: 00                                nop
A46E: 00                                nop
A46F: 00                                nop
A470: 00                                nop

                                        ; Referenced from A42B
A471: 00                         LA471: nop
A472: 00                                nop
A473: 00                                nop
A474: 00                                nop
A475: 00                                nop
A476: 00                                nop
A477: 00                                nop
A478: 00                                nop
A479: 00                                nop
A47A: 00                                nop
A47B: 00                                nop
A47C: 00                                nop
A47D: 00                                nop
A47E: 00                                nop
A47F: 00                                nop
A480: 00                                nop
A481: 00                                nop
A482: 00                                nop
A483: 00                                nop
A484: 00                                nop
A485: 00                                nop
A486: 00                                nop

                                        ; Referenced from A433
A487: 00                         LA487: nop

                                        ; Referenced from A5BE, A66C, A6FA, A93F, AA2E, AA41
A488: 08                         LA488: ex      af,af'
A489: A4                                and     h

                                        ; Referenced from A60C, A674
A48A: 00                         LA48A: nop
A48B: 00                                nop

                                        ; Referenced from A493, A4B1, A61A, A624, A78D, A792, A994
                                        ; --- START PROC LA48C ---
A48C: 5F                         LA48C: ld      e,a
A48D: 0E 02                             ld      c,02h
A48F: C3 05 00                          jp      0005h

                                        ; Referenced from A49A, A49F, A4A4, A8C1, A8C6, A8D1, A8F9
                                        ; --- START PROC LA492 ---
A492: C5                         LA492: push    bc
A493: CD 8C A4                          call    LA48C
A496: C1                                pop     bc
A497: C9                                ret

                                        ; Referenced from A4A8, A609, A627, A785, A8B7, A96C, AB53
                                        ; --- START PROC LA498 ---
A498: 3E 0D                      LA498: ld      a,0Dh
A49A: CD 92 A4                          call    LA492
A49D: 3E 0A                             ld      a,0Ah
A49F: C3 92 A4                          jp      LA492

                                        ; Referenced from A8CC, A8D4, A908
                                        ; --- START PROC LA4A2 ---
A4A2: 3E 20                      LA4A2: ld      a,20h   ; ' '
A4A4: C3 92 A4                          jp      LA492

                                        ; Referenced from A7DC, A7ED, A92A, A9FE, AA7C, AB74
                                        ; --- START PROC LA4A7 ---
A4A7: C5                         LA4A7: push    bc
A4A8: CD 98 A4                          call    LA498
A4AB: E1                                pop     hl

                                        ; Referenced from A4B5, A587
                                        ; --- START PROC LA4AC ---
A4AC: 7E                         LA4AC: ld      a,(hl)
A4AD: B7                                or      a
A4AE: C8                                ret     z
A4AF: 23                                inc     hl
A4B0: E5                                push    hl
A4B1: CD 8C A4                          call    LA48C
A4B4: E1                                pop     hl
A4B5: C3 AC A4                          jp      LA4AC

                                        ; Referenced from A76B
                                        ; --- START PROC LA4B8 ---
A4B8: 0E 0D                      LA4B8: ld      c,0Dh
A4BA: C3 05 00                          jp      0005h

                                        ; Referenced from A546, A581, A5E6, A5F2, A778, A863, A874, AABE, AB65
                                        ; --- START PROC LA4BD ---
A4BD: 5F                         LA4BD: ld      e,a
A4BE: 0E 0E                             ld      c,0Eh
A4C0: C3 05 00                          jp      0005h

                                        ; Referenced from A4CD, A4DC, A4E1, A4E6, A50B
                                        ; --- START PROC LA4C3 ---
A4C3: CD 05 00                   LA4C3: call    0005h
A4C6: 32 EE AB                          ld      (LABEE),a
A4C9: 3C                                inc     a
A4CA: C9                                ret

                                        ; Referenced from A4D7, A54C
                                        ; --- START PROC LA4CB ---
A4CB: 0E 0F                      LA4CB: ld      c,0Fh
A4CD: C3 C3 A4                          jp      LA4C3

                                        ; Referenced from A966, AAD8
                                        ; --- START PROC LA4D0 ---
A4D0: AF                         LA4D0: xor     a
A4D1: 32 ED AB                          ld      (LABED),a
A4D4: 11 CD AB                          ld      de,0ABCDh
A4D7: C3 CB A4                          jp      LA4CB

                                        ; Referenced from A577, A9F4
                                        ; --- START PROC LA4DA ---
A4DA: 0E 10                      LA4DA: ld      c,10h
A4DC: C3 C3 A4                          jp      LA4C3

                                        ; Referenced from A4EC
                                        ; --- START PROC LA4DF ---
A4DF: 0E 11                      LA4DF: ld      c,11h
A4E1: C3 C3 A4                          jp      LA4C3

                                        ; Referenced from A915
                                        ; --- START PROC LA4E4 ---
A4E4: 0E 12                      LA4E4: ld      c,12h
A4E6: C3 C3 A4                          jp      LA4C3

                                        ; Referenced from A892, AA1D, AA5E
                                        ; --- START PROC LA4E9 ---
A4E9: 11 CD AB                   LA4E9: ld      de,0ABCDh
A4EC: C3 DF A4                          jp      LA4DF

                                        ; Referenced from A5EC, A948, A9BE
                                        ; --- START PROC LA4EF ---
A4EF: 0E 13                      LA4EF: ld      c,13h
A4F1: C3 05 00                          jp      0005h

                                        ; Referenced from A4FB, A506
                                        ; --- START PROC LA4F4 ---
A4F4: CD 05 00                   LA4F4: call    0005h
A4F7: B7                                or      a
A4F8: C9                                ret

                                        ; Referenced from A501, A55C, AAE9
                                        ; --- START PROC LA4F9 ---
A4F9: 0E 14                      LA4F9: ld      c,14h
A4FB: C3 F4 A4                          jp      LA4F4

                                        ; Referenced from A97E
                                        ; --- START PROC LA4FE ---
A4FE: 11 CD AB                   LA4FE: ld      de,0ABCDh
A501: C3 F9 A4                          jp      LA4F9

                                        ; Referenced from A9E6
                                        ; --- START PROC LA504 ---
A504: 0E 15                      LA504: ld      c,15h
A506: C3 F4 A4                          jp      LA4F4

                                        ; Referenced from A9C2
                                        ; --- START PROC LA509 ---
A509: 0E 16                      LA509: ld      c,16h
A50B: C3 C3 A4                          jp      LA4C3

                                        ; Referenced from AA67
                                        ; --- START PROC LA50E ---
A50E: 0E 17                      LA50E: ld      c,17h
A510: C3 05 00                          jp      0005h

                                        ; Referenced from A51A
                                        ; --- START PROC LA513 ---
A513: 1E FF                      LA513: ld      e,0FFh

                                        ; Referenced from A768, AA9F
                                        ; --- START PROC LA515 ---
A515: 0E 20                      LA515: ld      c,20h   ; ' '
A517: C3 05 00                          jp      0005h

                                        ; Referenced from A599, AB59
                                        ; --- START PROC LA51A ---
A51A: CD 13 A5                   LA51A: call    LA513
A51D: 87                                add     a,a
A51E: 87                                add     a,a
A51F: 87                                add     a,a
A520: 87                                add     a,a
A521: 21 EF AB                          ld      hl,0ABEFh
A524: B6                                or      (hl)
A525: 32 04 00                          ld      (0004h),a
A528: C9                                ret

                                        ; Referenced from A5A4, AABB, AB62
                                        ; --- START PROC LA529 ---
A529: 3A EF AB                   LA529: ld      a,(LABEF)
A52C: 32 04 00                          ld      (0004h),a
A52F: C9                                ret

                                        ; Referenced from A5B2
                                        ; --- START PROC LA530 ---
A530: FE 61                      LA530: cp      61h     ; 'a'
A532: D8                                ret     c
A533: FE 7B                             cp      7Bh     ; '{'
A535: D0                                ret     nc
A536: E6 5F                             and     5Fh     ; '_'
A538: C9                                ret

                                        ; Referenced from A795, A92D
                                        ; --- START PROC LA539 ---
A539: 3A AB AB                   LA539: ld      a,(LABAB)
A53C: B7                                or      a
A53D: CA 96 A5                          jp      z,LA596
A540: 3A EF AB                          ld      a,(LABEF)
A543: B7                                or      a
A544: 3E 00                             ld      a,00h
A546: C4 BD A4                          call    nz,LA4BD
A549: 11 AC AB                          ld      de,0ABACh
A54C: CD CB A4                          call    LA4CB
A54F: CA 96 A5                          jp      z,LA596
A552: 3A BB AB                          ld      a,(LABBB)
A555: 3D                                dec     a
A556: 32 CC AB                          ld      (LABCC),a
A559: 11 AC AB                          ld      de,0ABACh
A55C: CD F9 A4                          call    LA4F9
A55F: C2 96 A5                          jp      nz,LA596
A562: 11 07 A4                          ld      de,0A407h
A565: 21 80 00                          ld      hl,0080h
A568: 06 80                             ld      b,80h
A56A: CD 42 A8                          call    LA842
A56D: 21 BA AB                          ld      hl,0ABBAh
A570: 36 00                             ld      (hl),00h
A572: 23                                inc     hl
A573: 35                                dec     (hl)
A574: 11 AC AB                          ld      de,0ABACh
A577: CD DA A4                          call    LA4DA
A57A: CA 96 A5                          jp      z,LA596
A57D: 3A EF AB                          ld      a,(LABEF)
A580: B7                                or      a
A581: C4 BD A4                          call    nz,LA4BD
A584: 21 08 A4                          ld      hl,0A408h
A587: CD AC A4                          call    LA4AC
A58A: CD C2 A5                          call    LA5C2
A58D: CA A7 A5                          jp      z,LA5A7
A590: CD DD A5                          call    LA5DD
A593: C3 82 A7                          jp      LA782

                                        ; Referenced from A53D, A54F, A55F, A57A
A596: CD DD A5                   LA596: call    LA5DD
A599: CD 1A A5                          call    LA51A
A59C: 0E 0A                             ld      c,0Ah
A59E: 11 06 A4                          ld      de,0A406h
A5A1: CD 05 00                          call    0005h
A5A4: CD 29 A5                          call    LA529

                                        ; Referenced from A58D
A5A7: 21 07 A4                   LA5A7: ld      hl,0A407h
A5AA: 46                                ld      b,(hl)

                                        ; Referenced from A5B7
A5AB: 23                         LA5AB: inc     hl
A5AC: 78                                ld      a,b
A5AD: B7                                or      a
A5AE: CA BA A5                          jp      z,LA5BA
A5B1: 7E                                ld      a,(hl)
A5B2: CD 30 A5                          call    LA530
A5B5: 77                                ld      (hl),a
A5B6: 05                                dec     b
A5B7: C3 AB A5                          jp      LA5AB

                                        ; Referenced from A5AE
A5BA: 77                         LA5BA: ld      (hl),a
A5BB: 21 08 A4                          ld      hl,0A408h
A5BE: 22 88 A4                          ld      (LA488),hl
A5C1: C9                                ret

                                        ; Referenced from A58A, A90F, A997
                                        ; --- START PROC LA5C2 ---
A5C2: 0E 0B                      LA5C2: ld      c,0Bh
A5C4: CD 05 00                          call    0005h
A5C7: B7                                or      a
A5C8: C8                                ret     z
A5C9: 0E 01                             ld      c,01h
A5CB: CD 05 00                          call    0005h
A5CE: B7                                or      a
A5CF: C9                                ret

                                        ; Referenced from A788, A79E, A8BB
                                        ; --- START PROC LA5D0 ---
A5D0: 0E 19                      LA5D0: ld      c,19h
A5D2: C3 05 00                          jp      0005h

                                        ; Referenced from AA01, AB56
                                        ; --- START PROC LA5D5 ---
A5D5: 11 80 00                   LA5D5: ld      de,0080h

                                        ; Referenced from A79B, A9E0, AAE3
                                        ; --- START PROC LA5D8 ---
A5D8: 0E 1A                      LA5D8: ld      c,1Ah
A5DA: C3 05 00                          jp      0005h

                                        ; Referenced from A590, A596, A62A
                                        ; --- START PROC LA5DD ---
A5DD: 21 AB AB                   LA5DD: ld      hl,0ABABh
A5E0: 7E                                ld      a,(hl)
A5E1: B7                                or      a
A5E2: C8                                ret     z
A5E3: 36 00                             ld      (hl),00h
A5E5: AF                                xor     a
A5E6: CD BD A4                          call    LA4BD
A5E9: 11 AC AB                          ld      de,0ABACh
A5EC: CD EF A4                          call    LA4EF
A5EF: 3A EF AB                          ld      a,(LABEF)
A5F2: C3 BD A4                          jp      LA4BD

                                        ; Referenced from AAA5
                                        ; --- START PROC LA5F5 ---
A5F5: 11 28 A7                   LA5F5: ld      de,0A728h
A5F8: 21 00 AC                          ld      hl,0AC00h
A5FB: 06 06                             ld      b,06h

                                        ; Referenced from A605
A5FD: 1A                         LA5FD: ld      a,(de)
A5FE: BE                                cp      (hl)
A5FF: C2 CF A7                          jp      nz,LA7CF
A602: 13                                inc     de
A603: 23                                inc     hl
A604: 05                                dec     b
A605: C2 FD A5                          jp      nz,LA5FD
A608: C9                                ret

                                        ; Referenced from A635, A7A7, A7FF, A813, A81A, A822, A826, A82A, A836, A960, A9AA, A9B4, AA13, AA76, AA93, AA9C, AACA, AB6E, AB95
                                        ; --- START PROC LA609 ---
A609: CD 98 A4                   LA609: call    LA498
A60C: 2A 8A A4                          ld      hl,(LA48A)

                                        ; Referenced from A61F
A60F: 7E                         LA60F: ld      a,(hl)
A610: FE 20                             cp      20h     ; ' '
A612: CA 22 A6                          jp      z,LA622
A615: B7                                or      a
A616: CA 22 A6                          jp      z,LA622
A619: E5                                push    hl
A61A: CD 8C A4                          call    LA48C
A61D: E1                                pop     hl
A61E: 23                                inc     hl
A61F: C3 0F A6                          jp      LA60F

                                        ; Referenced from A612, A616
A622: 3E 3F                      LA622: ld      a,3Fh   ; '?'
A624: CD 8C A4                          call    LA48C
A627: CD 98 A4                          call    LA498
A62A: CD DD A5                          call    LA5DD
A62D: C3 82 A7                          jp      LA782

                                        ; Referenced from A698, A6AF, A6C8, A6DF
                                        ; --- START PROC LA630 ---
A630: 1A                         LA630: ld      a,(de)
A631: B7                                or      a
A632: C8                                ret     z
A633: FE 20                             cp      20h     ; ' '
A635: DA 09 A6                          jp      c,LA609
A638: C8                                ret     z
A639: FE 3D                             cp      3Dh     ; '='
A63B: C8                                ret     z
A63C: FE 5F                             cp      5Fh     ; '_'
A63E: C8                                ret     z
A63F: FE 2E                             cp      2Eh     ; '.'
A641: C8                                ret     z
A642: FE 3A                             cp      3Ah     ; ':'
A644: C8                                ret     z
A645: FE 3B                             cp      3Bh     ; ';'
A647: C8                                ret     z
A648: FE 3C                             cp      3Ch     ; '<'
A64A: C8                                ret     z
A64B: FE 3E                             cp      3Eh     ; '>'
A64D: C8                                ret     z
A64E: C9                                ret

                                        ; Referenced from A656, A670, AA32
                                        ; --- START PROC LA64F ---
A64F: 1A                         LA64F: ld      a,(de)
A650: B7                                or      a
A651: C8                                ret     z
A652: FE 20                             cp      20h     ; ' '
A654: C0                                ret     nz
A655: 13                                inc     de
A656: C3 4F A6                          jp      LA64F

                                        ; Referenced from A663, A84F, A98B
                                        ; --- START PROC LA659 ---
A659: 85                         LA659: add     a,l
A65A: 6F                                ld      l,a
A65B: D0                                ret     nc
A65C: 24                                inc     h
A65D: C9                                ret

                                        ; Referenced from A7A4, A7F8, A877, A91F, A95D, A9B1, AA10, AA44, AB09, AB89
                                        ; --- START PROC LA65E ---
A65E: 3E 00                      LA65E: ld      a,00h

                                        ; Referenced from AB16
                                        ; --- START PROC LA660 ---
A660: 21 CD AB                   LA660: ld      hl,0ABCDh
A663: CD 59 A6                          call    LA659
A666: E5                                push    hl
A667: E5                                push    hl
A668: AF                                xor     a
A669: 32 F0 AB                          ld      (LABF0),a
A66C: 2A 88 A4                          ld      hl,(LA488)
A66F: EB                                ex      de,hl
A670: CD 4F A6                          call    LA64F
A673: EB                                ex      de,hl
A674: 22 8A A4                          ld      (LA48A),hl
A677: EB                                ex      de,hl
A678: E1                                pop     hl
A679: 1A                                ld      a,(de)
A67A: B7                                or      a
A67B: CA 89 A6                          jp      z,LA689
A67E: DE 40                             sbc     a,40h   ; '@'
A680: 47                                ld      b,a
A681: 13                                inc     de
A682: 1A                                ld      a,(de)
A683: FE 3A                             cp      3Ah     ; ':'
A685: CA 90 A6                          jp      z,LA690
A688: 1B                                dec     de

                                        ; Referenced from A67B
A689: 3A EF AB                   LA689: ld      a,(LABEF)
A68C: 77                                ld      (hl),a
A68D: C3 96 A6                          jp      LA696

                                        ; Referenced from A685
A690: 78                         LA690: ld      a,b
A691: 32 F0 AB                          ld      (LABF0),a
A694: 70                                ld      (hl),b
A695: 13                                inc     de

                                        ; Referenced from A68D
A696: 06 08                      LA696: ld      b,08h

                                        ; Referenced from A6AC
A698: CD 30 A6                   LA698: call    LA630
A69B: CA B9 A6                          jp      z,LA6B9
A69E: 23                                inc     hl
A69F: FE 2A                             cp      2Ah     ; '*'
A6A1: C2 A9 A6                          jp      nz,LA6A9
A6A4: 36 3F                             ld      (hl),3Fh        ; '?'
A6A6: C3 AB A6                          jp      LA6AB

                                        ; Referenced from A6A1
A6A9: 77                         LA6A9: ld      (hl),a
A6AA: 13                                inc     de

                                        ; Referenced from A6A6
A6AB: 05                         LA6AB: dec     b
A6AC: C2 98 A6                          jp      nz,LA698

                                        ; Referenced from A6B6
A6AF: CD 30 A6                   LA6AF: call    LA630
A6B2: CA C0 A6                          jp      z,LA6C0
A6B5: 13                                inc     de
A6B6: C3 AF A6                          jp      LA6AF

                                        ; Referenced from A69B, A6BD
A6B9: 23                         LA6B9: inc     hl
A6BA: 36 20                             ld      (hl),20h        ; ' '
A6BC: 05                                dec     b
A6BD: C2 B9 A6                          jp      nz,LA6B9

                                        ; Referenced from A6B2
A6C0: 06 03                      LA6C0: ld      b,03h
A6C2: FE 2E                             cp      2Eh     ; '.'
A6C4: C2 E9 A6                          jp      nz,LA6E9
A6C7: 13                                inc     de

                                        ; Referenced from A6DC
A6C8: CD 30 A6                   LA6C8: call    LA630
A6CB: CA E9 A6                          jp      z,LA6E9
A6CE: 23                                inc     hl
A6CF: FE 2A                             cp      2Ah     ; '*'
A6D1: C2 D9 A6                          jp      nz,LA6D9
A6D4: 36 3F                             ld      (hl),3Fh        ; '?'
A6D6: C3 DB A6                          jp      LA6DB

                                        ; Referenced from A6D1
A6D9: 77                         LA6D9: ld      (hl),a
A6DA: 13                                inc     de

                                        ; Referenced from A6D6
A6DB: 05                         LA6DB: dec     b
A6DC: C2 C8 A6                          jp      nz,LA6C8

                                        ; Referenced from A6E6
A6DF: CD 30 A6                   LA6DF: call    LA630
A6E2: CA F0 A6                          jp      z,LA6F0
A6E5: 13                                inc     de
A6E6: C3 DF A6                          jp      LA6DF

                                        ; Referenced from A6C4, A6CB, A6ED
A6E9: 23                         LA6E9: inc     hl
A6EA: 36 20                             ld      (hl),20h        ; ' '
A6EC: 05                                dec     b
A6ED: C2 E9 A6                          jp      nz,LA6E9

                                        ; Referenced from A6E2
A6F0: 06 03                      LA6F0: ld      b,03h

                                        ; Referenced from A6F6
A6F2: 23                         LA6F2: inc     hl
A6F3: 36 00                             ld      (hl),00h
A6F5: 05                                dec     b
A6F6: C2 F2 A6                          jp      nz,LA6F2
A6F9: EB                                ex      de,hl
A6FA: 22 88 A4                          ld      (LA488),hl
A6FD: E1                                pop     hl
A6FE: 01 0B 00                          ld      bc,000Bh

                                        ; Referenced from A70A
A701: 23                         LA701: inc     hl
A702: 7E                                ld      a,(hl)
A703: FE 3F                             cp      3Fh     ; '?'
A705: C2 09 A7                          jp      nz,LA709
A708: 04                                inc     b

                                        ; Referenced from A705
A709: 0D                         LA709: dec     c
A70A: C2 01 A7                          jp      nz,LA701
A70D: 78                                ld      a,b
A70E: B7                                or      a
A70F: C9                                ret

A710: 44                         LA710: ld      b,h
A711: 49                                ld      c,c
A712: 52                                ld      d,d
A713: 20 45                             jr      nz,LA759+1      ; reference not aligned to instruction
A715: 52                                ld      d,d
A716: 41                                ld      b,c
A717: 20 54                             jr      nz,LA76B+2      ; reference not aligned to instruction
A719: 59                                ld      e,c
A71A: 50                                ld      d,b
A71B: 45                                ld      b,l
A71C: 53                                ld      d,e
A71D: 41                                ld      b,c
A71E: 56                                ld      d,(hl)
A71F: 45                                ld      b,l
A720: 52                                ld      d,d
A721: 45                                ld      b,l
A722: 4E                                ld      c,(hl)
A723: 20 55                             jr      nz,LA778+2      ; reference not aligned to instruction
A725: 53                                ld      d,e
A726: 45                                ld      b,l
A727: 52                                ld      d,d
A728: 11 14 00                          ld      de,0014h
A72B: 00                                nop
A72C: 0A                                ld      a,(bc)
A72D: 64                                ld      h,h

                                        ; Referenced from A7B1
                                        ; --- START PROC LA72E ---
A72E: 21 10 A7                   LA72E: ld      hl,0A710h
A731: 0E 00                             ld      c,00h

                                        ; Referenced from A755
A733: 79                         LA733: ld      a,c
A734: FE 06                             cp      06h
A736: D0                                ret     nc
A737: 11 CE AB                          ld      de,0ABCEh
A73A: 06 04                             ld      b,04h

                                        ; Referenced from A744
A73C: 1A                         LA73C: ld      a,(de)
A73D: BE                                cp      (hl)
A73E: C2 4F A7                          jp      nz,LA74F
A741: 13                                inc     de
A742: 23                                inc     hl
A743: 05                                dec     b
A744: C2 3C A7                          jp      nz,LA73C
A747: 1A                                ld      a,(de)
A748: FE 20                             cp      20h     ; ' '
A74A: C2 54 A7                          jp      nz,LA754
A74D: 79                                ld      a,c
A74E: C9                                ret

                                        ; Referenced from A73E, A751
A74F: 23                         LA74F: inc     hl
A750: 05                                dec     b
A751: C2 4F A7                          jp      nz,LA74F

                                        ; Referenced from A74A
A754: 0C                         LA754: inc     c
A755: C3 33 A7                          jp      LA733

                                        ; Referenced from A403
A758: AF                         LA758: xor     a

                                        ; Referenced from A713
A759: 32 07 A4                   LA759: ld      (LA407),a

                                        ; Referenced from A400
A75C: 31 AB AB                   LA75C: ld      sp,0ABABh
A75F: C5                                push    bc
A760: 79                                ld      a,c
A761: 1F                                rra
A762: 1F                                rra
A763: 1F                                rra
A764: 1F                                rra
A765: E6 0F                             and     0Fh
A767: 5F                                ld      e,a
A768: CD 15 A5                          call    LA515

                                        ; Referenced from A717
A76B: CD B8 A4                   LA76B: call    LA4B8
A76E: 32 AB AB                          ld      (LABAB),a
A771: C1                                pop     bc
A772: 79                                ld      a,c
A773: E6 0F                             and     0Fh

                                        ; Referenced from A7C9
A775: 32 EF AB                   LA775: ld      (LABEF),a

                                        ; Referenced from A723
A778: CD BD A4                   LA778: call    LA4BD
A77B: 3A 07 A4                          ld      a,(LA407)
A77E: B7                                or      a
A77F: C2 98 A7                          jp      nz,LA798

                                        ; Referenced from A593, A62D, A934, A93B, AB68, AB98
                                        ; --- START PROC LA782 ---
A782: 31 AB AB                   LA782: ld      sp,0ABABh
A785: CD 98 A4                          call    LA498
A788: CD D0 A5                          call    LA5D0
A78B: C6 41                             add     a,41h   ; 'A'
A78D: CD 8C A4                          call    LA48C
A790: 3E 3E                             ld      a,3Eh   ; '>'
A792: CD 8C A4                          call    LA48C
A795: CD 39 A5                          call    LA539

                                        ; Referenced from A77F
A798: 11 80 00                   LA798: ld      de,0080h
A79B: CD D8 A5                          call    LA5D8
A79E: CD D0 A5                          call    LA5D0
A7A1: 32 EF AB                          ld      (LABEF),a
A7A4: CD 5E A6                          call    LA65E
A7A7: C4 09 A6                          call    nz,LA609
A7AA: 3A F0 AB                          ld      a,(LABF0)
A7AD: B7                                or      a
A7AE: C2 A5 AA                          jp      nz,LAAA5
A7B1: CD 2E A7                          call    LA72E
A7B4: 21 C1 A7                          ld      hl,0A7C1h
A7B7: 5F                                ld      e,a
A7B8: 16 00                             ld      d,00h
A7BA: 19                                add     hl,de
A7BB: 19                                add     hl,de
A7BC: 7E                                ld      a,(hl)
A7BD: 23                                inc     hl
A7BE: 66                                ld      h,(hl)
A7BF: 6F                                ld      l,a
A7C0: E9                                jp      (hl)

A7C1: 77                         LA7C1: ld      (hl),a
A7C2: A8                                xor     b
A7C3: 1F                                rra
A7C4: A9                                xor     c
A7C5: 5D                                ld      e,l
A7C6: A9                                xor     c
A7C7: AD                                xor     l
A7C8: A9                                xor     c
A7C9: 10 AA                             djnz    LA775
A7CB: 8E                                adc     a,(hl)
A7CC: AA                                xor     d
A7CD: A5                                and     l
A7CE: AA                                xor     d

                                        ; Referenced from A5FF
                                        ; --- START PROC LA7CF ---
A7CF: 21 F3 76                   LA7CF: ld      hl,76F3h
A7D2: 22 00 A4                          ld      (LA400),hl
A7D5: 21 00 A4                          ld      hl,0A400h
A7D8: E9                                jp      (hl)

                                        ; Referenced from A9A4
                                        ; --- START PROC LA7D9 ---
A7D9: 01 DF A7                   LA7D9: ld      bc,0A7DFh
A7DC: C3 A7 A4                          jp      LA4A7

A7DF: 52                         LA7DF: ld      d,d
A7E0: 45                                ld      b,l
A7E1: 41                                ld      b,c
A7E2: 44                                ld      b,h
A7E3: 20 45                             jr      nz,LA82A
A7E5: 52                                ld      d,d
A7E6: 52                                ld      d,d
A7E7: 4F                                ld      c,a
A7E8: 52                                ld      d,d
A7E9: 00                                nop

                                        ; Referenced from A895, A94C, AA6D
                                        ; --- START PROC LA7EA ---
A7EA: 01 F0 A7                   LA7EA: ld      bc,0A7F0h
A7ED: C3 A7 A4                          jp      LA4A7

A7F0: 4E                         LA7F0: ld      c,(hl)
A7F1: 4F                                ld      c,a
A7F2: 20 46                             jr      nz,LA83A
A7F4: 49                                ld      c,c
A7F5: 4C                                ld      c,h
A7F6: 45                                ld      b,l
A7F7: 00                                nop

                                        ; Referenced from A9AD, AA8E
                                        ; --- START PROC LA7F8 ---
A7F8: CD 5E A6                   LA7F8: call    LA65E
A7FB: 3A F0 AB                          ld      a,(LABF0)
A7FE: B7                                or      a
A7FF: C2 09 A6                          jp      nz,LA609
A802: 21 CE AB                          ld      hl,0ABCEh
A805: 01 0B 00                          ld      bc,000Bh

                                        ; Referenced from A82F
A808: 7E                         LA808: ld      a,(hl)
A809: FE 20                             cp      20h     ; ' '
A80B: CA 33 A8                          jp      z,LA833
A80E: 23                                inc     hl
A80F: D6 30                             sub     30h     ; '0'
A811: FE 0A                             cp      0Ah
A813: D2 09 A6                          jp      nc,LA609
A816: 57                                ld      d,a
A817: 78                                ld      a,b
A818: E6 E0                             and     0E0h
A81A: C2 09 A6                          jp      nz,LA609
A81D: 78                                ld      a,b
A81E: 07                                rlca
A81F: 07                                rlca
A820: 07                                rlca
A821: 80                                add     a,b
A822: DA 09 A6                          jp      c,LA609
A825: 80                                add     a,b
A826: DA 09 A6                          jp      c,LA609
A829: 82                                add     a,d

                                        ; Referenced from A7E3
A82A: DA 09 A6                   LA82A: jp      c,LA609
A82D: 47                                ld      b,a
A82E: 0D                                dec     c
A82F: C2 08 A8                          jp      nz,LA808
A832: C9                                ret

                                        ; Referenced from A80B, A83B
A833: 7E                         LA833: ld      a,(hl)
A834: FE 20                             cp      20h     ; ' '
A836: C2 09 A6                          jp      nz,LA609
A839: 23                                inc     hl

                                        ; Referenced from A7F2
A83A: 0D                         LA83A: dec     c
A83B: C2 33 A8                          jp      nz,LA833
A83E: 78                                ld      a,b
A83F: C9                                ret

                                        ; Referenced from AAD5
                                        ; --- START PROC LA840 ---
A840: 06 03                      LA840: ld      b,03h

                                        ; Referenced from A56A, A847, AA2B, AB2A
                                        ; --- START PROC LA842 ---
A842: 7E                         LA842: ld      a,(hl)
A843: 12                                ld      (de),a
A844: 23                                inc     hl
A845: 13                                inc     de
A846: 05                                dec     b
A847: C2 42 A8                          jp      nz,LA842
A84A: C9                                ret

                                        ; Referenced from A8A6, A8DA, A8ED
                                        ; --- START PROC LA84B ---
A84B: 21 80 00                   LA84B: ld      hl,0080h
A84E: 81                                add     a,c
A84F: CD 59 A6                          call    LA659
A852: 7E                                ld      a,(hl)
A853: C9                                ret

                                        ; Referenced from A87A, A942, A963, A9B7, AA1A, AACE
                                        ; --- START PROC LA854 ---
A854: AF                         LA854: xor     a
A855: 32 CD AB                          ld      (LABCD),a
A858: 3A F0 AB                          ld      a,(LABF0)
A85B: B7                                or      a
A85C: C8                                ret     z
A85D: 3D                                dec     a
A85E: 21 EF AB                          ld      hl,0ABEFh
A861: BE                                cp      (hl)
A862: C8                                ret     z
A863: C3 BD A4                          jp      LA4BD

                                        ; Referenced from A9A7, AA73, AB06, AB6B, AB86
                                        ; --- START PROC LA866 ---
A866: 3A F0 AB                   LA866: ld      a,(LABF0)
A869: B7                                or      a
A86A: C8                                ret     z
A86B: 3D                                dec     a
A86C: 21 EF AB                          ld      hl,0ABEFh
A86F: BE                                cp      (hl)
A870: C8                                ret     z
A871: 3A EF AB                          ld      a,(LABEF)
A874: C3 BD A4                          jp      LA4BD

A877: CD 5E A6                   LA877: call    LA65E
A87A: CD 54 A8                          call    LA854
A87D: 21 CE AB                          ld      hl,0ABCEh
A880: 7E                                ld      a,(hl)
A881: FE 20                             cp      20h     ; ' '
A883: C2 8F A8                          jp      nz,LA88F
A886: 06 0B                             ld      b,0Bh

                                        ; Referenced from A88C
A888: 36 3F                      LA888: ld      (hl),3Fh        ; '?'
A88A: 23                                inc     hl
A88B: 05                                dec     b
A88C: C2 88 A8                          jp      nz,LA888

                                        ; Referenced from A883
A88F: 1E 00                      LA88F: ld      e,00h
A891: D5                                push    de
A892: CD E9 A4                          call    LA4E9
A895: CC EA A7                          call    z,LA7EA

                                        ; Referenced from A918
                                        ; --- START PROC LA898 ---
A898: CA 1B A9                   LA898: jp      z,LA91B
A89B: 3A EE AB                          ld      a,(LABEE)
A89E: 0F                                rrca
A89F: 0F                                rrca
A8A0: 0F                                rrca
A8A1: E6 60                             and     60h     ; '`'
A8A3: 4F                                ld      c,a
A8A4: 3E 0A                             ld      a,0Ah
A8A6: CD 4B A8                          call    LA84B
A8A9: 17                                rla
A8AA: DA 0F A9                          jp      c,LA90F
A8AD: D1                                pop     de
A8AE: 7B                                ld      a,e
A8AF: 1C                                inc     e
A8B0: D5                                push    de
A8B1: E6 03                             and     03h
A8B3: F5                                push    af
A8B4: C2 CC A8                          jp      nz,LA8CC
A8B7: CD 98 A4                          call    LA498
A8BA: C5                                push    bc
A8BB: CD D0 A5                          call    LA5D0

                                        ; Referenced from BA86
                                        ; --- START PROC LA8BE ---
A8BE: C1                         LA8BE: pop     bc
A8BF: C6 41                             add     a,41h   ; 'A'
A8C1: CD 92 A4                          call    LA492
A8C4: 3E 3A                             ld      a,3Ah   ; ':'
A8C6: CD 92 A4                          call    LA492
A8C9: C3 D4 A8                          jp      LA8D4

                                        ; Referenced from A8B4
                                        ; --- START PROC LA8CC ---
A8CC: CD A2 A4                   LA8CC: call    LA4A2
A8CF: 3E 3A                             ld      a,3Ah   ; ':'
A8D1: CD 92 A4                          call    LA492

                                        ; Referenced from A8C9
A8D4: CD A2 A4                   LA8D4: call    LA4A2
A8D7: 06 01                             ld      b,01h

                                        ; Referenced from A905, A90B
A8D9: 78                         LA8D9: ld      a,b
A8DA: CD 4B A8                          call    LA84B
A8DD: E6 7F                             and     7Fh     ; ''
A8DF: FE 20                             cp      20h     ; ' '
A8E1: C2 F9 A8                          jp      nz,LA8F9
A8E4: F1                                pop     af
A8E5: F5                                push    af
A8E6: FE 03                             cp      03h
A8E8: C2 F7 A8                          jp      nz,LA8F7
A8EB: 3E 09                             ld      a,09h
A8ED: CD 4B A8                          call    LA84B
A8F0: E6 7F                             and     7Fh     ; ''
A8F2: FE 20                             cp      20h     ; ' '
A8F4: CA 0E A9                          jp      z,LA90E

                                        ; Referenced from A8E8
A8F7: 3E 20                      LA8F7: ld      a,20h   ; ' '

                                        ; Referenced from A8E1
A8F9: CD 92 A4                   LA8F9: call    LA492
A8FC: 04                                inc     b
A8FD: 78                                ld      a,b
A8FE: FE 0C                             cp      0Ch
A900: D2 0E A9                          jp      nc,LA90E
A903: FE 09                             cp      09h
A905: C2 D9 A8                          jp      nz,LA8D9
A908: CD A2 A4                          call    LA4A2
A90B: C3 D9 A8                          jp      LA8D9

                                        ; Referenced from A8F4, A900
                                        ; --- START PROC LA90E ---
A90E: F1                         LA90E: pop     af

                                        ; Referenced from A8AA
                                        ; --- START PROC LA90F ---
A90F: CD C2 A5                   LA90F: call    LA5C2
A912: C2 1B A9                          jp      nz,LA91B
A915: CD E4 A4                          call    LA4E4
A918: C3 98 A8                          jp      LA898

                                        ; Referenced from A898, A912
                                        ; --- START PROC LA91B ---
A91B: D1                         LA91B: pop     de
A91C: C3 86 AB                          jp      LAB86

A91F: CD 5E A6                   LA91F: call    LA65E
A922: FE 0B                             cp      0Bh
A924: C2 42 A9                          jp      nz,LA942
A927: 01 52 A9                          ld      bc,0A952h
A92A: CD A7 A4                          call    LA4A7
A92D: CD 39 A5                          call    LA539
A930: 21 07 A4                          ld      hl,0A407h
A933: 35                                dec     (hl)
A934: C2 82 A7                          jp      nz,LA782
A937: 23                                inc     hl
A938: 7E                                ld      a,(hl)
A939: FE 59                             cp      59h     ; 'Y'
A93B: C2 82 A7                          jp      nz,LA782
A93E: 23                                inc     hl
A93F: 22 88 A4                          ld      (LA488),hl

                                        ; Referenced from A924
A942: CD 54 A8                   LA942: call    LA854
A945: 11 CD AB                          ld      de,0ABCDh
A948: CD EF A4                          call    LA4EF
A94B: 3C                                inc     a
A94C: CC EA A7                          call    z,LA7EA
A94F: C3 86 AB                          jp      LAB86

A952: 41                         LA952: ld      b,c
A953: 4C                                ld      c,h
A954: 4C                                ld      c,h
A955: 20 28                             jr      nz,LA97E+1      ; reference not aligned to instruction
A957: 59                                ld      e,c
A958: 2F                                cpl
A959: 4E                                ld      c,(hl)
A95A: 29                                add     hl,hl
A95B: 3F                                ccf
A95C: 00                                nop
A95D: CD 5E A6                          call    LA65E
A960: C2 09 A6                          jp      nz,LA609
A963: CD 54 A8                          call    LA854
A966: CD D0 A4                          call    LA4D0
A969: CA A7 A9                          jp      z,LA9A7
A96C: CD 98 A4                          call    LA498
A96F: 21 F1 AB                          ld      hl,0ABF1h
A972: 36 FF                             ld      (hl),0FFh

                                        ; Referenced from A99D
A974: 21 F1 AB                   LA974: ld      hl,0ABF1h
A977: 7E                                ld      a,(hl)
A978: FE 80                             cp      80h
A97A: DA 87 A9                          jp      c,LA987
A97D: E5                                push    hl

                                        ; Referenced from A955
A97E: CD FE A4                   LA97E: call    LA4FE
A981: E1                                pop     hl
A982: C2 A0 A9                          jp      nz,LA9A0
A985: AF                                xor     a
A986: 77                                ld      (hl),a

                                        ; Referenced from A97A
A987: 34                         LA987: inc     (hl)
A988: 21 80 00                          ld      hl,0080h
A98B: CD 59 A6                          call    LA659
A98E: 7E                                ld      a,(hl)
A98F: FE 1A                             cp      1Ah
A991: CA 86 AB                          jp      z,LAB86
A994: CD 8C A4                          call    LA48C
A997: CD C2 A5                          call    LA5C2
A99A: C2 86 AB                          jp      nz,LAB86
A99D: C3 74 A9                          jp      LA974

                                        ; Referenced from A982
A9A0: 3D                         LA9A0: dec     a
A9A1: CA 86 AB                          jp      z,LAB86
A9A4: CD D9 A7                          call    LA7D9

                                        ; Referenced from A969
A9A7: CD 66 A8                   LA9A7: call    LA866
A9AA: C3 09 A6                          jp      LA609

A9AD: CD F8 A7                   LA9AD: call    LA7F8
A9B0: F5                                push    af
A9B1: CD 5E A6                          call    LA65E
A9B4: C2 09 A6                          jp      nz,LA609
A9B7: CD 54 A8                          call    LA854
A9BA: 11 CD AB                          ld      de,0ABCDh
A9BD: D5                                push    de
A9BE: CD EF A4                          call    LA4EF
A9C1: D1                                pop     de
A9C2: CD 09 A5                          call    LA509
A9C5: CA FB A9                          jp      z,LA9FB
A9C8: AF                                xor     a
A9C9: 32 ED AB                          ld      (LABED),a
A9CC: F1                                pop     af
A9CD: 6F                                ld      l,a
A9CE: 26 00                             ld      h,00h
A9D0: 29                                add     hl,hl
A9D1: 11 00 01                          ld      de,0100h

                                        ; Referenced from A9EE
A9D4: 7C                         LA9D4: ld      a,h
A9D5: B5                                or      l
A9D6: CA F1 A9                          jp      z,LA9F1
A9D9: 2B                                dec     hl
A9DA: E5                                push    hl
A9DB: 21 80 00                          ld      hl,0080h
A9DE: 19                                add     hl,de
A9DF: E5                                push    hl
A9E0: CD D8 A5                          call    LA5D8
A9E3: 11 CD AB                          ld      de,0ABCDh
A9E6: CD 04 A5                          call    LA504
A9E9: D1                                pop     de
A9EA: E1                                pop     hl
A9EB: C2 FB A9                          jp      nz,LA9FB
A9EE: C3 D4 A9                          jp      LA9D4

                                        ; Referenced from A9D6
A9F1: 11 CD AB                   LA9F1: ld      de,0ABCDh
A9F4: CD DA A4                          call    LA4DA
A9F7: 3C                                inc     a
A9F8: C2 01 AA                          jp      nz,LAA01

                                        ; Referenced from A9C5, A9EB
A9FB: 01 07 AA                   LA9FB: ld      bc,0AA07h
A9FE: CD A7 A4                          call    LA4A7

                                        ; Referenced from A9F8
AA01: CD D5 A5                   LAA01: call    LA5D5
AA04: C3 86 AB                          jp      LAB86

AA07: 4E                         LAA07: ld      c,(hl)
AA08: 4F                                ld      c,a
AA09: 20 53                             jr      nz,LAA5E
AA0B: 50                                ld      d,b
AA0C: 41                                ld      b,c
AA0D: 43                                ld      b,e
AA0E: 45                                ld      b,l
AA0F: 00                                nop
AA10: CD 5E A6                          call    LA65E
AA13: C2 09 A6                          jp      nz,LA609
AA16: 3A F0 AB                          ld      a,(LABF0)
AA19: F5                                push    af
AA1A: CD 54 A8                          call    LA854
AA1D: CD E9 A4                          call    LA4E9
AA20: C2 79 AA                          jp      nz,LAA79
AA23: 21 CD AB                          ld      hl,0ABCDh
AA26: 11 DD AB                          ld      de,0ABDDh
AA29: 06 10                             ld      b,10h
AA2B: CD 42 A8                          call    LA842
AA2E: 2A 88 A4                          ld      hl,(LA488)
AA31: EB                                ex      de,hl
AA32: CD 4F A6                          call    LA64F
AA35: FE 3D                             cp      3Dh     ; '='
AA37: CA 3F AA                          jp      z,LAA3F
AA3A: FE 5F                             cp      5Fh     ; '_'
AA3C: C2 73 AA                          jp      nz,LAA73

                                        ; Referenced from AA37
AA3F: EB                         LAA3F: ex      de,hl
AA40: 23                                inc     hl
AA41: 22 88 A4                          ld      (LA488),hl
AA44: CD 5E A6                          call    LA65E
AA47: C2 73 AA                          jp      nz,LAA73
AA4A: F1                                pop     af
AA4B: 47                                ld      b,a
AA4C: 21 F0 AB                          ld      hl,0ABF0h
AA4F: 7E                                ld      a,(hl)
AA50: B7                                or      a
AA51: CA 59 AA                          jp      z,LAA59
AA54: B8                                cp      b
AA55: 70                                ld      (hl),b
AA56: C2 73 AA                          jp      nz,LAA73

                                        ; Referenced from AA51
AA59: 70                         LAA59: ld      (hl),b
AA5A: AF                                xor     a
AA5B: 32 CD AB                          ld      (LABCD),a

                                        ; Referenced from AA09
AA5E: CD E9 A4                   LAA5E: call    LA4E9
AA61: CA 6D AA                          jp      z,LAA6D
AA64: 11 CD AB                          ld      de,0ABCDh
AA67: CD 0E A5                          call    LA50E
AA6A: C3 86 AB                          jp      LAB86

                                        ; Referenced from AA61
AA6D: CD EA A7                   LAA6D: call    LA7EA
AA70: C3 86 AB                          jp      LAB86

                                        ; Referenced from AA3C, AA47, AA56
AA73: CD 66 A8                   LAA73: call    LA866
AA76: C3 09 A6                          jp      LA609

                                        ; Referenced from AA20
AA79: 01 82 AA                   LAA79: ld      bc,0AA82h
AA7C: CD A7 A4                          call    LA4A7
AA7F: C3 86 AB                          jp      LAB86

AA82: 46                         LAA82: ld      b,(hl)
AA83: 49                                ld      c,c
AA84: 4C                                ld      c,h
AA85: 45                                ld      b,l
AA86: 20 45                             jr      nz,LAACD
AA88: 58                                ld      e,b
AA89: 49                                ld      c,c
AA8A: 53                                ld      d,e
AA8B: 54                                ld      d,h
AA8C: 53                                ld      d,e
AA8D: 00                                nop
AA8E: CD F8 A7                          call    LA7F8
AA91: FE 10                             cp      10h
AA93: D2 09 A6                          jp      nc,LA609
AA96: 5F                                ld      e,a
AA97: 3A CE AB                          ld      a,(LABCE)
AA9A: FE 20                             cp      20h     ; ' '
AA9C: CA 09 A6                          jp      z,LA609
AA9F: CD 15 A5                          call    LA515
AAA2: C3 89 AB                          jp      LAB89

                                        ; Referenced from A7AE
                                        ; --- START PROC LAAA5 ---
AAA5: CD F5 A5                   LAAA5: call    LA5F5
AAA8: 3A CE AB                          ld      a,(LABCE)
AAAB: FE 20                             cp      20h     ; ' '
AAAD: C2 C4 AA                          jp      nz,LAAC4
AAB0: 3A F0 AB                          ld      a,(LABF0)
AAB3: B7                                or      a
AAB4: CA 89 AB                          jp      z,LAB89
AAB7: 3D                                dec     a
AAB8: 32 EF AB                          ld      (LABEF),a
AABB: CD 29 A5                          call    LA529
AABE: CD BD A4                          call    LA4BD
AAC1: C3 89 AB                          jp      LAB89

                                        ; Referenced from AAAD
AAC4: 11 D6 AB                   LAAC4: ld      de,0ABD6h
AAC7: 1A                                ld      a,(de)
AAC8: FE 20                             cp      20h     ; ' '
AACA: C2 09 A6                          jp      nz,LA609

                                        ; Referenced from AA86
AACD: D5                         LAACD: push    de
AACE: CD 54 A8                          call    LA854
AAD1: D1                                pop     de
AAD2: 21 83 AB                          ld      hl,0AB83h
AAD5: CD 40 A8                          call    LA840
AAD8: CD D0 A4                          call    LA4D0
AADB: CA 6B AB                          jp      z,LAB6B
AADE: 21 00 01                          ld      hl,0100h

                                        ; Referenced from AAFE
AAE1: E5                         LAAE1: push    hl
AAE2: EB                                ex      de,hl
AAE3: CD D8 A5                          call    LA5D8
AAE6: 11 CD AB                          ld      de,0ABCDh
AAE9: CD F9 A4                          call    LA4F9
AAEC: C2 01 AB                          jp      nz,LAB01
AAEF: E1                                pop     hl
AAF0: 11 80 00                          ld      de,0080h
AAF3: 19                                add     hl,de
AAF4: 11 00 A4                          ld      de,0A400h
AAF7: 7D                                ld      a,l
AAF8: 93                                sub     e
AAF9: 7C                                ld      a,h
AAFA: 9A                                sbc     a,d
AAFB: D2 71 AB                          jp      nc,LAB71
AAFE: C3 E1 AA                          jp      LAAE1

                                        ; Referenced from AAEC
AB01: E1                         LAB01: pop     hl
AB02: 3D                                dec     a
AB03: C2 71 AB                          jp      nz,LAB71
AB06: CD 66 A8                          call    LA866
AB09: CD 5E A6                          call    LA65E
AB0C: 21 F0 AB                          ld      hl,0ABF0h
AB0F: E5                                push    hl
AB10: 7E                                ld      a,(hl)
AB11: 32 CD AB                          ld      (LABCD),a
AB14: 3E 10                             ld      a,10h
AB16: CD 60 A6                          call    LA660
AB19: E1                                pop     hl
AB1A: 7E                                ld      a,(hl)
AB1B: 32 DD AB                          ld      (LABDD),a
AB1E: AF                                xor     a
AB1F: 32 ED AB                          ld      (LABED),a
AB22: 11 5C 00                          ld      de,005Ch
AB25: 21 CD AB                          ld      hl,0ABCDh
AB28: 06 21                             ld      b,21h   ; '!'
AB2A: CD 42 A8                          call    LA842
AB2D: 21 08 A4                          ld      hl,0A408h

                                        ; Referenced from AB3B
AB30: 7E                         LAB30: ld      a,(hl)
AB31: B7                                or      a
AB32: CA 3E AB                          jp      z,LAB3E
AB35: FE 20                             cp      20h     ; ' '
AB37: CA 3E AB                          jp      z,LAB3E
AB3A: 23                                inc     hl
AB3B: C3 30 AB                          jp      LAB30

                                        ; Referenced from AB32, AB37
AB3E: 06 00                      LAB3E: ld      b,00h
AB40: 11 81 00                          ld      de,0081h

                                        ; Referenced from AB4C
AB43: 7E                         LAB43: ld      a,(hl)
AB44: 12                                ld      (de),a
AB45: B7                                or      a
AB46: CA 4F AB                          jp      z,LAB4F
AB49: 04                                inc     b
AB4A: 23                                inc     hl
AB4B: 13                                inc     de
AB4C: C3 43 AB                          jp      LAB43

                                        ; Referenced from AB46
AB4F: 78                         LAB4F: ld      a,b
AB50: 32 80 00                          ld      (0080h),a
AB53: CD 98 A4                          call    LA498
AB56: CD D5 A5                          call    LA5D5
AB59: CD 1A A5                          call    LA51A
AB5C: CD 00 01                          call    0100h
AB5F: 31 AB AB                          ld      sp,0ABABh
AB62: CD 29 A5                          call    LA529
AB65: CD BD A4                          call    LA4BD
AB68: C3 82 A7                          jp      LA782

                                        ; Referenced from AADB
AB6B: CD 66 A8                   LAB6B: call    LA866
AB6E: C3 09 A6                          jp      LA609

                                        ; Referenced from AAFB, AB03
AB71: 01 7A AB                   LAB71: ld      bc,0AB7Ah
AB74: CD A7 A4                          call    LA4A7
AB77: C3 86 AB                          jp      LAB86

AB7A: 42                         LAB7A: ld      b,d
AB7B: 41                                ld      b,c
AB7C: 44                                ld      b,h
AB7D: 20 4C                             jr      nz,LABCB
AB7F: 4F                                ld      c,a
AB80: 41                                ld      b,c
AB81: 44                                ld      b,h
AB82: 00                                nop
AB83: 43                                ld      b,e
AB84: 4F                                ld      c,a
AB85: 4D                                ld      c,l

                                        ; Referenced from A91C, A94F, A991, A99A, A9A1, AA04, AA6A, AA70, AA7F, AB77
                                        ; --- START PROC LAB86 ---
AB86: CD 66 A8                   LAB86: call    LA866

                                        ; Referenced from AAA2, AAB4, AAC1
AB89: CD 5E A6                   LAB89: call    LA65E
AB8C: 3A CE AB                          ld      a,(LABCE)
AB8F: D6 20                             sub     20h     ; ' '
AB91: 21 F0 AB                          ld      hl,0ABF0h
AB94: B6                                or      (hl)
AB95: C2 09 A6                          jp      nz,LA609
AB98: C3 82 A7                          jp      LA782

AB9B: 00                         LAB9B: nop
AB9C: 00                                nop
AB9D: 00                                nop
AB9E: 00                                nop
AB9F: 00                                nop
ABA0: 00                                nop
ABA1: 00                                nop
ABA2: 00                                nop
ABA3: 00                                nop
ABA4: 00                                nop
ABA5: 00                                nop
ABA6: 00                                nop
ABA7: 00                                nop
ABA8: 00                                nop
ABA9: 00                                nop
ABAA: 00                                nop

                                        ; Referenced from A539, A76E
ABAB: 00                         LABAB: nop
ABAC: 00                                nop
ABAD: 24                                inc     h
ABAE: 24                                inc     h
ABAF: 24                                inc     h
ABB0: 20 20                             jr      nz,LABD2
ABB2: 20 20                             jr      nz,LABD4
ABB4: 20 53                             jr      nz,LAC09
ABB6: 55                                ld      d,l
ABB7: 42                                ld      b,d
ABB8: 00                                nop
ABB9: 00                                nop
ABBA: 00                                nop

                                        ; Referenced from A552
ABBB: 00                         LABBB: nop
ABBC: 00                                nop
ABBD: 00                                nop
ABBE: 00                                nop
ABBF: 00                                nop
ABC0: 00                                nop
ABC1: 00                                nop
ABC2: 00                                nop
ABC3: 00                                nop
ABC4: 00                                nop
ABC5: 00                                nop
ABC6: 00                                nop
ABC7: 00                                nop
ABC8: 00                                nop
ABC9: 00                                nop
ABCA: 00                                nop

                                        ; Referenced from AB7D
ABCB: 00                         LABCB: nop

                                        ; Referenced from A556
ABCC: 00                         LABCC: nop

                                        ; Referenced from A855, AA5B, AB11
ABCD: 00                         LABCD: nop

                                        ; Referenced from AA97, AAA8, AB8C
ABCE: 00                         LABCE: nop
ABCF: 00                                nop
ABD0: 00                                nop
ABD1: 00                                nop

                                        ; Referenced from ABB0
ABD2: 00                         LABD2: nop
ABD3: 00                                nop

                                        ; Referenced from ABB2
ABD4: 00                         LABD4: nop
ABD5: 00                                nop
ABD6: 00                                nop
ABD7: 00                                nop
ABD8: 00                                nop
ABD9: 00                                nop
ABDA: 00                                nop
ABDB: 00                                nop
ABDC: 00                                nop

                                        ; Referenced from AB1B
ABDD: 00                         LABDD: nop
ABDE: 00                                nop
ABDF: 00                                nop
ABE0: 00                                nop
ABE1: 00                                nop
ABE2: 00                                nop
ABE3: 00                                nop
ABE4: 00                                nop
ABE5: 00                                nop
ABE6: 00                                nop
ABE7: 00                                nop
ABE8: 00                                nop
ABE9: 00                                nop
ABEA: 00                                nop
ABEB: 00                                nop
ABEC: 00                                nop

                                        ; Referenced from A4D1, A9C9, AB1F
ABED: 00                         LABED: nop

                                        ; Referenced from A4C6, A89B
ABEE: 00                         LABEE: nop

                                        ; Referenced from A529, A540, A57D, A5EF, A689, A775, A7A1, A871, AAB8
ABEF: 00                         LABEF: nop

                                        ; Referenced from A669, A691, A7AA, A7FB, A858, A866, AA16, AAB0
ABF0: 00                         LABF0: nop
ABF1: 00                                nop
ABF2: 00                                nop
ABF3: 00                                nop
ABF4: 00                                nop
ABF5: 00                                nop
ABF6: 00                                nop
ABF7: 00                                nop
ABF8: 00                                nop
ABF9: 00                                nop
ABFA: 00                                nop
ABFB: 00                                nop
ABFC: 00                                nop
ABFD: 00                                nop
ABFE: 00                                nop
ABFF: 00                                nop
AC00: 11 14 00                          ld      de,0014h
AC03: 00                                nop
AC04: 0A                                ld      a,(bc)
AC05: 64                                ld      h,h
AC06: C3 11 AC                          jp      LAC11

                                        ; Referenced from ABB4
AC09: 99                         LAC09: sbc     a,c
AC0A: AC                                xor     h
AC0B: A5                                and     l
AC0C: AC                                xor     h
AC0D: AB                                xor     e
AC0E: AC                                xor     h
AC0F: B1                                or      c
AC10: AC                                xor     h

                                        ; Referenced from AC06
AC11: EB                         LAC11: ex      de,hl
AC12: 22 43 AF                          ld      (LAF43),hl
AC15: EB                                ex      de,hl
AC16: 7B                                ld      a,e
AC17: 32 D6 B9                          ld      (LB9D6),a
AC1A: 21 00 00                          ld      hl,0000h
AC1D: 22 45 AF                          ld      (LAF45),hl
AC20: 39                                add     hl,sp
AC21: 22 0F AF                          ld      (LAF0F),hl
AC24: 31 41 AF                          ld      sp,0AF41h
AC27: AF                                xor     a
AC28: 32 E0 B9                          ld      (LB9E0),a
AC2B: 32 DE B9                          ld      (LB9DE),a
AC2E: 21 74 B9                          ld      hl,0B974h
AC31: E5                                push    hl
AC32: 79                                ld      a,c
AC33: FE 29                             cp      29h     ; ')'
AC35: D0                                ret     nc
AC36: 4B                                ld      c,e
AC37: 21 47 AC                          ld      hl,0AC47h
AC3A: 5F                                ld      e,a
AC3B: 16 00                             ld      d,00h
AC3D: 19                                add     hl,de
AC3E: 19                                add     hl,de
AC3F: 5E                                ld      e,(hl)
AC40: 23                                inc     hl
AC41: 56                                ld      d,(hl)
AC42: 2A 43 AF                          ld      hl,(LAF43)
AC45: EB                                ex      de,hl
AC46: E9                                jp      (hl)

AC47: 03                         LAC47: inc     bc
AC48: BA                                cp      d
AC49: C8                                ret     z
AC4A: AE                                xor     (hl)
AC4B: 90                                sub     b
AC4C: AD                                xor     l
AC4D: CE AE                             adc     a,0AEh
AC4F: 12                                ld      (de),a
AC50: BA                                cp      d
AC51: 0F                                rrca
AC52: BA                                cp      d
AC53: D4 AE ED                          call    nc,0EDAEh
AC56: AE                                xor     (hl)
AC57: F3                                di
AC58: AE                                xor     (hl)
AC59: F8                                ret     m
AC5A: AE                                xor     (hl)
AC5B: E1                                pop     hl
AC5C: AD                                xor     l
AC5D: FE AE                             cp      0AEh
AC5F: 7E                                ld      a,(hl)
AC60: B8                                cp      b
AC61: 83                                add     a,e
AC62: B8                                cp      b
AC63: 45                                ld      b,l
AC64: B8                                cp      b
AC65: 9C                                sbc     a,h
AC66: B8                                cp      b
AC67: A5                                and     l
AC68: B8                                cp      b
AC69: AB                                xor     e
AC6A: B8                                cp      b
AC6B: C8                                ret     z
AC6C: B8                                cp      b
AC6D: D7                                rst     0x10

AC6E: B8                         LAC6E: cp      b
AC6F: E0                                ret     po
AC70: B8                                cp      b
AC71: E6 B8                             and     0B8h
AC73: EC B8 F5                          call    pe,0F5B8h
AC76: B8                                cp      b
AC77: FE B8                             cp      0B8h
AC79: 04                                inc     b
AC7A: B9                                cp      c
AC7B: 0A                                ld      a,(bc)
AC7C: B9                                cp      c
AC7D: 11 B9 2C                          ld      de,2CB9h
AC80: B1                                or      c
AC81: 17                                rla
AC82: B9                                cp      c
AC83: 1D                                dec     e
AC84: B9                                cp      c
AC85: 26 B9                             ld      h,0B9h
AC87: 2D                                dec     l
AC88: B9                                cp      c
AC89: 41                                ld      b,c
AC8A: B9                                cp      c
AC8B: 47                                ld      b,a
AC8C: B9                                cp      c
AC8D: 4D                                ld      c,l
AC8E: B9                                cp      c
AC8F: 0E B8                             ld      c,0B8h
AC91: 53                                ld      d,e
AC92: B9                                cp      c
AC93: 04                                inc     b
AC94: AF                                xor     a
AC95: 04                                inc     b
AC96: AF                                xor     a
AC97: 9B                                sbc     a,e
AC98: B9                                cp      c
AC99: 21 CA AC                          ld      hl,0ACCAh
AC9C: CD E5 AC                          call    LACE5
AC9F: FE 03                             cp      03h
ACA1: CA 00 00                          jp      z,0000h
ACA4: C9                                ret

ACA5: 21 D5 AC                   LACA5: ld      hl,0ACD5h
ACA8: C3 B4 AC                          jp      LACB4

ACAB: 21 E1 AC                   LACAB: ld      hl,0ACE1h
ACAE: C3 B4 AC                          jp      LACB4

ACB1: 21 DC AC                   LACB1: ld      hl,0ACDCh

                                        ; Referenced from ACA8, ACAE
ACB4: CD E5 AC                   LACB4: call    LACE5
ACB7: C3 00 00                          jp      0000h

ACBA: 42                         LACBA: ld      b,d
ACBB: 64                                ld      h,h
ACBC: 6F                                ld      l,a
ACBD: 73                                ld      (hl),e
ACBE: 20 45                             jr      nz,LAD03+2      ; reference not aligned to instruction
ACC0: 72                                ld      (hl),d
ACC1: 72                                ld      (hl),d
ACC2: 20 4F                             jr      nz,LAD13
ACC4: 6E                                ld      l,(hl)

                                        ; Referenced from ACEE
ACC5: 20 20                      LACC5: jr      nz,LACE6+1      ; reference not aligned to instruction
ACC7: 3A 20 24                          ld      a,(2420h)
ACCA: 42                                ld      b,d
ACCB: 61                                ld      h,c
ACCC: 64                                ld      h,h
ACCD: 20 53                             jr      nz,LAD22
ACCF: 65                                ld      h,l
ACD0: 63                                ld      h,e
ACD1: 74                                ld      (hl),h
ACD2: 6F                                ld      l,a
ACD3: 72                                ld      (hl),d
ACD4: 24                                inc     h
ACD5: 53                                ld      d,e
ACD6: 65                                ld      h,l
ACD7: 6C                                ld      l,h
ACD8: 65                                ld      h,l
ACD9: 63                                ld      h,e
ACDA: 74                                ld      (hl),h
ACDB: 24                                inc     h
ACDC: 46                                ld      b,(hl)
ACDD: 69                                ld      l,c
ACDE: 6C                                ld      l,h
ACDF: 65                                ld      h,l
ACE0: 20 52                             jr      nz,LAD33+1      ; reference not aligned to instruction
ACE2: 2F                                cpl
ACE3: 4F                                ld      c,a
ACE4: 24                                inc     h

                                        ; Referenced from AC9C, ACB4
                                        ; --- START PROC LACE5 ---
ACE5: E5                         LACE5: push    hl

                                        ; Referenced from ACC5
ACE6: CD C9 AD                   LACE6: call    LADC9
ACE9: 3A 42 AF                          ld      a,(LAF42)
ACEC: C6 41                             add     a,41h   ; 'A'
ACEE: 32 C6 AC                          ld      (LACC5+1),a     ; reference not aligned to instruction
ACF1: 01 BA AC                          ld      bc,0ACBAh
ACF4: CD D3 AD                          call    LADD3
ACF7: C1                                pop     bc
ACF8: CD D3 AD                          call    LADD3

                                        ; Referenced from AD06, ADF1
                                        ; --- START PROC LACFB ---
ACFB: 21 0E AF                   LACFB: ld      hl,0AF0Eh
ACFE: 7E                                ld      a,(hl)
ACFF: 36 00                             ld      (hl),00h
AD01: B7                                or      a
AD02: C0                                ret     nz

                                        ; Referenced from ACBE
AD03: C3 09 BA                   LAD03: jp      LBA09

                                        ; Referenced from AEC8
                                        ; --- START PROC LAD06 ---
AD06: CD FB AC                   LAD06: call    LACFB
AD09: CD 14 AD                          call    LAD14
AD0C: D8                                ret     c
AD0D: F5                                push    af
AD0E: 4F                                ld      c,a
AD0F: CD 90 AD                          call    LAD90
AD12: F1                                pop     af

                                        ; Referenced from ACC2
AD13: C9                         LAD13: ret

                                        ; Referenced from AD09, AD80
                                        ; --- START PROC LAD14 ---
AD14: FE 0D                      LAD14: cp      0Dh
AD16: C8                                ret     z
AD17: FE 0A                             cp      0Ah
AD19: C8                                ret     z
AD1A: FE 09                             cp      09h
AD1C: C8                                ret     z
AD1D: FE 08                             cp      08h
AD1F: C8                                ret     z
AD20: FE 20                             cp      20h     ; ' '

                                        ; Referenced from ACCD
AD22: C9                         LAD22: ret

                                        ; Referenced from AD50, AEFE
                                        ; --- START PROC LAD23 ---
AD23: 3A 0E AF                   LAD23: ld      a,(LAF0E)
AD26: B7                                or      a
AD27: C2 45 AD                          jp      nz,LAD45
AD2A: CD 06 BA                          call    LBA06
AD2D: E6 01                             and     01h
AD2F: C8                                ret     z
AD30: CD 09 BA                          call    LBA09

                                        ; Referenced from ACE0
AD33: FE 13                      LAD33: cp      13h
AD35: C2 42 AD                          jp      nz,LAD42
AD38: CD 09 BA                          call    LBA09
AD3B: FE 03                             cp      03h
AD3D: CA 00 00                          jp      z,0000h
AD40: AF                                xor     a
AD41: C9                                ret

                                        ; Referenced from AD35
AD42: 32 0E AF                   LAD42: ld      (LAF0E),a

                                        ; Referenced from AD27
AD45: 3E 01                      LAD45: ld      a,01h
AD47: C9                                ret

                                        ; Referenced from AD89, AD93, AD98, ADB3, ADC3, ADCB, ADD0, AEC5
                                        ; --- START PROC LAD48 ---
AD48: 3A 0A AF                   LAD48: ld      a,(LAF0A)
AD4B: B7                                or      a
AD4C: C2 62 AD                          jp      nz,LAD62
AD4F: C5                                push    bc
AD50: CD 23 AD                          call    LAD23
AD53: C1                                pop     bc
AD54: C5                                push    bc
AD55: CD 0C BA                          call    LBA0C
AD58: C1                                pop     bc
AD59: C5                                push    bc
AD5A: 3A 0D AF                          ld      a,(LAF0D)
AD5D: B7                                or      a
AD5E: C4 0F BA                          call    nz,LBA0F
AD61: C1                                pop     bc

                                        ; Referenced from AD4C
AD62: 79                         LAD62: ld      a,c
AD63: 21 0C AF                          ld      hl,0AF0Ch
AD66: FE 7F                             cp      7Fh     ; ''
AD68: C8                                ret     z
AD69: 34                                inc     (hl)
AD6A: FE 20                             cp      20h     ; ' '
AD6C: D0                                ret     nc
AD6D: 35                                dec     (hl)
AD6E: 7E                                ld      a,(hl)
AD6F: B7                                or      a
AD70: C8                                ret     z
AD71: 79                                ld      a,c
AD72: FE 08                             cp      08h
AD74: C2 79 AD                          jp      nz,LAD79
AD77: 35                                dec     (hl)
AD78: C9                                ret

                                        ; Referenced from AD74
AD79: FE 0A                      LAD79: cp      0Ah
AD7B: C0                                ret     nz
AD7C: 36 00                             ld      (hl),00h
AD7E: C9                                ret

                                        ; Referenced from AE82, AEAC
                                        ; --- START PROC LAD7F ---
AD7F: 79                         LAD7F: ld      a,c
AD80: CD 14 AD                          call    LAD14
AD83: D2 90 AD                          jp      nc,LAD90
AD86: F5                                push    af
AD87: 0E 5E                             ld      c,5Eh   ; '^'
AD89: CD 48 AD                          call    LAD48
AD8C: F1                                pop     af
AD8D: F6 40                             or      40h     ; '@'
AD8F: 4F                                ld      c,a

                                        ; Referenced from AD0F, AD83, ADDA
                                        ; --- START PROC LAD90 ---
AD90: 79                         LAD90: ld      a,c
AD91: FE 09                             cp      09h
AD93: C2 48 AD                          jp      nz,LAD48

                                        ; Referenced from ADA0
AD96: 0E 20                      LAD96: ld      c,20h   ; ' '
AD98: CD 48 AD                          call    LAD48
AD9B: 3A 0C AF                          ld      a,(LAF0C)
AD9E: E6 07                             and     07h
ADA0: C2 96 AD                          jp      nz,LAD96
ADA3: C9                                ret

                                        ; Referenced from AE59, AE99
                                        ; --- START PROC LADA4 ---
ADA4: CD AC AD                   LADA4: call    LADAC
ADA7: 0E 20                             ld      c,20h   ; ' '
ADA9: CD 0C BA                          call    LBA0C

                                        ; Referenced from ADA4
                                        ; --- START PROC LADAC ---
ADAC: 0E 08                      LADAC: ld      c,08h
ADAE: C3 0C BA                          jp      LBA0C

                                        ; Referenced from AE64, AE71
                                        ; --- START PROC LADB1 ---
ADB1: 0E 23                      LADB1: ld      c,23h   ; '#'
ADB3: CD 48 AD                          call    LAD48
ADB6: CD C9 AD                          call    LADC9

                                        ; Referenced from ADC6
ADB9: 3A 0C AF                   LADB9: ld      a,(LAF0C)
ADBC: 21 0B AF                          ld      hl,0AF0Bh
ADBF: BE                                cp      (hl)
ADC0: D0                                ret     nc
ADC1: 0E 20                             ld      c,20h   ; ' '
ADC3: CD 48 AD                          call    LAD48
ADC6: C3 B9 AD                          jp      LADB9

                                        ; Referenced from ACE6, ADB6, AE2D
                                        ; --- START PROC LADC9 ---
ADC9: 0E 0D                      LADC9: ld      c,0Dh
ADCB: CD 48 AD                          call    LAD48
ADCE: 0E 0A                             ld      c,0Ah
ADD0: C3 48 AD                          jp      LAD48

                                        ; Referenced from ACF4, ACF8, ADDE, AEFB
                                        ; --- START PROC LADD3 ---
ADD3: 0A                         LADD3: ld      a,(bc)
ADD4: FE 24                             cp      24h     ; '$'
ADD6: C8                                ret     z
ADD7: 03                                inc     bc
ADD8: C5                                push    bc
ADD9: 4F                                ld      c,a
ADDA: CD 90 AD                          call    LAD90
ADDD: C1                                pop     bc
ADDE: C3 D3 AD                          jp      LADD3

                                        ; Referenced from AE55, AE68
ADE1: 3A 0C AF                   LADE1: ld      a,(LAF0C)
ADE4: 32 0B AF                          ld      (LAF0B),a
ADE7: 2A 43 AF                          ld      hl,(LAF43)
ADEA: 4E                                ld      c,(hl)
ADEB: 23                                inc     hl
ADEC: E5                                push    hl
ADED: 06 00                             ld      b,00h

                                        ; Referenced from AE09, AE1D, AE45, AEBE
ADEF: C5                         LADEF: push    bc
ADF0: E5                                push    hl

                                        ; Referenced from AE34, AE8F, AEA3
ADF1: CD FB AC                   LADF1: call    LACFB
ADF4: E6 7F                             and     7Fh     ; ''
ADF6: E1                                pop     hl
ADF7: C1                                pop     bc
ADF8: FE 0D                             cp      0Dh
ADFA: CA C1 AE                          jp      z,LAEC1
ADFD: FE 0A                             cp      0Ah
ADFF: CA C1 AE                          jp      z,LAEC1
AE02: FE 08                             cp      08h
AE04: C2 16 AE                          jp      nz,LAE16
AE07: 78                                ld      a,b
AE08: B7                                or      a
AE09: CA EF AD                          jp      z,LADEF
AE0C: 05                                dec     b
AE0D: 3A 0C AF                          ld      a,(LAF0C)
AE10: 32 0A AF                          ld      (LAF0A),a
AE13: C3 70 AE                          jp      LAE70

                                        ; Referenced from AE04
AE16: FE 7F                      LAE16: cp      7Fh     ; ''
AE18: C2 26 AE                          jp      nz,LAE26
AE1B: 78                                ld      a,b
AE1C: B7                                or      a
AE1D: CA EF AD                          jp      z,LADEF
AE20: 7E                                ld      a,(hl)
AE21: 05                                dec     b
AE22: 2B                                dec     hl
AE23: C3 A9 AE                          jp      LAEA9

                                        ; Referenced from AE18
AE26: FE 05                      LAE26: cp      05h
AE28: C2 37 AE                          jp      nz,LAE37
AE2B: C5                                push    bc
AE2C: E5                                push    hl
AE2D: CD C9 AD                          call    LADC9
AE30: AF                                xor     a
AE31: 32 0B AF                          ld      (LAF0B),a
AE34: C3 F1 AD                          jp      LADF1

                                        ; Referenced from AE28
AE37: FE 10                      LAE37: cp      10h
AE39: C2 48 AE                          jp      nz,LAE48
AE3C: E5                                push    hl
AE3D: 21 0D AF                          ld      hl,0AF0Dh
AE40: 3E 01                             ld      a,01h
AE42: 96                                sub     (hl)
AE43: 77                                ld      (hl),a
AE44: E1                                pop     hl
AE45: C3 EF AD                          jp      LADEF

                                        ; Referenced from AE39
AE48: FE 18                      LAE48: cp      18h
AE4A: C2 5F AE                          jp      nz,LAE5F
AE4D: E1                                pop     hl

                                        ; Referenced from AE5C
AE4E: 3A 0B AF                   LAE4E: ld      a,(LAF0B)
AE51: 21 0C AF                          ld      hl,0AF0Ch
AE54: BE                                cp      (hl)
AE55: D2 E1 AD                          jp      nc,LADE1
AE58: 35                                dec     (hl)
AE59: CD A4 AD                          call    LADA4
AE5C: C3 4E AE                          jp      LAE4E

                                        ; Referenced from AE4A
AE5F: FE 15                      LAE5F: cp      15h
AE61: C2 6B AE                          jp      nz,LAE6B
AE64: CD B1 AD                          call    LADB1
AE67: E1                                pop     hl
AE68: C3 E1 AD                          jp      LADE1

                                        ; Referenced from AE61
AE6B: FE 12                      LAE6B: cp      12h
AE6D: C2 A6 AE                          jp      nz,LAEA6

                                        ; Referenced from AE13
AE70: C5                         LAE70: push    bc
AE71: CD B1 AD                          call    LADB1
AE74: C1                                pop     bc
AE75: E1                                pop     hl
AE76: E5                                push    hl
AE77: C5                                push    bc

                                        ; Referenced from AE87
AE78: 78                         LAE78: ld      a,b
AE79: B7                                or      a
AE7A: CA 8A AE                          jp      z,LAE8A
AE7D: 23                                inc     hl
AE7E: 4E                                ld      c,(hl)
AE7F: 05                                dec     b
AE80: C5                                push    bc
AE81: E5                                push    hl
AE82: CD 7F AD                          call    LAD7F
AE85: E1                                pop     hl
AE86: C1                                pop     bc
AE87: C3 78 AE                          jp      LAE78

                                        ; Referenced from AE7A
AE8A: E5                         LAE8A: push    hl
AE8B: 3A 0A AF                          ld      a,(LAF0A)
AE8E: B7                                or      a
AE8F: CA F1 AD                          jp      z,LADF1
AE92: 21 0C AF                          ld      hl,0AF0Ch
AE95: 96                                sub     (hl)
AE96: 32 0A AF                          ld      (LAF0A),a

                                        ; Referenced from AEA0
AE99: CD A4 AD                   LAE99: call    LADA4
AE9C: 21 0A AF                          ld      hl,0AF0Ah
AE9F: 35                                dec     (hl)
AEA0: C2 99 AE                          jp      nz,LAE99
AEA3: C3 F1 AD                          jp      LADF1

                                        ; Referenced from AE6D
AEA6: 23                         LAEA6: inc     hl
AEA7: 77                                ld      (hl),a
AEA8: 04                                inc     b

                                        ; Referenced from AE23
AEA9: C5                         LAEA9: push    bc
AEAA: E5                                push    hl
AEAB: 4F                                ld      c,a
AEAC: CD 7F AD                          call    LAD7F
AEAF: E1                                pop     hl
AEB0: C1                                pop     bc
AEB1: 7E                                ld      a,(hl)
AEB2: FE 03                             cp      03h
AEB4: 78                                ld      a,b
AEB5: C2 BD AE                          jp      nz,LAEBD
AEB8: FE 01                             cp      01h
AEBA: CA 00 00                          jp      z,0000h

                                        ; Referenced from AEB5
AEBD: B9                         LAEBD: cp      c
AEBE: DA EF AD                          jp      c,LADEF

                                        ; Referenced from ADFA, ADFF
AEC1: E1                         LAEC1: pop     hl
AEC2: 70                                ld      (hl),b
AEC3: 0E 0D                             ld      c,0Dh
AEC5: C3 48 AD                          jp      LAD48

AEC8: CD 06 AD                   LAEC8: call    LAD06
AECB: C3 01 AF                          jp      LAF01

AECE: CD 15 BA                   LAECE: call    LBA15
AED1: C3 01 AF                          jp      LAF01

AED4: 79                         LAED4: ld      a,c
AED5: 3C                                inc     a
AED6: CA E0 AE                          jp      z,LAEE0
AED9: 3C                                inc     a
AEDA: CA 06 BA                          jp      z,LBA06
AEDD: C3 0C BA                          jp      LBA0C

                                        ; Referenced from AED6
AEE0: CD 06 BA                   LAEE0: call    LBA06
AEE3: B7                                or      a
AEE4: CA 91 B9                          jp      z,LB991
AEE7: CD 09 BA                          call    LBA09
AEEA: C3 01 AF                          jp      LAF01

AEED: 3A 03 00                   LAEED: ld      a,(0003h)
AEF0: C3 01 AF                          jp      LAF01

AEF3: 21 03 00                   LAEF3: ld      hl,0003h
AEF6: 71                                ld      (hl),c
AEF7: C9                                ret

AEF8: EB                         LAEF8: ex      de,hl
AEF9: 4D                                ld      c,l
AEFA: 44                                ld      b,h
AEFB: C3 D3 AD                          jp      LADD3

AEFE: CD 23 AD                   LAEFE: call    LAD23

                                        ; Referenced from AECB, AED1, AEEA, AEF0, AF07, B304, B399, B5B3, B645, B781, B880, B907, B938
                                        ; --- START PROC LAF01 ---
AF01: 32 45 AF                   LAF01: ld      (LAF45),a
AF04: C9                                ret

                                        ; Referenced from B5B6, B5FB, B619
                                        ; --- START PROC LAF05 ---
AF05: 3E 01                      LAF05: ld      a,01h
AF07: C3 01 AF                          jp      LAF01

                                        ; Referenced from AD48, AE10, AE8B, AE96
AF0A: 00                         LAF0A: nop

                                        ; Referenced from ADE4, AE31, AE4E
AF0B: 00                         LAF0B: nop

                                        ; Referenced from AD9B, ADB9, ADE1, AE0D
AF0C: 00                         LAF0C: nop

                                        ; Referenced from AD5A
AF0D: 00                         LAF0D: nop

                                        ; Referenced from AD23, AD42
AF0E: 00                         LAF0E: nop

                                        ; Referenced from AC21, B991
AF0F: 00                         LAF0F: nop
AF10: 00                                nop
AF11: 00                                nop
AF12: 00                                nop
AF13: 00                                nop
AF14: 00                                nop
AF15: 00                                nop
AF16: 00                                nop
AF17: 00                                nop
AF18: 00                                nop
AF19: 00                                nop
AF1A: 00                                nop
AF1B: 00                                nop
AF1C: 00                                nop
AF1D: 00                                nop
AF1E: 00                                nop
AF1F: 00                                nop
AF20: 00                                nop
AF21: 00                                nop
AF22: 00                                nop
AF23: 00                                nop
AF24: 00                                nop
AF25: 00                                nop
AF26: 00                                nop
AF27: 00                                nop
AF28: 00                                nop
AF29: 00                                nop
AF2A: 00                                nop
AF2B: 00                                nop
AF2C: 00                                nop
AF2D: 00                                nop
AF2E: 00                                nop
AF2F: 00                                nop
AF30: 00                                nop
AF31: 00                                nop
AF32: 00                                nop
AF33: 00                                nop
AF34: 00                                nop
AF35: 00                                nop
AF36: 00                                nop
AF37: 00                                nop
AF38: 00                                nop
AF39: 00                                nop
AF3A: 00                                nop
AF3B: 00                                nop
AF3C: 00                                nop
AF3D: 00                                nop
AF3E: 00                                nop
AF3F: 00                                nop
AF40: 00                                nop

                                        ; Referenced from B2E4, B875, B935, B93D
AF41: 00                         LAF41: nop

                                        ; Referenced from ACE9, AF59, B10C, B121, B824, B865, B88D, B904
AF42: 00                         LAF42: nop

                                        ; Referenced from AC12, AC42, ADE7, B05E, B0A6, B0AE, B169, B321, B404, B41E, B464, B48B, B4C7, B527, B52E, B53A, B565, B60B, B64C, B708, B7D7, B80E, B856, B878, B8CB, B953, B97B
AF43: 00                         LAF43: nop
AF44: 00                                nop

                                        ; Referenced from AC1D, AF01, B2F3, B388, B4A3, B5DF, B66E, B750, B764, B778, B78D, B929, B995
AF45: 00                         LAF45: nop
AF46: 00                                nop

                                        ; Referenced from B831
                                        ; --- START PROC LAF47 ---
AF47: 21 0B AC                   LAF47: ld      hl,0AC0Bh

                                        ; Referenced from AFC0, B151, B15B
                                        ; --- START PROC LAF4A ---
AF4A: 5E                         LAF4A: ld      e,(hl)
AF4B: 23                                inc     hl
AF4C: 56                                ld      d,(hl)
AF4D: EB                                ex      de,hl
AF4E: E9                                jp      (hl)

                                        ; Referenced from AF7F, AF8B, B1F2, B40D, B46A
                                        ; --- START PROC LAF4F ---
AF4F: 0C                         LAF4F: inc     c

                                        ; Referenced from AF56
AF50: 0D                         LAF50: dec     c
AF51: C8                                ret     z
AF52: 1A                                ld      a,(de)
AF53: 77                                ld      (hl),a
AF54: 13                                inc     de
AF55: 23                                inc     hl
AF56: C3 50 AF                          jp      LAF50

                                        ; Referenced from B82D
                                        ; --- START PROC LAF59 ---
AF59: 3A 42 AF                   LAF59: ld      a,(LAF42)
AF5C: 4F                                ld      c,a
AF5D: CD 1B BA                          call    LBA1B
AF60: 7C                                ld      a,h
AF61: B5                                or      l
AF62: C8                                ret     z
AF63: 5E                                ld      e,(hl)
AF64: 23                                inc     hl
AF65: 56                                ld      d,(hl)
AF66: 23                                inc     hl
AF67: 22 B3 B9                          ld      (LB9B3),hl
AF6A: 23                                inc     hl
AF6B: 23                                inc     hl
AF6C: 22 B5 B9                          ld      (LB9B5),hl
AF6F: 23                                inc     hl
AF70: 23                                inc     hl
AF71: 22 B7 B9                          ld      (LB9B7),hl
AF74: 23                                inc     hl
AF75: 23                                inc     hl
AF76: EB                                ex      de,hl
AF77: 22 D0 B9                          ld      (LB9D0),hl
AF7A: 21 B9 B9                          ld      hl,0B9B9h
AF7D: 0E 08                             ld      c,08h
AF7F: CD 4F AF                          call    LAF4F
AF82: 2A BB B9                          ld      hl,(LB9BB)
AF85: EB                                ex      de,hl
AF86: 21 C1 B9                          ld      hl,0B9C1h
AF89: 0E 0F                             ld      c,0Fh
AF8B: CD 4F AF                          call    LAF4F
AF8E: 2A C6 B9                          ld      hl,(LB9C6)
AF91: 7C                                ld      a,h
AF92: 21 DD B9                          ld      hl,0B9DDh
AF95: 36 FF                             ld      (hl),0FFh
AF97: B7                                or      a
AF98: CA 9D AF                          jp      z,LAF9D
AF9B: 36 00                             ld      (hl),00h

                                        ; Referenced from AF98
AF9D: 3E FF                      LAF9D: ld      a,0FFh
AF9F: B7                                or      a
AFA0: C9                                ret

                                        ; Referenced from B2C4, B32A
                                        ; --- START PROC LAFA1 ---
AFA1: CD 18 BA                   LAFA1: call    LBA18
AFA4: AF                                xor     a
AFA5: 2A B5 B9                          ld      hl,(LB9B5)
AFA8: 77                                ld      (hl),a
AFA9: 23                                inc     hl
AFAA: 77                                ld      (hl),a
AFAB: 2A B7 B9                          ld      hl,(LB9B7)
AFAE: 77                                ld      (hl),a
AFAF: 23                                inc     hl
AFB0: 77                                ld      (hl),a
AFB1: C9                                ret

                                        ; Referenced from B1D7, B5F5
                                        ; --- START PROC LAFB2 ---
AFB2: CD 27 BA                   LAFB2: call    LBA27
AFB5: C3 BB AF                          jp      LAFBB

                                        ; Referenced from B1CE, B6A2, B6C0
                                        ; --- START PROC LAFB8 ---
AFB8: CD 2A BA                   LAFB8: call    LBA2A

                                        ; Referenced from AFB5
                                        ; --- START PROC LAFBB ---
AFBB: B7                         LAFBB: or      a
AFBC: C8                                ret     z
AFBD: 21 09 AC                          ld      hl,0AC09h
AFC0: C3 4A AF                          jp      LAF4A

                                        ; Referenced from B22B, B410
                                        ; --- START PROC LAFC3 ---
AFC3: 2A EA B9                   LAFC3: ld      hl,(LB9EA)
AFC6: 0E 02                             ld      c,02h
AFC8: CD EA B0                          call    LB0EA
AFCB: 22 E5 B9                          ld      (LB9E5),hl
AFCE: 22 EC B9                          ld      (LB9EC),hl

                                        ; Referenced from B5F2, B69E, B6BB
                                        ; --- START PROC LAFD1 ---
AFD1: 21 E5 B9                   LAFD1: ld      hl,0B9E5h
AFD4: 4E                                ld      c,(hl)
AFD5: 23                                inc     hl
AFD6: 46                                ld      b,(hl)
AFD7: 2A B7 B9                          ld      hl,(LB9B7)
AFDA: 5E                                ld      e,(hl)
AFDB: 23                                inc     hl
AFDC: 56                                ld      d,(hl)
AFDD: 2A B5 B9                          ld      hl,(LB9B5)
AFE0: 7E                                ld      a,(hl)
AFE1: 23                                inc     hl
AFE2: 66                                ld      h,(hl)
AFE3: 6F                                ld      l,a

                                        ; Referenced from AFF7
AFE4: 79                         LAFE4: ld      a,c
AFE5: 93                                sub     e
AFE6: 78                                ld      a,b
AFE7: 9A                                sbc     a,d
AFE8: D2 FA AF                          jp      nc,LAFFA
AFEB: E5                                push    hl
AFEC: 2A C1 B9                          ld      hl,(LB9C1)
AFEF: 7B                                ld      a,e
AFF0: 95                                sub     l
AFF1: 5F                                ld      e,a
AFF2: 7A                                ld      a,d
AFF3: 9C                                sbc     a,h
AFF4: 57                                ld      d,a
AFF5: E1                                pop     hl
AFF6: 2B                                dec     hl
AFF7: C3 E4 AF                          jp      LAFE4

                                        ; Referenced from AFE8, B00C
AFFA: E5                         LAFFA: push    hl
AFFB: 2A C1 B9                          ld      hl,(LB9C1)
AFFE: 19                                add     hl,de
AFFF: DA 0F B0                          jp      c,LB00F
B002: 79                                ld      a,c
B003: 95                                sub     l
B004: 78                                ld      a,b
B005: 9C                                sbc     a,h
B006: DA 0F B0                          jp      c,LB00F
B009: EB                                ex      de,hl
B00A: E1                                pop     hl
B00B: 23                                inc     hl
B00C: C3 FA AF                          jp      LAFFA

                                        ; Referenced from AFFF, B006
B00F: E1                         LB00F: pop     hl
B010: C5                                push    bc
B011: D5                                push    de
B012: E5                                push    hl
B013: EB                                ex      de,hl
B014: 2A CE B9                          ld      hl,(LB9CE)
B017: 19                                add     hl,de
B018: 44                                ld      b,h
B019: 4D                                ld      c,l
B01A: CD 1E BA                          call    LBA1E
B01D: D1                                pop     de
B01E: 2A B5 B9                          ld      hl,(LB9B5)
B021: 73                                ld      (hl),e
B022: 23                                inc     hl
B023: 72                                ld      (hl),d
B024: D1                                pop     de
B025: 2A B7 B9                          ld      hl,(LB9B7)
B028: 73                                ld      (hl),e
B029: 23                                inc     hl
B02A: 72                                ld      (hl),d
B02B: C1                                pop     bc
B02C: 79                                ld      a,c
B02D: 93                                sub     e
B02E: 4F                                ld      c,a
B02F: 78                                ld      a,b
B030: 9A                                sbc     a,d
B031: 47                                ld      b,a
B032: 2A D0 B9                          ld      hl,(LB9D0)
B035: EB                                ex      de,hl
B036: CD 30 BA                          call    LBA30
B039: 4D                                ld      c,l
B03A: 44                                ld      b,h
B03B: C3 21 BA                          jp      LBA21

                                        ; Referenced from B077, B627
                                        ; --- START PROC LB03E ---
B03E: 21 C3 B9                   LB03E: ld      hl,0B9C3h
B041: 4E                                ld      c,(hl)
B042: 3A E3 B9                          ld      a,(LB9E3)

                                        ; Referenced from B048
B045: B7                         LB045: or      a
B046: 1F                                rra
B047: 0D                                dec     c
B048: C2 45 B0                          jp      nz,LB045
B04B: 47                                ld      b,a
B04C: 3E 08                             ld      a,08h
B04E: 96                                sub     (hl)
B04F: 4F                                ld      c,a
B050: 3A E2 B9                          ld      a,(LB9E2)

                                        ; Referenced from B059
B053: 0D                         LB053: dec     c
B054: CA 5C B0                          jp      z,LB05C
B057: B7                                or      a
B058: 17                                rla
B059: C3 53 B0                          jp      LB053

                                        ; Referenced from B054
B05C: 80                         LB05C: add     a,b
B05D: C9                                ret

                                        ; Referenced from B07D, B636
                                        ; --- START PROC LB05E ---
B05E: 2A 43 AF                   LB05E: ld      hl,(LAF43)
B061: 11 10 00                          ld      de,0010h
B064: 19                                add     hl,de
B065: 09                                add     hl,bc
B066: 3A DD B9                          ld      a,(LB9DD)
B069: B7                                or      a
B06A: CA 71 B0                          jp      z,LB071
B06D: 6E                                ld      l,(hl)
B06E: 26 00                             ld      h,00h
B070: C9                                ret

                                        ; Referenced from B06A
B071: 09                         LB071: add     hl,bc
B072: 5E                                ld      e,(hl)
B073: 23                                inc     hl
B074: 56                                ld      d,(hl)
B075: EB                                ex      de,hl
B076: C9                                ret

                                        ; Referenced from B5E6, B61C
                                        ; --- START PROC LB077 ---
B077: CD 3E B0                   LB077: call    LB03E
B07A: 4F                                ld      c,a
B07B: 06 00                             ld      b,00h
B07D: CD 5E B0                          call    LB05E
B080: 22 E5 B9                          ld      (LB9E5),hl
B083: C9                                ret

                                        ; Referenced from B5E9, B61F
                                        ; --- START PROC LB084 ---
B084: 2A E5 B9                   LB084: ld      hl,(LB9E5)
B087: 7D                                ld      a,l
B088: B4                                or      h
B089: C9                                ret

                                        ; Referenced from B5EF, B674
                                        ; --- START PROC LB08A ---
B08A: 3A C3 B9                   LB08A: ld      a,(LB9C3)
B08D: 2A E5 B9                          ld      hl,(LB9E5)

                                        ; Referenced from B092
B090: 29                         LB090: add     hl,hl
B091: 3D                                dec     a
B092: C2 90 B0                          jp      nz,LB090
B095: 22 E7 B9                          ld      (LB9E7),hl
B098: 3A C4 B9                          ld      a,(LB9C4)
B09B: 4F                                ld      c,a
B09C: 3A E3 B9                          ld      a,(LB9E3)
B09F: A1                                and     c
B0A0: B5                                or      l
B0A1: 6F                                ld      l,a
B0A2: 22 E5 B9                          ld      (LB9E5),hl
B0A5: C9                                ret

                                        ; Referenced from B0C7, B45A, B8B4
                                        ; --- START PROC LB0A6 ---
B0A6: 2A 43 AF                   LB0A6: ld      hl,(LAF43)
B0A9: 11 0C 00                          ld      de,000Ch
B0AC: 19                                add     hl,de
B0AD: C9                                ret

                                        ; Referenced from B0BB, B0D2
                                        ; --- START PROC LB0AE ---
B0AE: 2A 43 AF                   LB0AE: ld      hl,(LAF43)
B0B1: 11 0F 00                          ld      de,000Fh
B0B4: 19                                add     hl,de
B0B5: EB                                ex      de,hl
B0B6: 21 11 00                          ld      hl,0011h
B0B9: 19                                add     hl,de
B0BA: C9                                ret

                                        ; Referenced from B5AF, B5C6, B611
                                        ; --- START PROC LB0BB ---
B0BB: CD AE B0                   LB0BB: call    LB0AE
B0BE: 7E                                ld      a,(hl)
B0BF: 32 E3 B9                          ld      (LB9E3),a
B0C2: EB                                ex      de,hl
B0C3: 7E                                ld      a,(hl)
B0C4: 32 E1 B9                          ld      (LB9E1),a
B0C7: CD A6 B0                          call    LB0A6
B0CA: 3A C5 B9                          ld      a,(LB9C5)
B0CD: A6                                and     (hl)
B0CE: 32 E2 B9                          ld      (LB9E2),a
B0D1: C9                                ret

                                        ; Referenced from B5F8, B6EC, B700
                                        ; --- START PROC LB0D2 ---
B0D2: CD AE B0                   LB0D2: call    LB0AE
B0D5: 3A D5 B9                          ld      a,(LB9D5)
B0D8: FE 02                             cp      02h
B0DA: C2 DE B0                          jp      nz,LB0DE
B0DD: AF                                xor     a

                                        ; Referenced from B0DA
B0DE: 4F                         LB0DE: ld      c,a
B0DF: 3A E3 B9                          ld      a,(LB9E3)
B0E2: 81                                add     a,c
B0E3: 77                                ld      (hl),a
B0E4: EB                                ex      de,hl
B0E5: 3A E1 B9                          ld      a,(LB9E1)
B0E8: 77                                ld      (hl),a
B0E9: C9                                ret

                                        ; Referenced from AFC8, B125, B2A8, B828
                                        ; --- START PROC LB0EA ---
B0EA: 0C                         LB0EA: inc     c

                                        ; Referenced from B0F4
B0EB: 0D                         LB0EB: dec     c
B0EC: C8                                ret     z
B0ED: 7C                                ld      a,h
B0EE: B7                                or      a
B0EF: 1F                                rra
B0F0: 67                                ld      h,a
B0F1: 7D                                ld      a,l
B0F2: 1F                                rra
B0F3: 6F                                ld      l,a
B0F4: C3 EB B0                          jp      LB0EB

                                        ; Referenced from B1AA
                                        ; --- START PROC LB0F7 ---
B0F7: 0E 80                      LB0F7: ld      c,80h
B0F9: 2A B9 B9                          ld      hl,(LB9B9)
B0FC: AF                                xor     a

                                        ; Referenced from B100
B0FD: 86                         LB0FD: add     a,(hl)
B0FE: 23                                inc     hl
B0FF: 0D                                dec     c
B100: C2 FD B0                          jp      nz,LB0FD
B103: C9                                ret

                                        ; Referenced from B113
                                        ; --- START PROC LB104 ---
B104: 0C                         LB104: inc     c

                                        ; Referenced from B108
B105: 0D                         LB105: dec     c
B106: C8                                ret     z
B107: 29                                add     hl,hl
B108: C3 05 B1                          jp      LB105

                                        ; Referenced from B132, B83C
                                        ; --- START PROC LB10B ---
B10B: C5                         LB10B: push    bc
B10C: 3A 42 AF                          ld      a,(LAF42)
B10F: 4F                                ld      c,a
B110: 21 01 00                          ld      hl,0001h
B113: CD 04 B1                          call    LB104
B116: C1                                pop     bc
B117: 79                                ld      a,c
B118: B5                                or      l
B119: 6F                                ld      l,a
B11A: 78                                ld      a,b
B11B: B4                                or      h
B11C: 67                                ld      h,a
B11D: C9                                ret

                                        ; Referenced from B154, B4AC
                                        ; --- START PROC LB11E ---
B11E: 2A AD B9                   LB11E: ld      hl,(LB9AD)
B121: 3A 42 AF                          ld      a,(LAF42)
B124: 4F                                ld      c,a
B125: CD EA B0                          call    LB0EA
B128: 7D                                ld      a,l
B129: E6 01                             and     01h
B12B: C9                                ret

                                        ; Referenced from B1C0
                                        ; --- START PROC LB12C ---
B12C: 21 AD B9                   LB12C: ld      hl,0B9ADh
B12F: 4E                                ld      c,(hl)
B130: 23                                inc     hl
B131: 46                                ld      b,(hl)
B132: CD 0B B1                          call    LB10B
B135: 22 AD B9                          ld      (LB9AD),hl
B138: 2A C8 B9                          ld      hl,(LB9C8)
B13B: 23                                inc     hl
B13C: EB                                ex      de,hl
B13D: 2A B3 B9                          ld      hl,(LB9B3)
B140: 73                                ld      (hl),e
B141: 23                                inc     hl
B142: 72                                ld      (hl),d
B143: C9                                ret

                                        ; Referenced from B3A8, B42B
                                        ; --- START PROC LB144 ---
B144: CD 5E B1                   LB144: call    LB15E

                                        ; Referenced from B60E
                                        ; --- START PROC LB147 ---
B147: 11 09 00                   LB147: ld      de,0009h
B14A: 19                                add     hl,de
B14B: 7E                                ld      a,(hl)
B14C: 17                                rla
B14D: D0                                ret     nc
B14E: 21 0F AC                          ld      hl,0AC0Fh
B151: C3 4A AF                          jp      LAF4A

                                        ; Referenced from B39C, B416, B524, B608
                                        ; --- START PROC LB154 ---
B154: CD 1E B1                   LB154: call    LB11E
B157: C8                                ret     z
B158: 21 0D AC                          ld      hl,0AC0Dh
B15B: C3 4A AF                          jp      LAF4A

                                        ; Referenced from B144, B26B, B2DB, B34A, B3AB, B409, B460, B4C2, B7EA
                                        ; --- START PROC LB15E ---
B15E: 2A B9 B9                   LB15E: ld      hl,(LB9B9)
B161: 3A E9 B9                          ld      a,(LB9E9)

                                        ; Referenced from B65D
                                        ; --- START PROC LB164 ---
B164: 85                         LB164: add     a,l
B165: 6F                                ld      l,a
B166: D0                                ret     nc
B167: 24                                inc     h
B168: C9                                ret

                                        ; Referenced from B172, B178, B4B0, B6D8, B785
                                        ; --- START PROC LB169 ---
B169: 2A 43 AF                   LB169: ld      hl,(LAF43)
B16C: 11 0E 00                          ld      de,000Eh
B16F: 19                                add     hl,de
B170: 7E                                ld      a,(hl)
B171: C9                                ret

                                        ; Referenced from B89C, B8BA, B8EC
                                        ; --- START PROC LB172 ---
B172: CD 69 B1                   LB172: call    LB169
B175: 36 00                             ld      (hl),00h
B177: C9                                ret

                                        ; Referenced from B46D, B557, B5B9, B790
                                        ; --- START PROC LB178 ---
B178: CD 69 B1                   LB178: call    LB169
B17B: F6 80                             or      80h
B17D: 77                                ld      (hl),a
B17E: C9                                ret

                                        ; Referenced from B18C, B1BC, B343
                                        ; --- START PROC LB17F ---
B17F: 2A EA B9                   LB17F: ld      hl,(LB9EA)
B182: EB                                ex      de,hl
B183: 2A B3 B9                          ld      hl,(LB9B3)
B186: 7B                                ld      a,e
B187: 96                                sub     (hl)
B188: 23                                inc     hl
B189: 7A                                ld      a,d
B18A: 9E                                sbc     a,(hl)
B18B: C9                                ret

                                        ; Referenced from B2FB, B551
                                        ; --- START PROC LB18C ---
B18C: CD 7F B1                   LB18C: call    LB17F
B18F: D8                                ret     c
B190: 13                                inc     de
B191: 72                                ld      (hl),d
B192: 2B                                dec     hl
B193: 73                                ld      (hl),e
B194: C9                                ret

                                        ; Referenced from B1A5, B210
                                        ; --- START PROC LB195 ---
B195: 7B                         LB195: ld      a,e
B196: 95                                sub     l
B197: 6F                                ld      l,a
B198: 7A                                ld      a,d
B199: 9C                                sbc     a,h
B19A: 67                                ld      h,a
B19B: C9                                ret

                                        ; Referenced from B1C6
                                        ; --- START PROC LB19C ---
B19C: 0E FF                      LB19C: ld      c,0FFh

                                        ; Referenced from B232
                                        ; --- START PROC LB19E ---
B19E: 2A EC B9                   LB19E: ld      hl,(LB9EC)
B1A1: EB                                ex      de,hl
B1A2: 2A CC B9                          ld      hl,(LB9CC)
B1A5: CD 95 B1                          call    LB195
B1A8: D0                                ret     nc
B1A9: C5                                push    bc
B1AA: CD F7 B0                          call    LB0F7
B1AD: 2A BD B9                          ld      hl,(LB9BD)
B1B0: EB                                ex      de,hl
B1B1: 2A EC B9                          ld      hl,(LB9EC)
B1B4: 19                                add     hl,de
B1B5: C1                                pop     bc
B1B6: 0C                                inc     c
B1B7: CA C4 B1                          jp      z,LB1C4
B1BA: BE                                cp      (hl)
B1BB: C8                                ret     z
B1BC: CD 7F B1                          call    LB17F
B1BF: D0                                ret     nc
B1C0: CD 2C B1                          call    LB12C
B1C3: C9                                ret

                                        ; Referenced from B1B7
B1C4: 77                         LB1C4: ld      (hl),a
B1C5: C9                                ret

                                        ; Referenced from B3B5, B413
                                        ; --- START PROC LB1C6 ---
B1C6: CD 9C B1                   LB1C6: call    LB19C
B1C9: CD E0 B1                          call    LB1E0
B1CC: 0E 01                             ld      c,01h
B1CE: CD B8 AF                          call    LAFB8
B1D1: C3 DA B1                          jp      LB1DA

                                        ; Referenced from B22E
                                        ; --- START PROC LB1D4 ---
B1D4: CD E0 B1                   LB1D4: call    LB1E0
B1D7: CD B2 AF                          call    LAFB2

                                        ; Referenced from B1D1, B6B8, B896, B90E
                                        ; --- START PROC LB1DA ---
B1DA: 21 B1 B9                   LB1DA: ld      hl,0B9B1h
B1DD: C3 E3 B1                          jp      LB1E3

                                        ; Referenced from B1C9, B1D4, B692
                                        ; --- START PROC LB1E0 ---
B1E0: 21 B9 B9                   LB1E0: ld      hl,0B9B9h

                                        ; Referenced from B1DD
                                        ; --- START PROC LB1E3 ---
B1E3: 4E                         LB1E3: ld      c,(hl)
B1E4: 23                                inc     hl
B1E5: 46                                ld      b,(hl)
B1E6: C3 24 BA                          jp      LBA24

                                        ; Referenced from B8C5, B8D4
B1E9: 2A B9 B9                   LB1E9: ld      hl,(LB9B9)
B1EC: EB                                ex      de,hl
B1ED: 2A B1 B9                          ld      hl,(LB9B1)
B1F0: 0E 80                             ld      c,80h
B1F2: C3 4F AF                          jp      LAF4F

                                        ; Referenced from B2D7, B332, B3A4, B427, B440, B456, B4BB, B536, B561, B593, B5A3, B7E4
                                        ; --- START PROC LB1F5 ---
B1F5: 21 EA B9                   LB1F5: ld      hl,0B9EAh
B1F8: 7E                                ld      a,(hl)
B1F9: 23                                inc     hl
B1FA: BE                                cp      (hl)
B1FB: C0                                ret     nz
B1FC: 3C                                inc     a
B1FD: C9                                ret

                                        ; Referenced from B216, B2CF, B327, B394
                                        ; --- START PROC LB1FE ---
B1FE: 21 FF FF                   LB1FE: ld      hl,0FFFFh
B201: 22 EA B9                          ld      (LB9EA),hl
B204: C9                                ret

                                        ; Referenced from B2D4, B32F
                                        ; --- START PROC LB205 ---
B205: 2A C8 B9                   LB205: ld      hl,(LB9C8)
B208: EB                                ex      de,hl
B209: 2A EA B9                          ld      hl,(LB9EA)
B20C: 23                                inc     hl
B20D: 22 EA B9                          ld      (LB9EA),hl
B210: CD 95 B1                          call    LB195
B213: D2 19 B2                          jp      nc,LB219
B216: C3 FE B1                          jp      LB1FE

                                        ; Referenced from B213
B219: 3A EA B9                   LB219: ld      a,(LB9EA)
B21C: E6 03                             and     03h
B21E: 06 05                             ld      b,05h

                                        ; Referenced from B222
B220: 87                         LB220: add     a,a
B221: 05                                dec     b
B222: C2 20 B2                          jp      nz,LB220
B225: 32 E9 B9                          ld      (LB9E9),a
B228: B7                                or      a
B229: C0                                ret     nz
B22A: C5                                push    bc
B22B: CD C3 AF                          call    LAFC3
B22E: CD D4 B1                          call    LB1D4
B231: C1                                pop     bc
B232: C3 9E B1                          jp      LB19E

                                        ; Referenced from B25D, B3C8, B3E0
                                        ; --- START PROC LB235 ---
B235: 79                         LB235: ld      a,c
B236: E6 07                             and     07h
B238: 3C                                inc     a
B239: 5F                                ld      e,a
B23A: 57                                ld      d,a
B23B: 79                                ld      a,c
B23C: 0F                                rrca
B23D: 0F                                rrca
B23E: 0F                                rrca
B23F: E6 1F                             and     1Fh
B241: 4F                                ld      c,a
B242: 78                                ld      a,b
B243: 87                                add     a,a
B244: 87                                add     a,a
B245: 87                                add     a,a
B246: 87                                add     a,a
B247: 87                                add     a,a
B248: B1                                or      c
B249: 4F                                ld      c,a
B24A: 78                                ld      a,b
B24B: 0F                                rrca
B24C: 0F                                rrca
B24D: 0F                                rrca
B24E: E6 1F                             and     1Fh
B250: 47                                ld      b,a
B251: 2A BF B9                          ld      hl,(LB9BF)
B254: 09                                add     hl,bc
B255: 7E                                ld      a,(hl)

                                        ; Referenced from B258
B256: 07                         LB256: rlca
B257: 1D                                dec     e
B258: C2 56 B2                          jp      nz,LB256
B25B: C9                                ret

                                        ; Referenced from B29A
                                        ; --- START PROC LB25C ---
B25C: D5                         LB25C: push    de
B25D: CD 35 B2                          call    LB235
B260: E6 FE                             and     0FEh
B262: C1                                pop     bc
B263: B1                                or      c

                                        ; Referenced from B266, B3EE
                                        ; --- START PROC LB264 ---
B264: 0F                         LB264: rrca
B265: 15                                dec     d
B266: C2 64 B2                          jp      nz,LB264
B269: 77                                ld      (hl),a
B26A: C9                                ret

                                        ; Referenced from B2F8, B3B2
                                        ; --- START PROC LB26B ---
B26B: CD 5E B1                   LB26B: call    LB15E
B26E: 11 10 00                          ld      de,0010h
B271: 19                                add     hl,de
B272: C5                                push    bc
B273: 0E 11                             ld      c,11h

                                        ; Referenced from B2A0
B275: D1                         LB275: pop     de
B276: 0D                                dec     c
B277: C8                                ret     z
B278: D5                                push    de
B279: 3A DD B9                          ld      a,(LB9DD)
B27C: B7                                or      a
B27D: CA 88 B2                          jp      z,LB288
B280: C5                                push    bc
B281: E5                                push    hl
B282: 4E                                ld      c,(hl)
B283: 06 00                             ld      b,00h
B285: C3 8E B2                          jp      LB28E

                                        ; Referenced from B27D
B288: 0D                         LB288: dec     c
B289: C5                                push    bc
B28A: 4E                                ld      c,(hl)
B28B: 23                                inc     hl
B28C: 46                                ld      b,(hl)
B28D: E5                                push    hl

                                        ; Referenced from B285
B28E: 79                         LB28E: ld      a,c
B28F: B0                                or      b
B290: CA 9D B2                          jp      z,LB29D
B293: 2A C6 B9                          ld      hl,(LB9C6)
B296: 7D                                ld      a,l
B297: 91                                sub     c
B298: 7C                                ld      a,h
B299: 98                                sbc     a,b
B29A: D4 5C B2                          call    nc,LB25C

                                        ; Referenced from B290
B29D: E1                         LB29D: pop     hl
B29E: 23                                inc     hl
B29F: C1                                pop     bc
B2A0: C3 75 B2                          jp      LB275

                                        ; Referenced from B842
                                        ; --- START PROC LB2A3 ---
B2A3: 2A C6 B9                   LB2A3: ld      hl,(LB9C6)
B2A6: 0E 03                             ld      c,03h
B2A8: CD EA B0                          call    LB0EA
B2AB: 23                                inc     hl
B2AC: 44                                ld      b,h
B2AD: 4D                                ld      c,l
B2AE: 2A BF B9                          ld      hl,(LB9BF)

                                        ; Referenced from B2B7
B2B1: 36 00                      LB2B1: ld      (hl),00h
B2B3: 23                                inc     hl
B2B4: 0B                                dec     bc
B2B5: 78                                ld      a,b
B2B6: B1                                or      c
B2B7: C2 B1 B2                          jp      nz,LB2B1
B2BA: 2A CA B9                          ld      hl,(LB9CA)
B2BD: EB                                ex      de,hl
B2BE: 2A BF B9                          ld      hl,(LB9BF)
B2C1: 73                                ld      (hl),e
B2C2: 23                                inc     hl
B2C3: 72                                ld      (hl),d
B2C4: CD A1 AF                          call    LAFA1
B2C7: 2A B3 B9                          ld      hl,(LB9B3)
B2CA: 36 03                             ld      (hl),03h
B2CC: 23                                inc     hl
B2CD: 36 00                             ld      (hl),00h
B2CF: CD FE B1                          call    LB1FE

                                        ; Referenced from B2E1, B2FE
B2D2: 0E FF                      LB2D2: ld      c,0FFh
B2D4: CD 05 B2                          call    LB205
B2D7: CD F5 B1                          call    LB1F5
B2DA: C8                                ret     z
B2DB: CD 5E B1                          call    LB15E
B2DE: 3E E5                             ld      a,0E5h
B2E0: BE                                cp      (hl)
B2E1: CA D2 B2                          jp      z,LB2D2
B2E4: 3A 41 AF                          ld      a,(LAF41)
B2E7: BE                                cp      (hl)
B2E8: C2 F6 B2                          jp      nz,LB2F6
B2EB: 23                                inc     hl
B2EC: 7E                                ld      a,(hl)
B2ED: D6 24                             sub     24h     ; '$'
B2EF: C2 F6 B2                          jp      nz,LB2F6
B2F2: 3D                                dec     a
B2F3: 32 45 AF                          ld      (LAF45),a

                                        ; Referenced from B2E8, B2EF
B2F6: 0E 01                      LB2F6: ld      c,01h
B2F8: CD 6B B2                          call    LB26B
B2FB: CD 8C B1                          call    LB18C
B2FE: C3 D2 B2                          jp      LB2D2

                                        ; Referenced from B8DD, B8FB, B923
B301: 3A D4 B9                   LB301: ld      a,(LB9D4)
B304: C3 01 AF                          jp      LAF01

                                        ; Referenced from B375
                                        ; --- START PROC LB307 ---
B307: C5                         LB307: push    bc
B308: F5                                push    af
B309: 3A C5 B9                          ld      a,(LB9C5)
B30C: 2F                                cpl
B30D: 47                                ld      b,a
B30E: 79                                ld      a,c
B30F: A0                                and     b
B310: 4F                                ld      c,a
B311: F1                                pop     af
B312: A0                                and     b
B313: 91                                sub     c
B314: E6 1F                             and     1Fh
B316: C1                                pop     bc
B317: C9                                ret

                                        ; Referenced from B3A1, B41B, B43D, B453, B4B8, B533, B590, B7D4, B8C2
                                        ; --- START PROC LB318 ---
B318: 3E FF                      LB318: ld      a,0FFh
B31A: 32 D4 B9                          ld      (LB9D4),a
B31D: 21 D8 B9                          ld      hl,0B9D8h
B320: 71                                ld      (hl),c
B321: 2A 43 AF                          ld      hl,(LAF43)
B324: 22 D9 B9                          ld      (LB9D9),hl
B327: CD FE B1                          call    LB1FE
B32A: CD A1 AF                          call    LAFA1

                                        ; Referenced from B36D, B379, B3B8, B435, B44B, B806, B8D1
                                        ; --- START PROC LB32D ---
B32D: 0E 00                      LB32D: ld      c,00h
B32F: CD 05 B2                          call    LB205
B332: CD F5 B1                          call    LB1F5
B335: CA 94 B3                          jp      z,LB394
B338: 2A D9 B9                          ld      hl,(LB9D9)
B33B: EB                                ex      de,hl
B33C: 1A                                ld      a,(de)
B33D: FE E5                             cp      0E5h
B33F: CA 4A B3                          jp      z,LB34A
B342: D5                                push    de
B343: CD 7F B1                          call    LB17F
B346: D1                                pop     de
B347: D2 94 B3                          jp      nc,LB394

                                        ; Referenced from B33F
B34A: CD 5E B1                   LB34A: call    LB15E
B34D: 3A D8 B9                          ld      a,(LB9D8)
B350: 4F                                ld      c,a
B351: 06 00                             ld      b,00h

                                        ; Referenced from B380
B353: 79                         LB353: ld      a,c
B354: B7                                or      a
B355: CA 83 B3                          jp      z,LB383
B358: 1A                                ld      a,(de)
B359: FE 3F                             cp      3Fh     ; '?'
B35B: CA 7C B3                          jp      z,LB37C
B35E: 78                                ld      a,b
B35F: FE 0D                             cp      0Dh
B361: CA 7C B3                          jp      z,LB37C
B364: FE 0C                             cp      0Ch
B366: 1A                                ld      a,(de)
B367: CA 73 B3                          jp      z,LB373
B36A: 96                                sub     (hl)
B36B: E6 7F                             and     7Fh     ; ''
B36D: C2 2D B3                          jp      nz,LB32D
B370: C3 7C B3                          jp      LB37C

                                        ; Referenced from B367
B373: C5                         LB373: push    bc
B374: 4E                                ld      c,(hl)
B375: CD 07 B3                          call    LB307
B378: C1                                pop     bc
B379: C2 2D B3                          jp      nz,LB32D

                                        ; Referenced from B35B, B361, B370
B37C: 13                         LB37C: inc     de
B37D: 23                                inc     hl
B37E: 04                                inc     b
B37F: 0D                                dec     c
B380: C3 53 B3                          jp      LB353

                                        ; Referenced from B355
B383: 3A EA B9                   LB383: ld      a,(LB9EA)
B386: E6 03                             and     03h
B388: 32 45 AF                          ld      (LAF45),a
B38B: 21 D4 B9                          ld      hl,0B9D4h
B38E: 7E                                ld      a,(hl)
B38F: 17                                rla
B390: D0                                ret     nc
B391: AF                                xor     a
B392: 77                                ld      (hl),a
B393: C9                                ret

                                        ; Referenced from B335, B347
B394: CD FE B1                   LB394: call    LB1FE
B397: 3E FF                             ld      a,0FFh
B399: C3 01 AF                          jp      LAF01

                                        ; Referenced from B8DA
                                        ; --- START PROC LB39C ---
B39C: CD 54 B1                   LB39C: call    LB154
B39F: 0E 0C                             ld      c,0Ch
B3A1: CD 18 B3                          call    LB318

                                        ; Referenced from B3BB
B3A4: CD F5 B1                   LB3A4: call    LB1F5
B3A7: C8                                ret     z
B3A8: CD 44 B1                          call    LB144
B3AB: CD 5E B1                          call    LB15E
B3AE: 36 E5                             ld      (hl),0E5h
B3B0: 0E 00                             ld      c,00h
B3B2: CD 6B B2                          call    LB26B
B3B5: CD C6 B1                          call    LB1C6
B3B8: CD 2D B3                          call    LB32D
B3BB: C3 A4 B3                          jp      LB3A4

                                        ; Referenced from B63B
                                        ; --- START PROC LB3BE ---
B3BE: 50                         LB3BE: ld      d,b
B3BF: 59                                ld      e,c

                                        ; Referenced from B3E9, B3F6
B3C0: 79                         LB3C0: ld      a,c
B3C1: B0                                or      b
B3C2: CA D1 B3                          jp      z,LB3D1
B3C5: 0B                                dec     bc
B3C6: D5                                push    de
B3C7: C5                                push    bc
B3C8: CD 35 B2                          call    LB235
B3CB: 1F                                rra
B3CC: D2 EC B3                          jp      nc,LB3EC
B3CF: C1                                pop     bc
B3D0: D1                                pop     de

                                        ; Referenced from B3C2
B3D1: 2A C6 B9                   LB3D1: ld      hl,(LB9C6)
B3D4: 7B                                ld      a,e
B3D5: 95                                sub     l
B3D6: 7A                                ld      a,d
B3D7: 9C                                sbc     a,h
B3D8: D2 F4 B3                          jp      nc,LB3F4
B3DB: 13                                inc     de
B3DC: C5                                push    bc
B3DD: D5                                push    de
B3DE: 42                                ld      b,d
B3DF: 4B                                ld      c,e
B3E0: CD 35 B2                          call    LB235
B3E3: 1F                                rra
B3E4: D2 EC B3                          jp      nc,LB3EC
B3E7: D1                                pop     de
B3E8: C1                                pop     bc
B3E9: C3 C0 B3                          jp      LB3C0

                                        ; Referenced from B3CC, B3E4
B3EC: 17                         LB3EC: rla
B3ED: 3C                                inc     a
B3EE: CD 64 B2                          call    LB264
B3F1: E1                                pop     hl
B3F2: D1                                pop     de
B3F3: C9                                ret

                                        ; Referenced from B3D8
B3F4: 79                         LB3F4: ld      a,c
B3F5: B0                                or      b
B3F6: C2 C0 B3                          jp      nz,LB3C0
B3F9: 21 00 00                          ld      hl,0000h
B3FC: C9                                ret

                                        ; Referenced from B554
                                        ; --- START PROC LB3FD ---
B3FD: 0E 00                      LB3FD: ld      c,00h
B3FF: 1E 20                             ld      e,20h   ; ' '

                                        ; Referenced from B432, B448
                                        ; --- START PROC LB401 ---
B401: D5                         LB401: push    de
B402: 06 00                             ld      b,00h
B404: 2A 43 AF                          ld      hl,(LAF43)
B407: 09                                add     hl,bc
B408: EB                                ex      de,hl
B409: CD 5E B1                          call    LB15E
B40C: C1                                pop     bc
B40D: CD 4F AF                          call    LAF4F

                                        ; Referenced from B51C
                                        ; --- START PROC LB410 ---
B410: CD C3 AF                   LB410: call    LAFC3
B413: C3 C6 B1                          jp      LB1C6

                                        ; Referenced from B8F8
                                        ; --- START PROC LB416 ---
B416: CD 54 B1                   LB416: call    LB154
B419: 0E 0C                             ld      c,0Ch
B41B: CD 18 B3                          call    LB318
B41E: 2A 43 AF                          ld      hl,(LAF43)
B421: 7E                                ld      a,(hl)
B422: 11 10 00                          ld      de,0010h
B425: 19                                add     hl,de
B426: 77                                ld      (hl),a

                                        ; Referenced from B438
B427: CD F5 B1                   LB427: call    LB1F5
B42A: C8                                ret     z
B42B: CD 44 B1                          call    LB144
B42E: 0E 10                             ld      c,10h
B430: 1E 0C                             ld      e,0Ch
B432: CD 01 B4                          call    LB401
B435: CD 2D B3                          call    LB32D
B438: C3 27 B4                          jp      LB427

                                        ; Referenced from B920
                                        ; --- START PROC LB43B ---
B43B: 0E 0C                      LB43B: ld      c,0Ch
B43D: CD 18 B3                          call    LB318

                                        ; Referenced from B44E
B440: CD F5 B1                   LB440: call    LB1F5
B443: C8                                ret     z
B444: 0E 00                             ld      c,00h
B446: 1E 0C                             ld      e,0Ch
B448: CD 01 B4                          call    LB401
B44B: CD 2D B3                          call    LB32D
B44E: C3 40 B4                          jp      LB440

                                        ; Referenced from B761, B8A2
                                        ; --- START PROC LB451 ---
B451: 0E 0F                      LB451: ld      c,0Fh
B453: CD 18 B3                          call    LB318
B456: CD F5 B1                          call    LB1F5
B459: C8                                ret     z

                                        ; Referenced from B5AC
                                        ; --- START PROC LB45A ---
B45A: CD A6 B0                   LB45A: call    LB0A6
B45D: 7E                                ld      a,(hl)
B45E: F5                                push    af
B45F: E5                                push    hl
B460: CD 5E B1                          call    LB15E
B463: EB                                ex      de,hl
B464: 2A 43 AF                          ld      hl,(LAF43)
B467: 0E 20                             ld      c,20h   ; ' '
B469: D5                                push    de
B46A: CD 4F AF                          call    LAF4F
B46D: CD 78 B1                          call    LB178
B470: D1                                pop     de
B471: 21 0C 00                          ld      hl,000Ch
B474: 19                                add     hl,de
B475: 4E                                ld      c,(hl)
B476: 21 0F 00                          ld      hl,000Fh
B479: 19                                add     hl,de
B47A: 46                                ld      b,(hl)
B47B: E1                                pop     hl
B47C: F1                                pop     af
B47D: 77                                ld      (hl),a
B47E: 79                                ld      a,c
B47F: BE                                cp      (hl)
B480: 78                                ld      a,b
B481: CA 8B B4                          jp      z,LB48B
B484: 3E 00                             ld      a,00h
B486: DA 8B B4                          jp      c,LB48B
B489: 3E 80                             ld      a,80h

                                        ; Referenced from B481, B486
B48B: 2A 43 AF                   LB48B: ld      hl,(LAF43)
B48E: 11 0F 00                          ld      de,000Fh
B491: 19                                add     hl,de
B492: 77                                ld      (hl),a
B493: C9                                ret

                                        ; Referenced from B4E8, B4EC
                                        ; --- START PROC LB494 ---
B494: 7E                         LB494: ld      a,(hl)
B495: 23                                inc     hl
B496: B6                                or      (hl)
B497: 2B                                dec     hl
B498: C0                                ret     nz
B499: 1A                                ld      a,(de)
B49A: 77                                ld      (hl),a
B49B: 13                                inc     de
B49C: 23                                inc     hl
B49D: 1A                                ld      a,(de)
B49E: 77                                ld      (hl),a
B49F: 1B                                dec     de
B4A0: 2B                                dec     hl
B4A1: C9                                ret

                                        ; Referenced from B55E, B749, B8A8
                                        ; --- START PROC LB4A2 ---
B4A2: AF                         LB4A2: xor     a
B4A3: 32 45 AF                          ld      (LAF45),a
B4A6: 32 EA B9                          ld      (LB9EA),a
B4A9: 32 EB B9                          ld      (LB9EB),a
B4AC: CD 1E B1                          call    LB11E
B4AF: C0                                ret     nz
B4B0: CD 69 B1                          call    LB169
B4B3: E6 80                             and     80h
B4B5: C0                                ret     nz
B4B6: 0E 0F                             ld      c,0Fh
B4B8: CD 18 B3                          call    LB318
B4BB: CD F5 B1                          call    LB1F5
B4BE: C8                                ret     z
B4BF: 01 10 00                          ld      bc,0010h
B4C2: CD 5E B1                          call    LB15E
B4C5: 09                                add     hl,bc
B4C6: EB                                ex      de,hl
B4C7: 2A 43 AF                          ld      hl,(LAF43)
B4CA: 09                                add     hl,bc
B4CB: 0E 10                             ld      c,10h

                                        ; Referenced from B500
B4CD: 3A DD B9                   LB4CD: ld      a,(LB9DD)
B4D0: B7                                or      a
B4D1: CA E8 B4                          jp      z,LB4E8
B4D4: 7E                                ld      a,(hl)
B4D5: B7                                or      a
B4D6: 1A                                ld      a,(de)
B4D7: C2 DB B4                          jp      nz,LB4DB
B4DA: 77                                ld      (hl),a

                                        ; Referenced from B4D7
B4DB: B7                         LB4DB: or      a
B4DC: C2 E1 B4                          jp      nz,LB4E1
B4DF: 7E                                ld      a,(hl)
B4E0: 12                                ld      (de),a

                                        ; Referenced from B4DC
B4E1: BE                         LB4E1: cp      (hl)
B4E2: C2 1F B5                          jp      nz,LB51F
B4E5: C3 FD B4                          jp      LB4FD

                                        ; Referenced from B4D1
B4E8: CD 94 B4                   LB4E8: call    LB494
B4EB: EB                                ex      de,hl
B4EC: CD 94 B4                          call    LB494
B4EF: EB                                ex      de,hl
B4F0: 1A                                ld      a,(de)
B4F1: BE                                cp      (hl)
B4F2: C2 1F B5                          jp      nz,LB51F
B4F5: 13                                inc     de
B4F6: 23                                inc     hl
B4F7: 1A                                ld      a,(de)
B4F8: BE                                cp      (hl)
B4F9: C2 1F B5                          jp      nz,LB51F
B4FC: 0D                                dec     c

                                        ; Referenced from B4E5
B4FD: 13                         LB4FD: inc     de
B4FE: 23                                inc     hl
B4FF: 0D                                dec     c
B500: C2 CD B4                          jp      nz,LB4CD
B503: 01 EC FF                          ld      bc,0FFECh
B506: 09                                add     hl,bc
B507: EB                                ex      de,hl
B508: 09                                add     hl,bc
B509: 1A                                ld      a,(de)
B50A: BE                                cp      (hl)
B50B: DA 17 B5                          jp      c,LB517
B50E: 77                                ld      (hl),a
B50F: 01 03 00                          ld      bc,0003h
B512: 09                                add     hl,bc
B513: EB                                ex      de,hl
B514: 09                                add     hl,bc
B515: 7E                                ld      a,(hl)
B516: 12                                ld      (de),a

                                        ; Referenced from B50B
B517: 3E FF                      LB517: ld      a,0FFh
B519: 32 D2 B9                          ld      (LB9D2),a
B51C: C3 10 B4                          jp      LB410

                                        ; Referenced from B4E2, B4F2, B4F9
B51F: 21 45 AF                   LB51F: ld      hl,0AF45h
B522: 35                                dec     (hl)
B523: C9                                ret

                                        ; Referenced from B5A0, B773, B8F2
                                        ; --- START PROC LB524 ---
B524: CD 54 B1                   LB524: call    LB154
B527: 2A 43 AF                          ld      hl,(LAF43)
B52A: E5                                push    hl
B52B: 21 AC B9                          ld      hl,0B9ACh
B52E: 22 43 AF                          ld      (LAF43),hl
B531: 0E 01                             ld      c,01h
B533: CD 18 B3                          call    LB318
B536: CD F5 B1                          call    LB1F5
B539: E1                                pop     hl
B53A: 22 43 AF                          ld      (LAF43),hl
B53D: C8                                ret     z
B53E: EB                                ex      de,hl
B53F: 21 0F 00                          ld      hl,000Fh
B542: 19                                add     hl,de
B543: 0E 11                             ld      c,11h
B545: AF                                xor     a

                                        ; Referenced from B549
B546: 77                         LB546: ld      (hl),a
B547: 23                                inc     hl
B548: 0D                                dec     c
B549: C2 46 B5                          jp      nz,LB546
B54C: 21 0D 00                          ld      hl,000Dh
B54F: 19                                add     hl,de
B550: 77                                ld      (hl),a
B551: CD 8C B1                          call    LB18C
B554: CD FD B3                          call    LB3FD
B557: C3 78 B1                          jp      LB178

                                        ; Referenced from B5D8, B6EF
                                        ; --- START PROC LB55A ---
B55A: AF                         LB55A: xor     a
B55B: 32 D2 B9                          ld      (LB9D2),a
B55E: CD A2 B4                          call    LB4A2
B561: CD F5 B1                          call    LB1F5
B564: C8                                ret     z
B565: 2A 43 AF                          ld      hl,(LAF43)
B568: 01 0C 00                          ld      bc,000Ch
B56B: 09                                add     hl,bc
B56C: 7E                                ld      a,(hl)
B56D: 3C                                inc     a
B56E: E6 1F                             and     1Fh
B570: 77                                ld      (hl),a
B571: CA 83 B5                          jp      z,LB583
B574: 47                                ld      b,a
B575: 3A C5 B9                          ld      a,(LB9C5)
B578: A0                                and     b
B579: 21 D2 B9                          ld      hl,0B9D2h
B57C: A6                                and     (hl)
B57D: CA 8E B5                          jp      z,LB58E
B580: C3 AC B5                          jp      LB5AC

                                        ; Referenced from B571
B583: 01 02 00                   LB583: ld      bc,0002h
B586: 09                                add     hl,bc
B587: 34                                inc     (hl)
B588: 7E                                ld      a,(hl)
B589: E6 0F                             and     0Fh
B58B: CA B6 B5                          jp      z,LB5B6

                                        ; Referenced from B57D
B58E: 0E 0F                      LB58E: ld      c,0Fh
B590: CD 18 B3                          call    LB318
B593: CD F5 B1                          call    LB1F5
B596: C2 AC B5                          jp      nz,LB5AC
B599: 3A D3 B9                          ld      a,(LB9D3)
B59C: 3C                                inc     a
B59D: CA B6 B5                          jp      z,LB5B6
B5A0: CD 24 B5                          call    LB524
B5A3: CD F5 B1                          call    LB1F5
B5A6: CA B6 B5                          jp      z,LB5B6
B5A9: C3 AF B5                          jp      LB5AF

                                        ; Referenced from B580, B596
B5AC: CD 5A B4                   LB5AC: call    LB45A

                                        ; Referenced from B5A9
B5AF: CD BB B0                   LB5AF: call    LB0BB
B5B2: AF                                xor     a
B5B3: C3 01 AF                          jp      LAF01

                                        ; Referenced from B58B, B59D, B5A6
B5B6: CD 05 AF                   LB5B6: call    LAF05
B5B9: C3 78 B1                          jp      LB178

                                        ; Referenced from B8E3
B5BC: 3E 01                      LB5BC: ld      a,01h
B5BE: 32 D5 B9                          ld      (LB9D5),a

                                        ; Referenced from B798
                                        ; --- START PROC LB5C1 ---
B5C1: 3E FF                      LB5C1: ld      a,0FFh
B5C3: 32 D3 B9                          ld      (LB9D3),a
B5C6: CD BB B0                          call    LB0BB
B5C9: 3A E3 B9                          ld      a,(LB9E3)
B5CC: 21 E1 B9                          ld      hl,0B9E1h
B5CF: BE                                cp      (hl)
B5D0: DA E6 B5                          jp      c,LB5E6
B5D3: FE 80                             cp      80h
B5D5: C2 FB B5                          jp      nz,LB5FB
B5D8: CD 5A B5                          call    LB55A
B5DB: AF                                xor     a
B5DC: 32 E3 B9                          ld      (LB9E3),a
B5DF: 3A 45 AF                          ld      a,(LAF45)
B5E2: B7                                or      a
B5E3: C2 FB B5                          jp      nz,LB5FB

                                        ; Referenced from B5D0
B5E6: CD 77 B0                   LB5E6: call    LB077
B5E9: CD 84 B0                          call    LB084
B5EC: CA FB B5                          jp      z,LB5FB
B5EF: CD 8A B0                          call    LB08A
B5F2: CD D1 AF                          call    LAFD1
B5F5: CD B2 AF                          call    LAFB2
B5F8: C3 D2 B0                          jp      LB0D2

                                        ; Referenced from B5D5, B5E3, B5EC
                                        ; --- START PROC LB5FB ---
B5FB: C3 05 AF                   LB5FB: jp      LAF05

                                        ; Referenced from B8E9
B5FE: 3E 01                      LB5FE: ld      a,01h
B600: 32 D5 B9                          ld      (LB9D5),a

                                        ; Referenced from B7A1, B9A8
                                        ; --- START PROC LB603 ---
B603: 3E 00                      LB603: ld      a,00h
B605: 32 D3 B9                          ld      (LB9D3),a
B608: CD 54 B1                          call    LB154
B60B: 2A 43 AF                          ld      hl,(LAF43)
B60E: CD 47 B1                          call    LB147
B611: CD BB B0                          call    LB0BB
B614: 3A E3 B9                          ld      a,(LB9E3)
B617: FE 80                             cp      80h
B619: D2 05 AF                          jp      nc,LAF05
B61C: CD 77 B0                          call    LB077
B61F: CD 84 B0                          call    LB084
B622: 0E 00                             ld      c,00h
B624: C2 6E B6                          jp      nz,LB66E
B627: CD 3E B0                          call    LB03E
B62A: 32 D7 B9                          ld      (LB9D7),a
B62D: 01 00 00                          ld      bc,0000h
B630: B7                                or      a
B631: CA 3B B6                          jp      z,LB63B
B634: 4F                                ld      c,a
B635: 0B                                dec     bc
B636: CD 5E B0                          call    LB05E
B639: 44                                ld      b,h
B63A: 4D                                ld      c,l

                                        ; Referenced from B631
B63B: CD BE B3                   LB63B: call    LB3BE
B63E: 7D                                ld      a,l
B63F: B4                                or      h
B640: C2 48 B6                          jp      nz,LB648
B643: 3E 02                             ld      a,02h
B645: C3 01 AF                          jp      LAF01

                                        ; Referenced from B640
B648: 22 E5 B9                   LB648: ld      (LB9E5),hl
B64B: EB                                ex      de,hl
B64C: 2A 43 AF                          ld      hl,(LAF43)
B64F: 01 10 00                          ld      bc,0010h
B652: 09                                add     hl,bc
B653: 3A DD B9                          ld      a,(LB9DD)
B656: B7                                or      a
B657: 3A D7 B9                          ld      a,(LB9D7)
B65A: CA 64 B6                          jp      z,LB664
B65D: CD 64 B1                          call    LB164
B660: 73                                ld      (hl),e
B661: C3 6C B6                          jp      LB66C

                                        ; Referenced from B65A
B664: 4F                         LB664: ld      c,a
B665: 06 00                             ld      b,00h
B667: 09                                add     hl,bc
B668: 09                                add     hl,bc
B669: 73                                ld      (hl),e
B66A: 23                                inc     hl
B66B: 72                                ld      (hl),d

                                        ; Referenced from B661
B66C: 0E 02                      LB66C: ld      c,02h

                                        ; Referenced from B624
B66E: 3A 45 AF                   LB66E: ld      a,(LAF45)
B671: B7                                or      a
B672: C0                                ret     nz
B673: C5                                push    bc
B674: CD 8A B0                          call    LB08A
B677: 3A D5 B9                          ld      a,(LB9D5)
B67A: 3D                                dec     a
B67B: 3D                                dec     a
B67C: C2 BB B6                          jp      nz,LB6BB
B67F: C1                                pop     bc
B680: C5                                push    bc
B681: 79                                ld      a,c
B682: 3D                                dec     a
B683: 3D                                dec     a
B684: C2 BB B6                          jp      nz,LB6BB
B687: E5                                push    hl
B688: 2A B9 B9                          ld      hl,(LB9B9)
B68B: 57                                ld      d,a

                                        ; Referenced from B68F
B68C: 77                         LB68C: ld      (hl),a
B68D: 23                                inc     hl
B68E: 14                                inc     d
B68F: F2 8C B6                          jp      p,LB68C
B692: CD E0 B1                          call    LB1E0
B695: 2A E7 B9                          ld      hl,(LB9E7)
B698: 0E 02                             ld      c,02h

                                        ; Referenced from B6B1
B69A: 22 E5 B9                   LB69A: ld      (LB9E5),hl
B69D: C5                                push    bc
B69E: CD D1 AF                          call    LAFD1
B6A1: C1                                pop     bc
B6A2: CD B8 AF                          call    LAFB8
B6A5: 2A E5 B9                          ld      hl,(LB9E5)
B6A8: 0E 00                             ld      c,00h
B6AA: 3A C4 B9                          ld      a,(LB9C4)
B6AD: 47                                ld      b,a
B6AE: A5                                and     l
B6AF: B8                                cp      b
B6B0: 23                                inc     hl
B6B1: C2 9A B6                          jp      nz,LB69A
B6B4: E1                                pop     hl
B6B5: 22 E5 B9                          ld      (LB9E5),hl
B6B8: CD DA B1                          call    LB1DA

                                        ; Referenced from B67C, B684
B6BB: CD D1 AF                   LB6BB: call    LAFD1
B6BE: C1                                pop     bc
B6BF: C5                                push    bc
B6C0: CD B8 AF                          call    LAFB8
B6C3: C1                                pop     bc
B6C4: 3A E3 B9                          ld      a,(LB9E3)
B6C7: 21 E1 B9                          ld      hl,0B9E1h
B6CA: BE                                cp      (hl)
B6CB: DA D2 B6                          jp      c,LB6D2
B6CE: 77                                ld      (hl),a
B6CF: 34                                inc     (hl)
B6D0: 0E 02                             ld      c,02h

                                        ; Referenced from B6CB
B6D2: 00                         LB6D2: nop
B6D3: 00                                nop
B6D4: 21 00 A4                          ld      hl,0A400h
B6D7: F5                                push    af
B6D8: CD 69 B1                          call    LB169
B6DB: E6 7F                             and     7Fh     ; ''
B6DD: 77                                ld      (hl),a
B6DE: F1                                pop     af
B6DF: FE 7F                             cp      7Fh     ; ''
B6E1: C2 00 B7                          jp      nz,LB700
B6E4: 3A D5 B9                          ld      a,(LB9D5)
B6E7: FE 01                             cp      01h
B6E9: C2 00 B7                          jp      nz,LB700
B6EC: CD D2 B0                          call    LB0D2
B6EF: CD 5A B5                          call    LB55A
B6F2: 21 45 AF                          ld      hl,0AF45h
B6F5: 7E                                ld      a,(hl)
B6F6: B7                                or      a
B6F7: C2 FE B6                          jp      nz,LB6FE
B6FA: 3D                                dec     a
B6FB: 32 E3 B9                          ld      (LB9E3),a

                                        ; Referenced from B6F7
B6FE: 36 00                      LB6FE: ld      (hl),00h

                                        ; Referenced from B6E1, B6E9
                                        ; --- START PROC LB700 ---
B700: C3 D2 B0                   LB700: jp      LB0D2

                                        ; Referenced from B795, B79E
                                        ; --- START PROC LB703 ---
B703: AF                         LB703: xor     a
B704: 32 D5 B9                          ld      (LB9D5),a

                                        ; Referenced from B9A5
                                        ; --- START PROC LB707 ---
B707: C5                         LB707: push    bc
B708: 2A 43 AF                          ld      hl,(LAF43)
B70B: EB                                ex      de,hl
B70C: 21 21 00                          ld      hl,0021h
B70F: 19                                add     hl,de
B710: 7E                                ld      a,(hl)
B711: E6 7F                             and     7Fh     ; ''
B713: F5                                push    af
B714: 7E                                ld      a,(hl)
B715: 17                                rla
B716: 23                                inc     hl
B717: 7E                                ld      a,(hl)
B718: 17                                rla
B719: E6 1F                             and     1Fh
B71B: 4F                                ld      c,a
B71C: 7E                                ld      a,(hl)
B71D: 1F                                rra
B71E: 1F                                rra
B71F: 1F                                rra
B720: 1F                                rra
B721: E6 0F                             and     0Fh
B723: 47                                ld      b,a
B724: F1                                pop     af
B725: 23                                inc     hl
B726: 6E                                ld      l,(hl)
B727: 2C                                inc     l
B728: 2D                                dec     l
B729: 2E 06                             ld      l,06h
B72B: C2 8B B7                          jp      nz,LB78B
B72E: 21 20 00                          ld      hl,0020h
B731: 19                                add     hl,de
B732: 77                                ld      (hl),a
B733: 21 0C 00                          ld      hl,000Ch
B736: 19                                add     hl,de
B737: 79                                ld      a,c
B738: 96                                sub     (hl)
B739: C2 47 B7                          jp      nz,LB747
B73C: 21 0E 00                          ld      hl,000Eh
B73F: 19                                add     hl,de
B740: 78                                ld      a,b
B741: 96                                sub     (hl)
B742: E6 7F                             and     7Fh     ; ''
B744: CA 7F B7                          jp      z,LB77F

                                        ; Referenced from B739
B747: C5                         LB747: push    bc
B748: D5                                push    de
B749: CD A2 B4                          call    LB4A2
B74C: D1                                pop     de
B74D: C1                                pop     bc
B74E: 2E 03                             ld      l,03h
B750: 3A 45 AF                          ld      a,(LAF45)
B753: 3C                                inc     a
B754: CA 84 B7                          jp      z,LB784
B757: 21 0C 00                          ld      hl,000Ch
B75A: 19                                add     hl,de
B75B: 71                                ld      (hl),c
B75C: 21 0E 00                          ld      hl,000Eh
B75F: 19                                add     hl,de
B760: 70                                ld      (hl),b
B761: CD 51 B4                          call    LB451
B764: 3A 45 AF                          ld      a,(LAF45)
B767: 3C                                inc     a
B768: C2 7F B7                          jp      nz,LB77F
B76B: C1                                pop     bc
B76C: C5                                push    bc
B76D: 2E 04                             ld      l,04h
B76F: 0C                                inc     c
B770: CA 84 B7                          jp      z,LB784
B773: CD 24 B5                          call    LB524
B776: 2E 05                             ld      l,05h
B778: 3A 45 AF                          ld      a,(LAF45)
B77B: 3C                                inc     a
B77C: CA 84 B7                          jp      z,LB784

                                        ; Referenced from B744, B768
B77F: C1                         LB77F: pop     bc
B780: AF                                xor     a
B781: C3 01 AF                          jp      LAF01

                                        ; Referenced from B754, B770, B77C
B784: E5                         LB784: push    hl
B785: CD 69 B1                          call    LB169
B788: 36 C0                             ld      (hl),0C0h
B78A: E1                                pop     hl

                                        ; Referenced from B72B
B78B: C1                         LB78B: pop     bc
B78C: 7D                                ld      a,l
B78D: 32 45 AF                          ld      (LAF45),a
B790: C3 78 B1                          jp      LB178

                                        ; Referenced from B944
B793: 0E FF                      LB793: ld      c,0FFh
B795: CD 03 B7                          call    LB703
B798: CC C1 B5                          call    z,LB5C1
B79B: C9                                ret

                                        ; Referenced from B94A
B79C: 0E 00                      LB79C: ld      c,00h
B79E: CD 03 B7                          call    LB703
B7A1: CC 03 B6                          call    z,LB603
B7A4: C9                                ret

                                        ; Referenced from B7F0, B814
                                        ; --- START PROC LB7A5 ---
B7A5: EB                         LB7A5: ex      de,hl
B7A6: 19                                add     hl,de
B7A7: 4E                                ld      c,(hl)
B7A8: 06 00                             ld      b,00h
B7AA: 21 0C 00                          ld      hl,000Ch
B7AD: 19                                add     hl,de
B7AE: 7E                                ld      a,(hl)
B7AF: 0F                                rrca
B7B0: E6 80                             and     80h
B7B2: 81                                add     a,c
B7B3: 4F                                ld      c,a
B7B4: 3E 00                             ld      a,00h
B7B6: 88                                adc     a,b
B7B7: 47                                ld      b,a
B7B8: 7E                                ld      a,(hl)
B7B9: 0F                                rrca
B7BA: E6 0F                             and     0Fh
B7BC: 80                                add     a,b
B7BD: 47                                ld      b,a
B7BE: 21 0E 00                          ld      hl,000Eh
B7C1: 19                                add     hl,de
B7C2: 7E                                ld      a,(hl)
B7C3: 87                                add     a,a
B7C4: 87                                add     a,a
B7C5: 87                                add     a,a
B7C6: 87                                add     a,a
B7C7: F5                                push    af
B7C8: 80                                add     a,b
B7C9: 47                                ld      b,a
B7CA: F5                                push    af
B7CB: E1                                pop     hl
B7CC: 7D                                ld      a,l
B7CD: E1                                pop     hl
B7CE: B5                                or      l
B7CF: E6 01                             and     01h
B7D1: C9                                ret

                                        ; Referenced from B950
B7D2: 0E 0C                      LB7D2: ld      c,0Ch
B7D4: CD 18 B3                          call    LB318
B7D7: 2A 43 AF                          ld      hl,(LAF43)
B7DA: 11 21 00                          ld      de,0021h
B7DD: 19                                add     hl,de
B7DE: E5                                push    hl
B7DF: 72                                ld      (hl),d
B7E0: 23                                inc     hl
B7E1: 72                                ld      (hl),d
B7E2: 23                                inc     hl
B7E3: 72                                ld      (hl),d

                                        ; Referenced from B809
B7E4: CD F5 B1                   LB7E4: call    LB1F5
B7E7: CA 0C B8                          jp      z,LB80C
B7EA: CD 5E B1                          call    LB15E
B7ED: 11 0F 00                          ld      de,000Fh
B7F0: CD A5 B7                          call    LB7A5
B7F3: E1                                pop     hl
B7F4: E5                                push    hl
B7F5: 5F                                ld      e,a
B7F6: 79                                ld      a,c
B7F7: 96                                sub     (hl)
B7F8: 23                                inc     hl
B7F9: 78                                ld      a,b
B7FA: 9E                                sbc     a,(hl)
B7FB: 23                                inc     hl
B7FC: 7B                                ld      a,e
B7FD: 9E                                sbc     a,(hl)
B7FE: DA 06 B8                          jp      c,LB806
B801: 73                                ld      (hl),e
B802: 2B                                dec     hl
B803: 70                                ld      (hl),b
B804: 2B                                dec     hl
B805: 71                                ld      (hl),c

                                        ; Referenced from B7FE
B806: CD 2D B3                   LB806: call    LB32D
B809: C3 E4 B7                          jp      LB7E4

                                        ; Referenced from B7E7
B80C: E1                         LB80C: pop     hl
B80D: C9                                ret

B80E: 2A 43 AF                   LB80E: ld      hl,(LAF43)
B811: 11 20 00                          ld      de,0020h
B814: CD A5 B7                          call    LB7A5
B817: 21 21 00                          ld      hl,0021h
B81A: 19                                add     hl,de
B81B: 71                                ld      (hl),c
B81C: 23                                inc     hl
B81D: 70                                ld      (hl),b
B81E: 23                                inc     hl
B81F: 77                                ld      (hl),a
B820: C9                                ret

                                        ; Referenced from B84E, B899
                                        ; --- START PROC LB821 ---
B821: 2A AF B9                   LB821: ld      hl,(LB9AF)
B824: 3A 42 AF                          ld      a,(LAF42)
B827: 4F                                ld      c,a
B828: CD EA B0                          call    LB0EA
B82B: E5                                push    hl
B82C: EB                                ex      de,hl
B82D: CD 59 AF                          call    LAF59
B830: E1                                pop     hl
B831: CC 47 AF                          call    z,LAF47
B834: 7D                                ld      a,l
B835: 1F                                rra
B836: D8                                ret     c
B837: 2A AF B9                          ld      hl,(LB9AF)
B83A: 4D                                ld      c,l
B83B: 44                                ld      b,h
B83C: CD 0B B1                          call    LB10B
B83F: 22 AF B9                          ld      (LB9AF),hl
B842: C3 A3 B2                          jp      LB2A3

                                        ; Referenced from B872, B98E
                                        ; --- START PROC LB845 ---
B845: 3A D6 B9                   LB845: ld      a,(LB9D6)
B848: 21 42 AF                          ld      hl,0AF42h
B84B: BE                                cp      (hl)
B84C: C8                                ret     z
B84D: 77                                ld      (hl),a
B84E: C3 21 B8                          jp      LB821

                                        ; Referenced from B89F, B8A5, B8BD, B8CE, B8D7, B8E0, B8E6, B8EF, B8F5, B91D, B941, B947, B94D, B99B
                                        ; --- START PROC LB851 ---
B851: 3E FF                      LB851: ld      a,0FFh
B853: 32 DE B9                          ld      (LB9DE),a
B856: 2A 43 AF                          ld      hl,(LAF43)
B859: 7E                                ld      a,(hl)
B85A: E6 1F                             and     1Fh
B85C: 3D                                dec     a
B85D: 32 D6 B9                          ld      (LB9D6),a
B860: FE 1E                             cp      1Eh
B862: D2 75 B8                          jp      nc,LB875
B865: 3A 42 AF                          ld      a,(LAF42)
B868: 32 DF B9                          ld      (LB9DF),a
B86B: 7E                                ld      a,(hl)
B86C: 32 E0 B9                          ld      (LB9E0),a
B86F: E6 E0                             and     0E0h
B871: 77                                ld      (hl),a
B872: CD 45 B8                          call    LB845

                                        ; Referenced from B862
B875: 3A 41 AF                   LB875: ld      a,(LAF41)
B878: 2A 43 AF                          ld      hl,(LAF43)
B87B: B6                                or      (hl)
B87C: 77                                ld      (hl),a
B87D: C9                                ret

B87E: 3E 22                      LB87E: ld      a,22h   ; '"'
B880: C3 01 AF                          jp      LAF01

B883: 21 00 00                   LB883: ld      hl,0000h
B886: 22 AD B9                          ld      (LB9AD),hl
B889: 22 AF B9                          ld      (LB9AF),hl
B88C: AF                                xor     a
B88D: 32 42 AF                          ld      (LAF42),a
B890: 21 80 00                          ld      hl,0080h
B893: 22 B1 B9                          ld      (LB9B1),hl
B896: CD DA B1                          call    LB1DA
B899: C3 21 B8                          jp      LB821

B89C: CD 72 B1                   LB89C: call    LB172
B89F: CD 51 B8                          call    LB851
B8A2: C3 51 B4                          jp      LB451

B8A5: CD 51 B8                   LB8A5: call    LB851
B8A8: C3 A2 B4                          jp      LB4A2

B8AB: 0E 00                      LB8AB: ld      c,00h
B8AD: EB                                ex      de,hl
B8AE: 7E                                ld      a,(hl)
B8AF: FE 3F                             cp      3Fh     ; '?'
B8B1: CA C2 B8                          jp      z,LB8C2
B8B4: CD A6 B0                          call    LB0A6
B8B7: 7E                                ld      a,(hl)
B8B8: FE 3F                             cp      3Fh     ; '?'
B8BA: C4 72 B1                          call    nz,LB172
B8BD: CD 51 B8                          call    LB851
B8C0: 0E 0F                             ld      c,0Fh

                                        ; Referenced from B8B1
B8C2: CD 18 B3                   LB8C2: call    LB318
B8C5: C3 E9 B1                          jp      LB1E9

B8C8: 2A D9 B9                   LB8C8: ld      hl,(LB9D9)
B8CB: 22 43 AF                          ld      (LAF43),hl
B8CE: CD 51 B8                          call    LB851
B8D1: CD 2D B3                          call    LB32D
B8D4: C3 E9 B1                          jp      LB1E9

B8D7: CD 51 B8                   LB8D7: call    LB851
B8DA: CD 9C B3                          call    LB39C
B8DD: C3 01 B3                          jp      LB301

B8E0: CD 51 B8                   LB8E0: call    LB851
B8E3: C3 BC B5                          jp      LB5BC

B8E6: CD 51 B8                   LB8E6: call    LB851
B8E9: C3 FE B5                          jp      LB5FE

B8EC: CD 72 B1                   LB8EC: call    LB172
B8EF: CD 51 B8                          call    LB851
B8F2: C3 24 B5                          jp      LB524

B8F5: CD 51 B8                   LB8F5: call    LB851
B8F8: CD 16 B4                          call    LB416
B8FB: C3 01 B3                          jp      LB301

B8FE: 2A AF B9                   LB8FE: ld      hl,(LB9AF)
B901: C3 29 B9                          jp      LB929

B904: 3A 42 AF                   LB904: ld      a,(LAF42)
B907: C3 01 AF                          jp      LAF01

B90A: EB                         LB90A: ex      de,hl
B90B: 22 B1 B9                          ld      (LB9B1),hl
B90E: C3 DA B1                          jp      LB1DA

B911: 2A BF B9                   LB911: ld      hl,(LB9BF)
B914: C3 29 B9                          jp      LB929

B917: 2A AD B9                   LB917: ld      hl,(LB9AD)
B91A: C3 29 B9                          jp      LB929

B91D: CD 51 B8                   LB91D: call    LB851
B920: CD 3B B4                          call    LB43B
B923: C3 01 B3                          jp      LB301

B926: 2A BB B9                   LB926: ld      hl,(LB9BB)

                                        ; Referenced from B901, B914, B91A
B929: 22 45 AF                   LB929: ld      (LAF45),hl
B92C: C9                                ret

B92D: 3A D6 B9                   LB92D: ld      a,(LB9D6)
B930: FE FF                             cp      0FFh
B932: C2 3B B9                          jp      nz,LB93B
B935: 3A 41 AF                          ld      a,(LAF41)
B938: C3 01 AF                          jp      LAF01

                                        ; Referenced from B932
B93B: E6 1F                      LB93B: and     1Fh
B93D: 32 41 AF                          ld      (LAF41),a
B940: C9                                ret

B941: CD 51 B8                   LB941: call    LB851
B944: C3 93 B7                          jp      LB793

B947: CD 51 B8                   LB947: call    LB851
B94A: C3 9C B7                          jp      LB79C

B94D: CD 51 B8                   LB94D: call    LB851
B950: C3 D2 B7                          jp      LB7D2

B953: 2A 43 AF                   LB953: ld      hl,(LAF43)
B956: 7D                                ld      a,l
B957: 2F                                cpl
B958: 5F                                ld      e,a
B959: 7C                                ld      a,h
B95A: 2F                                cpl
B95B: 2A AF B9                          ld      hl,(LB9AF)
B95E: A4                                and     h
B95F: 57                                ld      d,a
B960: 7D                                ld      a,l
B961: A3                                and     e
B962: 5F                                ld      e,a
B963: 2A AD B9                          ld      hl,(LB9AD)
B966: EB                                ex      de,hl
B967: 22 AF B9                          ld      (LB9AF),hl
B96A: 7D                                ld      a,l
B96B: A3                                and     e
B96C: 6F                                ld      l,a
B96D: 7C                                ld      a,h
B96E: A2                                and     d
B96F: 67                                ld      h,a
B970: 22 AD B9                          ld      (LB9AD),hl
B973: C9                                ret

B974: 3A DE B9                   LB974: ld      a,(LB9DE)
B977: B7                                or      a
B978: CA 91 B9                          jp      z,LB991
B97B: 2A 43 AF                          ld      hl,(LAF43)
B97E: 36 00                             ld      (hl),00h
B980: 3A E0 B9                          ld      a,(LB9E0)
B983: B7                                or      a
B984: CA 91 B9                          jp      z,LB991
B987: 77                                ld      (hl),a
B988: 3A DF B9                          ld      a,(LB9DF)
B98B: 32 D6 B9                          ld      (LB9D6),a
B98E: CD 45 B8                          call    LB845

                                        ; Referenced from AEE4, B978, B984
B991: 2A 0F AF                   LB991: ld      hl,(LAF0F)
B994: F9                                ld      sp,hl
B995: 2A 45 AF                          ld      hl,(LAF45)
B998: 7D                                ld      a,l
B999: 44                                ld      b,h
B99A: C9                                ret

B99B: CD 51 B8                   LB99B: call    LB851
B99E: 3E 02                             ld      a,02h
B9A0: 32 D5 B9                          ld      (LB9D5),a
B9A3: 0E 00                             ld      c,00h
B9A5: CD 07 B7                          call    LB707
B9A8: CC 03 B6                          call    z,LB603
B9AB: C9                                ret

B9AC: E5                         LB9AC: push    hl

                                        ; Referenced from B11E, B135, B886, B917, B963, B970
B9AD: 00                         LB9AD: nop
B9AE: 00                                nop

                                        ; Referenced from B821, B837, B83F, B889, B8FE, B95B, B967
B9AF: 00                         LB9AF: nop
B9B0: 00                                nop

                                        ; Referenced from B1ED, B893, B90B
B9B1: 80                         LB9B1: add     a,b
B9B2: 00                                nop

                                        ; Referenced from AF67, B13D, B183, B2C7
B9B3: 00                         LB9B3: nop
B9B4: 00                                nop

                                        ; Referenced from AF6C, AFA5, AFDD, B01E
B9B5: 00                         LB9B5: nop
B9B6: 00                                nop

                                        ; Referenced from AF71, AFAB, AFD7, B025
B9B7: 00                         LB9B7: nop
B9B8: 00                                nop

                                        ; Referenced from B0F9, B15E, B1E9, B688
B9B9: 00                         LB9B9: nop
B9BA: 00                                nop

                                        ; Referenced from AF82, B926
B9BB: 00                         LB9BB: nop
B9BC: 00                                nop

                                        ; Referenced from B1AD
B9BD: 00                         LB9BD: nop
B9BE: 00                                nop

                                        ; Referenced from B251, B2AE, B2BE, B911
B9BF: 00                         LB9BF: nop
B9C0: 00                                nop

                                        ; Referenced from AFEC, AFFB
B9C1: 00                         LB9C1: nop
B9C2: 00                                nop

                                        ; Referenced from B08A
B9C3: 00                         LB9C3: nop

                                        ; Referenced from B098, B6AA
B9C4: 00                         LB9C4: nop

                                        ; Referenced from B0CA, B309, B575
B9C5: 00                         LB9C5: nop

                                        ; Referenced from AF8E, B293, B2A3, B3D1
B9C6: 00                         LB9C6: nop
B9C7: 00                                nop

                                        ; Referenced from B138, B205
B9C8: 00                         LB9C8: nop
B9C9: 00                                nop

                                        ; Referenced from B2BA
B9CA: 00                         LB9CA: nop
B9CB: 00                                nop

                                        ; Referenced from B1A2
B9CC: 00                         LB9CC: nop
B9CD: 00                                nop

                                        ; Referenced from B014
B9CE: 00                         LB9CE: nop
B9CF: 00                                nop

                                        ; Referenced from AF77, B032
B9D0: 00                         LB9D0: nop
B9D1: 00                                nop

                                        ; Referenced from B519, B55B
B9D2: 00                         LB9D2: nop

                                        ; Referenced from B599, B5C3, B605
B9D3: 00                         LB9D3: nop

                                        ; Referenced from B301, B31A
B9D4: 00                         LB9D4: nop

                                        ; Referenced from B0D5, B5BE, B600, B677, B6E4, B704, B9A0
B9D5: 00                         LB9D5: nop

                                        ; Referenced from AC17, B845, B85D, B92D, B98B
B9D6: 00                         LB9D6: nop

                                        ; Referenced from B62A, B657
B9D7: 00                         LB9D7: nop

                                        ; Referenced from B34D
B9D8: 00                         LB9D8: nop

                                        ; Referenced from B324, B338, B8C8
B9D9: 00                         LB9D9: nop
B9DA: 00                                nop
B9DB: 00                                nop
B9DC: 00                                nop

                                        ; Referenced from B066, B279, B4CD, B653
B9DD: 00                         LB9DD: nop

                                        ; Referenced from AC2B, B853, B974
B9DE: 00                         LB9DE: nop

                                        ; Referenced from B868, B988
B9DF: 00                         LB9DF: nop

                                        ; Referenced from AC28, B86C, B980
B9E0: 00                         LB9E0: nop

                                        ; Referenced from B0C4, B0E5
B9E1: 00                         LB9E1: nop

                                        ; Referenced from B050, B0CE
B9E2: 00                         LB9E2: nop

                                        ; Referenced from B042, B09C, B0BF, B0DF, B5C9, B5DC, B614, B6C4, B6FB
B9E3: 00                         LB9E3: nop
B9E4: 00                                nop

                                        ; Referenced from AFCB, B080, B084, B08D, B0A2, B648, B69A, B6A5, B6B5
B9E5: 00                         LB9E5: nop
B9E6: 00                                nop

                                        ; Referenced from B095, B695
B9E7: 00                         LB9E7: nop
B9E8: 00                                nop

                                        ; Referenced from B161, B225
B9E9: 00                         LB9E9: nop

                                        ; Referenced from AFC3, B17F, B201, B209, B20D, B219, B383, B4A6
B9EA: 00                         LB9EA: nop

                                        ; Referenced from B4A9
B9EB: 00                         LB9EB: nop

                                        ; Referenced from AFCE, B19E, B1B1
B9EC: 00                         LB9EC: nop
B9ED: 00                                nop
B9EE: 00                                nop
B9EF: 00                                nop
B9F0: 00                                nop
B9F1: 00                                nop
B9F2: 00                                nop
B9F3: 00                                nop
B9F4: 00                                nop
B9F5: 00                                nop
B9F6: 00                                nop
B9F7: 00                                nop
B9F8: 00                                nop
B9F9: 00                                nop
B9FA: 00                                nop
B9FB: 00                                nop
B9FC: 00                                nop
B9FD: 00                                nop
B9FE: 00                                nop
B9FF: 00                                nop
BA00: C3 12 BB                          jp      LBB12

BA03: C3 D1 BA                   LBA03: jp      LBAD1

                                        ; Referenced from AD2A, AEDA, AEE0
                                        ; --- START PROC LBA06 ---
BA06: C3 7B BB                   LBA06: jp      LBB7B

                                        ; Referenced from AD03, AD30, AD38, AEE7, BD69
                                        ; --- START PROC LBA09 ---
BA09: C3 59 BD                   LBA09: jp      LBD59

                                        ; Referenced from AD55, ADA9, ADAE, AEDD
                                        ; --- START PROC LBA0C ---
BA0C: C3 DE BB                   LBA0C: jp      LBBDE

                                        ; Referenced from AD5E
                                        ; --- START PROC LBA0F ---
BA0F: C3 03 BC                   LBA0F: jp      LBC03

BA12: C3 03 BC                   LBA12: jp      LBC03

                                        ; Referenced from AECE
                                        ; --- START PROC LBA15 ---
BA15: C3 C8 BB                   LBA15: jp      LBBC8

                                        ; Referenced from AFA1
                                        ; --- START PROC LBA18 ---
BA18: C3 1D BC                   LBA18: jp      LBC1D

                                        ; Referenced from AF5D
                                        ; --- START PROC LBA1B ---
BA1B: C3 26 BC                   LBA1B: jp      LBC26

                                        ; Referenced from B01A
                                        ; --- START PROC LBA1E ---
BA1E: C3 3F BC                   LBA1E: jp      LBC3F

                                        ; Referenced from B03B
                                        ; --- START PROC LBA21 ---
BA21: C3 44 BC                   LBA21: jp      LBC44

                                        ; Referenced from B1E6
                                        ; --- START PROC LBA24 ---
BA24: C3 4F BC                   LBA24: jp      LBC4F

                                        ; Referenced from AFB2
                                        ; --- START PROC LBA27 ---
BA27: C3 54 BC                   LBA27: jp      LBC54

                                        ; Referenced from AFB8
                                        ; --- START PROC LBA2A ---
BA2A: C3 63 BC                   LBA2A: jp      LBC63

BA2D: C3 A2 BB                   LBA2D: jp      LBBA2

                                        ; Referenced from B036
                                        ; --- START PROC LBA30 ---
BA30: C3 49 BC                   LBA30: jp      LBC49

BA33: C3 00 00                   LBA33: jp      0000h

BA36: C3 00 00                   LBA36: jp      0000h

BA39: C3 00 00                   LBA39: jp      0000h

BA3C: C3 00 00                   LBA3C: jp      0000h

BA3F: C3 00 00                   LBA3F: jp      0000h

BA42: C3 00 00                   LBA42: jp      0000h

BA45: C3 00 00                   LBA45: jp      0000h

BA48: C3 00 00                   LBA48: jp      0000h

BA4B: C3 00 00                   LBA4B: jp      0000h

                                        ; Referenced from BC18
                                        ; --- START PROC LBA4E ---
BA4E: C3 50 E6                   LBA4E: jp      0E650h

BA51: C3 44 BD                   LBA51: jp      LBD44

                                        ; Referenced from BC69, BC73
BA54: 05                         LBA54: dec     b
BA55: 31 01 00                          ld      sp,0001h
BA58: 02                                ld      (bc),a
BA59: 00                                nop
BA5A: 03                                inc     bc
BA5B: C1                                pop     bc
BA5C: 04                                inc     b
BA5D: 44                                ld      b,h
BA5E: 05                                dec     b
BA5F: 68                                ld      l,b
BA60: 00                                nop
BA61: 00                                nop
BA62: 00                                nop
BA63: 00                                nop
BA64: 00                                nop
BA65: 00                                nop
BA66: 00                                nop
BA67: 00                                nop
BA68: A8                                xor     b
BA69: BA                                cp      d
BA6A: 00                                nop
BA6B: 00                                nop
BA6C: 00                                nop
BA6D: 00                                nop
BA6E: 00                                nop
BA6F: 00                                nop
BA70: 25                                dec     h
BA71: BE                                cp      (hl)
BA72: C2 BA 21                          jp      nz,21BAh
BA75: BF                                cp      a
BA76: A5                                and     l
BA77: BE                                cp      (hl)
BA78: A8                                xor     b
BA79: BA                                cp      d
BA7A: 00                                nop
BA7B: 00                                nop
BA7C: 00                                nop
BA7D: 00                                nop
BA7E: 00                                nop
BA7F: 00                                nop
BA80: 25                                dec     h
BA81: BE                                cp      (hl)
BA82: C2 BA 31                          jp      nz,31BAh
BA85: BF                                cp      a
BA86: C4 BE A8                          call    nz,LA8BE
BA89: BA                                cp      d
BA8A: 00                                nop
BA8B: 00                                nop
BA8C: 00                                nop
BA8D: 00                                nop
BA8E: 00                                nop
BA8F: 00                                nop
BA90: 25                                dec     h
BA91: BE                                cp      (hl)
BA92: C2 BA 41                          jp      nz,41BAh
BA95: BF                                cp      a
BA96: E3                                ex      (sp),hl
BA97: BE                                cp      (hl)
BA98: A8                                xor     b
BA99: BA                                cp      d
BA9A: 00                                nop
BA9B: 00                                nop
BA9C: 00                                nop
BA9D: 00                                nop
BA9E: 00                                nop
BA9F: 00                                nop
BAA0: 25                                dec     h
BAA1: BE                                cp      (hl)
BAA2: C2 BA 51                          jp      nz,51BAh
BAA5: BF                                cp      a
BAA6: 02                                ld      (bc),a
BAA7: BF                                cp      a
BAA8: 01 07 0D                          ld      bc,0D07h
BAAB: 13                                inc     de
BAAC: 19                                add     hl,de
BAAD: 05                                dec     b
BAAE: 0B                                dec     bc
BAAF: 11 17 03                          ld      de,0317h
BAB2: 09                                add     hl,bc
BAB3: 0F                                rrca
BAB4: 15                                dec     d
BAB5: 02                                ld      (bc),a
BAB6: 08                                ex      af,af'
BAB7: 0E 14                             ld      c,14h
BAB9: 1A                                ld      a,(de)
BABA: 06 0C                             ld      b,0Ch
BABC: 12                                ld      (de),a
BABD: 18 04                             jr      LBAC2+1 ; reference not aligned to instruction

BABF: 0A                         LBABF: ld      a,(bc)
BAC0: 10 16                             djnz    LBAD6+2 ; reference not aligned to instruction

                                        ; Referenced from BABD
BAC2: 10 00                      LBAC2: djnz    LBAC4

                                        ; Referenced from BAC2
BAC4: 03                         LBAC4: inc     bc
BAC5: 07                                rlca
BAC6: 00                                nop
BAC7: 47                                ld      b,a
BAC8: 00                                nop
BAC9: 3F                                ccf
BACA: 00                                nop
BACB: C0                                ret     nz
BACC: 00                                nop
BACD: 10 00                             djnz    LBACF

                                        ; Referenced from BACD
BACF: 04                         LBACF: inc     b
BAD0: 00                                nop

                                        ; Referenced from BA03
BAD1: 31 80 00                   LBAD1: ld      sp,0080h
BAD4: 0E 00                             ld      c,00h

                                        ; Referenced from BAC0
BAD6: CD 09 E8                   LBAD6: call    0E809h
BAD9: CD 00 E8                          call    0E800h
BADC: 06 2C                             ld      b,2Ch   ; ','
BADE: 0E 00                             ld      c,00h
BAE0: 16 02                             ld      d,02h
BAE2: 21 00 A4                          ld      hl,0A400h

                                        ; Referenced from BB02, BB10
BAE5: C5                         LBAE5: push    bc
BAE6: D5                                push    de
BAE7: E5                                push    hl
BAE8: 4A                                ld      c,d
BAE9: CD 06 E8                          call    0E806h
BAEC: E1                                pop     hl
BAED: E5                                push    hl
BAEE: CD 0C E8                          call    0E80Ch
BAF1: CD 12 E8                          call    0E812h
BAF4: E1                                pop     hl
BAF5: 11 80 00                          ld      de,0080h
BAF8: 19                                add     hl,de
BAF9: D1                                pop     de
BAFA: C1                                pop     bc
BAFB: 05                                dec     b
BAFC: 28 1B                             jr      z,LBB19
BAFE: 14                                inc     d
BAFF: 7A                                ld      a,d
BB00: FE 11                             cp      11h
BB02: 38 E1                             jr      c,LBAE5
BB04: 16 01                             ld      d,01h
BB06: 0C                                inc     c
BB07: C5                                push    bc
BB08: D5                                push    de
BB09: E5                                push    hl
BB0A: CD 03 E8                          call    0E803h
BB0D: E1                                pop     hl
BB0E: D1                                pop     de
BB0F: C1                                pop     bc
BB10: 18 D3                             jr      LBAE5

                                        ; Referenced from BA00
BB12: AF                         LBB12: xor     a
BB13: 32 03 00                          ld      (0003h),a
BB16: 32 04 00                          ld      (0004h),a

                                        ; Referenced from BAFC
BB19: 21 50 BB                   LBB19: ld      hl,0BB50h
BB1C: CD FA E3                          call    0E3FAh
BB1F: C5                                push    bc
BB20: 06 0A                             ld      b,0Ah
BB22: 21 56 BA                          ld      hl,0BA56h

                                        ; Referenced from BB2A
BB25: 7E                         LBB25: ld      a,(hl)
BB26: D3 7A                             out     (7Ah),a ; 'z'
BB28: 23                                inc     hl
BB29: 05                                dec     b
BB2A: C2 25 BB                          jp      nz,LBB25
BB2D: C1                                pop     bc
BB2E: 3E C3                             ld      a,0C3h
BB30: 32 00 00                          ld      (0000h),a
BB33: 21 03 BA                          ld      hl,0BA03h
BB36: 22 01 00                          ld      (0001h),hl
BB39: 32 05 00                          ld      (0005h),a
BB3C: 21 06 AC                          ld      hl,0AC06h
BB3F: 22 06 00                          ld      (0006h),hl
BB42: 21 A5 BD                          ld      hl,0BDA5h
BB45: CD 0C E8                          call    0E80Ch
BB48: FB                                ei
BB49: 3A 04 00                          ld      a,(0004h)
BB4C: 4F                                ld      c,a
BB4D: C3 00 A4                          jp      LA400

BB50: 0D                         LBB50: dec     c
BB51: 0A                                ld      a,(bc)
BB52: 44                                ld      b,h
BB53: 4F                                ld      c,a
BB54: 53                                ld      d,e
BB55: 20 32                             jr      nz,LBB89
BB57: 2E 32                             ld      l,32h   ; '2'
BB59: 20 34                             jr      nz,LBB8F
BB5B: 38 6B                             jr      c,LBBC8
BB5D: 0D                                dec     c
BB5E: 0A                                ld      a,(bc)
BB5F: 72                                ld      (hl),d
BB60: 65                                ld      h,l
BB61: 76                                halt
BB62: 2E 20                             ld      l,20h   ; ' '
BB64: 64                                ld      h,h
BB65: 69                                ld      l,c
BB66: 63                                ld      h,e
BB67: 2F                                cpl
BB68: 38 31                             jr      c,LBB9A+1       ; reference not aligned to instruction
BB6A: 0D                                dec     c
BB6B: 0A                                ld      a,(bc)
BB6C: A0                                and     b

                                        ; Referenced from BBCF
                                        ; --- START PROC LBB6D ---
BB6D: C3 DC E3                   LBB6D: jp      0E3DCh

BB70: 3E 0D                      LBB70: ld      a,0Dh
BB72: CD 03 E4                          call    0E403h
BB75: 3E 0A                             ld      a,0Ah
BB77: CD 03 E4                          call    0E403h
BB7A: C9                                ret

                                        ; Referenced from BA06
                                        ; --- START PROC LBB7B ---
BB7B: 3A 03 00                   LBB7B: ld      a,(0003h)
BB7E: E6 03                             and     03h
BB80: FE 01                             cp      01h
BB82: 28 08                             jr      z,LBB8C
BB84: DB FF                             in      a,(0FFh)
BB86: 07                                rlca

                                        ; Referenced from BB94, BB97, BBC6
BB87: 3E FF                      LBB87: ld      a,0FFh

                                        ; Referenced from BB55
BB89: D0                         LBB89: ret     nc
BB8A: AF                                xor     a
BB8B: C9                                ret

                                        ; Referenced from BB82
BB8C: AF                         LBB8C: xor     a
BB8D: D3 7A                             out     (7Ah),a ; 'z'

                                        ; Referenced from BB59
BB8F: DB 7A                      LBB8F: in      a,(7Ah) ; 'z'
BB91: E6 01                             and     01h

                                        ; Referenced from BBA0
BB93: 37                         LBB93: scf
BB94: 28 F1                             jr      z,LBB87
BB96: 3F                                ccf
BB97: 18 EE                             jr      LBB87

                                        ; Referenced from BBAB
BB99: AF                         LBB99: xor     a

                                        ; Referenced from BB68
BB9A: D3 7A                      LBB9A: out     (7Ah),a ; 'z'
BB9C: DB 7A                             in      a,(7Ah) ; 'z'
BB9E: E6 04                             and     04h
BBA0: 18 F1                             jr      LBB93

                                        ; Referenced from BA2D
BBA2: 3A 03 00                   LBBA2: ld      a,(0003h)
BBA5: E6 C0                             and     0C0h
BBA7: 28 0B                             jr      z,LBBB4
BBA9: FE 40                             cp      40h     ; '@'
BBAB: 28 EC                             jr      z,LBB99
BBAD: FE 80                             cp      80h
BBAF: 28 03                             jr      z,LBBB4
BBB1: AF                                xor     a
BBB2: 18 11                             jr      LBBC5

                                        ; Referenced from BBA7, BBAF
BBB4: DB 5D                      LBBB4: in      a,(5Dh) ; ']'
BBB6: 07                                rlca
BBB7: 07                                rlca
BBB8: FD 2A 03 E0                       ld      iy,(0E003h)
BBBC: 47                                ld      b,a
BBBD: FD 7E 06                          ld      a,(iy+06h)
BBC0: EE 04                             xor     04h
BBC2: A0                                and     b
BBC3: E6 C0                             and     0C0h

                                        ; Referenced from BBB2
BBC5: 2F                         LBBC5: cpl
BBC6: 18 BF                             jr      LBB87

                                        ; Referenced from BA15, BB5B
                                        ; --- START PROC LBBC8 ---
BBC8: 3A 03 00                   LBBC8: ld      a,(0003h)
BBCB: E6 03                             and     03h
BBCD: FE 01                             cp      01h
BBCF: 20 9C                             jr      nz,LBB6D

                                        ; Referenced from BBD8
BBD1: AF                         LBBD1: xor     a
BBD2: D3 7A                             out     (7Ah),a ; 'z'
BBD4: DB 7A                             in      a,(7Ah) ; 'z'
BBD6: E6 01                             and     01h
BBD8: CA D1 BB                          jp      z,LBBD1
BBDB: DB 78                             in      a,(78h) ; 'x'
BBDD: C9                                ret

                                        ; Referenced from BA0C
                                        ; --- START PROC LBBDE ---
BBDE: CD 91 BC                   LBBDE: call    LBC91
BBE1: 3A 03 00                          ld      a,(0003h)
BBE4: E6 03                             and     03h
BBE6: FE 01                             cp      01h
BBE8: 28 0A                             jr      z,LBBF4
BBEA: FE 02                             cp      02h
BBEC: 28 29                             jr      z,LBC17

                                        ; Referenced from BC15
                                        ; --- START PROC LBBEE ---
BBEE: 79                         LBBEE: ld      a,c
BBEF: CD 03 E4                          call    0E403h
BBF2: 18 27                             jr      LBC1B

                                        ; Referenced from BBE8, BBFB, BC0F
                                        ; --- START PROC LBBF4 ---
BBF4: AF                         LBBF4: xor     a
BBF5: D3 7A                             out     (7Ah),a ; 'z'
BBF7: DB 7A                             in      a,(7Ah) ; 'z'
BBF9: E6 04                             and     04h
BBFB: CA F4 BB                          jp      z,LBBF4
BBFE: 79                                ld      a,c
BBFF: D3 78                             out     (78h),a ; 'x'
BC01: 18 18                             jr      LBC1B

                                        ; Referenced from BA0F, BA12
                                        ; --- START PROC LBC03 ---
BC03: CD 91 BC                   LBC03: call    LBC91
BC06: 3A 03 00                          ld      a,(0003h)
BC09: E6 C0                             and     0C0h
BC0B: 28 0A                             jr      z,LBC17
BC0D: FE 40                             cp      40h     ; '@'
BC0F: 28 E3                             jr      z,LBBF4
BC11: FE 80                             cp      80h
BC13: 28 02                             jr      z,LBC17
BC15: 18 D7                             jr      LBBEE

                                        ; Referenced from BBEC, BC0B, BC13
                                        ; --- START PROC LBC17 ---
BC17: 79                         LBC17: ld      a,c
BC18: CD 4E BA                          call    LBA4E

                                        ; Referenced from BBF2, BC01
                                        ; --- START PROC LBC1B ---
BC1B: 18 70                      LBC1B: jr      LBC8D

                                        ; Referenced from BA18
                                        ; --- START PROC LBC1D ---
BC1D: 0E 00                      LBC1D: ld      c,00h
BC1F: CD 3F BC                          call    LBC3F
BC22: 0E 00                             ld      c,00h
BC24: 18 1E                             jr      LBC44

                                        ; Referenced from BA1B
                                        ; --- START PROC LBC26 ---
BC26: 21 00 00                   LBC26: ld      hl,0000h
BC29: 79                                ld      a,c
BC2A: 32 DC BF                          ld      (LBFDC),a
BC2D: FE 04                             cp      04h
BC2F: D0                                ret     nc
BC30: 3A DC BF                          ld      a,(LBFDC)
BC33: 6F                                ld      l,a
BC34: 26 00                             ld      h,00h
BC36: 29                                add     hl,hl
BC37: 29                                add     hl,hl
BC38: 29                                add     hl,hl
BC39: 29                                add     hl,hl
BC3A: 11 68 BA                          ld      de,0BA68h
BC3D: 19                                add     hl,de
BC3E: C9                                ret

                                        ; Referenced from BA1E, BC1F
                                        ; --- START PROC LBC3F ---
BC3F: 79                         LBC3F: ld      a,c
BC40: 32 DA BF                          ld      (LBFDA),a
BC43: C9                                ret

                                        ; Referenced from BA21, BC24
                                        ; --- START PROC LBC44 ---
BC44: 79                         LBC44: ld      a,c
BC45: 32 DB BF                          ld      (LBFDB),a
BC48: C9                                ret

                                        ; Referenced from BA30
                                        ; --- START PROC LBC49 ---
BC49: 7C                         LBC49: ld      a,h
BC4A: 2D                                dec     l
BC4B: C9                                ret

BC4C: 26 00                      LBC4C: ld      h,00h
BC4E: C9                                ret

                                        ; Referenced from BA24
                                        ; --- START PROC LBC4F ---
BC4F: ED 43 DE BF                LBC4F: ld      (LBFDE),bc
BC53: C9                                ret

                                        ; Referenced from BA27
                                        ; --- START PROC LBC54 ---
BC54: CD 91 BC                   LBC54: call    LBC91
BC57: CD D4 BC                          call    LBCD4
BC5A: CD 12 E8                          call    0E812h
BC5D: CD C3 BC                          call    LBCC3
BC60: AF                                xor     a
BC61: 18 2A                             jr      LBC8D

                                        ; Referenced from BA2A
                                        ; --- START PROC LBC63 ---
BC63: CD 91 BC                   LBC63: call    LBC91
BC66: CD D4 BC                          call    LBCD4
BC69: 3A 54 BA                          ld      a,(LBA54)
BC6C: F5                                push    af

                                        ; Referenced from BC89
BC6D: CD BB BC                   LBC6D: call    LBCBB
BC70: CD 0F E8                          call    0E80Fh
BC73: 3A 54 BA                          ld      a,(LBA54)
BC76: FE 00                             cp      00h
BC78: 28 12                             jr      z,LBC8C
BC7A: CD F6 BC                          call    LBCF6
BC7D: B7                                or      a
BC7E: 28 0C                             jr      z,LBC8C
BC80: 21 30 BD                          ld      hl,0BD30h
BC83: CD FA E3                          call    0E3FAh
BC86: F1                                pop     af
BC87: 3D                                dec     a
BC88: F5                                push    af
BC89: 20 E2                             jr      nz,LBC6D
BC8B: 3C                                inc     a

                                        ; Referenced from BC78, BC7E
                                        ; --- START PROC LBC8C ---
BC8C: C1                         LBC8C: pop     bc

                                        ; Referenced from BC1B, BC61
                                        ; --- START PROC LBC8D ---
BC8D: CD A9 BC                   LBC8D: call    LBCA9
BC90: C9                                ret

                                        ; Referenced from BBDE, BC03, BC54, BC63
                                        ; --- START PROC LBC91 ---
BC91: ED 73 D0 BF                LBC91: ld      (LBFD0),sp
BC95: 22 D2 BF                          ld      (LBFD2),hl
BC98: ED 53 D4 BF                       ld      (LBFD4),de
BC9C: ED 43 D6 BF                       ld      (LBFD6),bc
BCA0: 32 D8 BF                          ld      (LBFD8),a
BCA3: D1                                pop     de
BCA4: 31 D0 BF                          ld      sp,0BFD0h
BCA7: D5                                push    de
BCA8: C9                                ret

                                        ; Referenced from BC8D
                                        ; --- START PROC LBCA9 ---
BCA9: E1                         LBCA9: pop     hl
BCAA: ED 7B D0 BF                       ld      sp,(LBFD0)
BCAE: E3                                ex      (sp),hl
BCAF: ED 4B D6 BF                       ld      bc,(LBFD6)
BCB3: ED 5B D4 BF                       ld      de,(LBFD4)
BCB7: 2A D2 BF                          ld      hl,(LBFD2)
BCBA: C9                                ret

                                        ; Referenced from BC6D
                                        ; --- START PROC LBCBB ---
BCBB: 11 A5 BD                   LBCBB: ld      de,0BDA5h
BCBE: 2A DE BF                          ld      hl,(LBFDE)
BCC1: 18 07                             jr      LBCCA

                                        ; Referenced from BC5D
                                        ; --- START PROC LBCC3 ---
BCC3: 11 A5 BD                   LBCC3: ld      de,0BDA5h
BCC6: 2A DE BF                          ld      hl,(LBFDE)
BCC9: EB                                ex      de,hl

                                        ; Referenced from BCC1
                                        ; --- START PROC LBCCA ---
BCCA: 06 80                      LBCCA: ld      b,80h

                                        ; Referenced from BCD1
BCCC: 7E                         LBCCC: ld      a,(hl)
BCCD: 2F                                cpl
BCCE: 12                                ld      (de),a
BCCF: 23                                inc     hl
BCD0: 13                                inc     de
BCD1: 10 F9                             djnz    LBCCC
BCD3: C9                                ret

                                        ; Referenced from BC57, BC66
                                        ; --- START PROC LBCD4 ---
BCD4: 3A DC BF                   LBCD4: ld      a,(LBFDC)
BCD7: 4F                                ld      c,a
BCD8: 3A DD BF                          ld      a,(LBFDD)
BCDB: B9                                cp      c
BCDC: 79                                ld      a,c
BCDD: 32 DD BF                          ld      (LBFDD),a
BCE0: C4 09 E8                          call    nz,0E809h
BCE3: 3A DB BF                          ld      a,(LBFDB)
BCE6: 4F                                ld      c,a
BCE7: CD 06 E8                          call    0E806h
BCEA: 3A DA BF                          ld      a,(LBFDA)
BCED: 4F                                ld      c,a
BCEE: 3A EC BF                          ld      a,(LBFEC)
BCF1: B9                                cp      c
BCF2: C4 03 E8                          call    nz,0E803h
BCF5: C9                                ret

                                        ; Referenced from BC7A
                                        ; --- START PROC LBCF6 ---
BCF6: CD 2A E8                   LBCF6: call    0E82Ah
BCF9: 0E BF                             ld      c,0BFh
BCFB: DD 66 0B                          ld      h,(ix+0Bh)
BCFE: DD 6E 0A                          ld      l,(ix+0Ah)
BD01: 3E 7F                             ld      a,7Fh   ; ''
BD03: D3 BC                             out     (0BCh),a
BD05: 18 02                             jr      LBD09

                                        ; Referenced from BD0C, BD11, BD16, BD1B
BD07: ED A2                      LBD07: ini

                                        ; Referenced from BD05, BD1E
BD09: DB 3F                      LBD09: in      a,(3Fh) ; '?'
BD0B: 07                                rlca
BD0C: 38 F9                             jr      c,LBD07
BD0E: DB 3F                             in      a,(3Fh) ; '?'
BD10: 07                                rlca
BD11: 38 F4                             jr      c,LBD07
BD13: DB 3F                             in      a,(3Fh) ; '?'
BD15: 07                                rlca
BD16: 38 EF                             jr      c,LBD07
BD18: DB 3F                             in      a,(3Fh) ; '?'
BD1A: 07                                rlca
BD1B: 38 EA                             jr      c,LBD07
BD1D: 07                                rlca
BD1E: 30 E9                             jr      nc,LBD09

                                        ; Referenced from BD24
BD20: DB 3F                      LBD20: in      a,(3Fh) ; '?'
BD22: CB 77                             bit     6,a
BD24: 28 FA                             jr      z,LBD20
BD26: DB BC                             in      a,(0BCh)
BD28: 2F                                cpl
BD29: DD 77 0F                          ld      (ix+0Fh),a
BD2C: DD A6 0D                          and     (ix+0Dh)
BD2F: C9                                ret

BD30: 0D                         LBD30: dec     c
BD31: 0A                                ld      a,(bc)
BD32: 44                                ld      b,h
BD33: 49                                ld      c,c
BD34: 53                                ld      d,e
BD35: 4B                                ld      c,e
BD36: 20 57                             jr      nz,LBD8F
BD38: 52                                ld      d,d
BD39: 49                                ld      c,c
BD3A: 54                                ld      d,h
BD3B: 45                                ld      b,l
BD3C: 20 52                             jr      nz,LBD90
BD3E: 45                                ld      b,l
BD3F: 54                                ld      d,h
BD40: 52                                ld      d,d
BD41: 59                                ld      e,c
BD42: 0A                                ld      a,(bc)
BD43: A0                                and     b

                                        ; Referenced from BA51
BD44: DD 21 E0 BF                LBD44: ld      ix,0BFE0h
BD48: DD 66 01                          ld      h,(ix+01h)
BD4B: DD 6E 00                          ld      l,(ix+00h)
BD4E: 11 05 00                          ld      de,0005h
BD51: 19                                add     hl,de
BD52: 56                                ld      d,(hl)
BD53: 23                                inc     hl
BD54: 66                                ld      h,(hl)
BD55: 6A                                ld      l,d
BD56: C9                                ret

                                        ; Referenced from BD59, BD62
BD57: 6F                         LBD57: ld      l,a
BD58: BD                                cp      l

                                        ; Referenced from BA09
                                        ; --- START PROC LBD59 ---
BD59: 2A 57 BD                   LBD59: ld      hl,(LBD57)
BD5C: 7E                                ld      a,(hl)
BD5D: B7                                or      a
BD5E: FA 66 BD                          jp      m,LBD66
BD61: 23                                inc     hl
BD62: 22 57 BD                          ld      (LBD57),hl
BD65: C9                                ret

                                        ; Referenced from BD5E
BD66: 21 DC E3                   LBD66: ld      hl,0E3DCh
BD69: 22 0A BA                          ld      (LBA09+1),hl    ; reference not aligned to instruction
BD6C: E6 7F                             and     7Fh     ; ''
BD6E: C9                                ret

BD6F: 49                         LBD6F: ld      c,c
BD70: 6E                                ld      l,(hl)
BD71: 69                                ld      l,c
BD72: 7A                                ld      a,d
BD73: 69                                ld      l,c
BD74: 6F                                ld      l,a
BD75: 20 4C                             jr      nz,LBDC3
BD77: 61                                ld      h,c
BD78: 76                                halt
BD79: 6F                                ld      l,a
BD7A: 72                                ld      (hl),d
BD7B: 6F                                ld      l,a
BD7C: 8D                                adc     a,l
BD7D: 00                                nop
BD7E: 00                                nop
BD7F: 00                                nop
BD80: FF                                rst     0x38

BD81: AC                         LBD81: xor     h
BD82: A6                                and     (hl)
BD83: AC                                xor     h
BD84: B8                                cp      b
BD85: BA                                cp      d
BD86: B1                                or      c
BD87: DF                                rst     0x18

BD88: DF                         LBD88: rst     0x18

BD89: BC                         LBD89: cp      h
BD8A: B0                                or      b
BD8B: B2                                or      d
BD8C: FF                                rst     0x38

BD8D: FF                         LBD8D: rst     0x38

BD8E: FF                         LBD8E: rst     0x38

                                        ; Referenced from BD36
BD8F: F7                         LBD8F: rst     0x30

                                        ; Referenced from BD3C
BD90: FD FF                      LBD90: rst     0x38

BD92: FF                         LBD92: rst     0x38

BD93: FF                         LBD93: rst     0x38

BD94: FF                         LBD94: rst     0x38

BD95: FF                         LBD95: rst     0x38

BD96: FF                         LBD96: rst     0x38

BD97: FF                         LBD97: rst     0x38

BD98: FF                         LBD98: rst     0x38

BD99: FF                         LBD99: rst     0x38

BD9A: FF                         LBD9A: rst     0x38

BD9B: FF                         LBD9B: rst     0x38

BD9C: FF                         LBD9C: rst     0x38

BD9D: FF                         LBD9D: rst     0x38

BD9E: FF                         LBD9E: rst     0x38

BD9F: FF                         LBD9F: rst     0x38

BDA0: FF                         LBDA0: rst     0x38

BDA1: BB                         LBDA1: cp      e
BDA2: AA                                xor     d
BDA3: B2                                or      d
BDA4: AF                                xor     a
BDA5: DF                                rst     0x18

BDA6: DF                         LBDA6: rst     0x18

BDA7: DF                         LBDA7: rst     0x18

BDA8: DF                         LBDA8: rst     0x18

BDA9: BE                         LBDA9: cp      (hl)
BDAA: AC                                xor     h
BDAB: B2                                or      d
BDAC: FF                                rst     0x38

BDAD: FF                         LBDAD: rst     0x38

BDAE: FF                         LBDAE: rst     0x38

BDAF: DE FC                      LBDAF: sbc     a,0FCh
BDB1: FB                                ei
BDB2: FA F9 F8                          jp      m,0F8F9h
BDB5: FF                                rst     0x38

BDB6: FF                         LBDB6: rst     0x38

BDB7: FF                         LBDB7: rst     0x38

BDB8: FF                         LBDB8: rst     0x38

BDB9: FF                         LBDB9: rst     0x38

BDBA: FF                         LBDBA: rst     0x38

BDBB: FF                         LBDBB: rst     0x38

BDBC: FF                         LBDBC: rst     0x38

BDBD: FF                         LBDBD: rst     0x38

BDBE: FF                         LBDBE: rst     0x38

BDBF: FF                         LBDBF: rst     0x38

BDC0: FF                         LBDC0: rst     0x38

BDC1: AF                         LBDC1: xor     a
BDC2: B6                                or      (hl)

                                        ; Referenced from BD75
BDC3: AF                         LBDC3: xor     a
BDC4: DF                                rst     0x18

BDC5: DF                         LBDC5: rst     0x18

BDC6: DF                         LBDC6: rst     0x18

BDC7: DF                         LBDC7: rst     0x18

BDC8: DF                         LBDC8: rst     0x18

BDC9: BC                         LBDC9: cp      h
BDCA: B0                                or      b
BDCB: B2                                or      d
BDCC: FF                                rst     0x38

BDCD: FF                         LBDCD: rst     0x38

BDCE: FF                         LBDCE: rst     0x38

BDCF: C5                         LBDCF: push    bc
BDD0: F7                                rst     0x30

BDD1: F6 F5                      LBDD1: or      0F5h
BDD3: F4 F3 F2                          call    p,0F2F3h
BDD6: F1                                pop     af
BDD7: F0                                ret     p
BDD8: FF                                rst     0x38

BDD9: FF                         LBDD9: rst     0x38

BDDA: FF                         LBDDA: rst     0x38

BDDB: FF                         LBDDB: rst     0x38

BDDC: FF                         LBDDC: rst     0x38

BDDD: FF                         LBDDD: rst     0x38

BDDE: FF                         LBDDE: rst     0x38

BDDF: FF                         LBDDF: rst     0x38

BDE0: FF                         LBDE0: rst     0x38

BDE1: AC                         LBDE1: xor     h
BDE2: AA                                xor     d
BDE3: BD                                cp      l
BDE4: B2                                or      d
BDE5: B6                                or      (hl)
BDE6: AB                                xor     e
BDE7: DF                                rst     0x18

BDE8: DF                         LBDE8: rst     0x18

BDE9: BC                         LBDE9: cp      h
BDEA: B0                                or      b
BDEB: B2                                or      d
BDEC: FF                                rst     0x38

BDED: FF                         LBDED: rst     0x38

BDEE: FF                         LBDEE: rst     0x38

BDEF: F5                         LBDEF: push    af
BDF0: EF                                rst     0x28

BDF1: EE FF                      LBDF1: xor     0FFh
BDF3: FF                                rst     0x38

BDF4: FF                         LBDF4: rst     0x38

BDF5: FF                         LBDF5: rst     0x38

BDF6: FF                         LBDF6: rst     0x38

BDF7: FF                         LBDF7: rst     0x38

BDF8: FF                         LBDF8: rst     0x38

BDF9: FF                         LBDF9: rst     0x38

BDFA: FF                         LBDFA: rst     0x38

BDFB: FF                         LBDFB: rst     0x38

BDFC: FF                         LBDFC: rst     0x38

BDFD: FF                         LBDFD: rst     0x38

BDFE: FF                         LBDFE: rst     0x38

BDFF: FF                         LBDFF: rst     0x38

BE00: 1A                         LBE00: ld      a,(de)
BE01: 1A                                ld      a,(de)
BE02: 1A                                ld      a,(de)
BE03: 1A                                ld      a,(de)
BE04: 1A                                ld      a,(de)
BE05: 1A                                ld      a,(de)
BE06: 1A                                ld      a,(de)
BE07: 1A                                ld      a,(de)
BE08: 1A                                ld      a,(de)
BE09: 1A                                ld      a,(de)
BE0A: 1A                                ld      a,(de)
BE0B: 1A                                ld      a,(de)
BE0C: 1A                                ld      a,(de)
BE0D: 1A                                ld      a,(de)
BE0E: 1A                                ld      a,(de)
BE0F: 1A                                ld      a,(de)
BE10: 1A                                ld      a,(de)
BE11: 1A                                ld      a,(de)
BE12: 1A                                ld      a,(de)
BE13: 1A                                ld      a,(de)
BE14: 1A                                ld      a,(de)
BE15: 1A                                ld      a,(de)
BE16: 1A                                ld      a,(de)
BE17: 1A                                ld      a,(de)
BE18: 1A                                ld      a,(de)
BE19: 1A                                ld      a,(de)
BE1A: 1A                                ld      a,(de)
BE1B: 1A                                ld      a,(de)
BE1C: 1A                                ld      a,(de)
BE1D: 1A                                ld      a,(de)
BE1E: 1A                                ld      a,(de)
BE1F: 1A                                ld      a,(de)
BE20: 1A                                ld      a,(de)
BE21: 1A                                ld      a,(de)
BE22: 1A                                ld      a,(de)
BE23: 1A                                ld      a,(de)
BE24: 1A                                ld      a,(de)
BE25: 1A                                ld      a,(de)
BE26: 1A                                ld      a,(de)
BE27: 1A                                ld      a,(de)
BE28: 1A                                ld      a,(de)
BE29: 1A                                ld      a,(de)
BE2A: 1A                                ld      a,(de)
BE2B: 1A                                ld      a,(de)
BE2C: 1A                                ld      a,(de)
BE2D: 1A                                ld      a,(de)
BE2E: 1A                                ld      a,(de)
BE2F: 1A                                ld      a,(de)
BE30: 1A                                ld      a,(de)
BE31: 1A                                ld      a,(de)
BE32: 1A                                ld      a,(de)
BE33: 1A                                ld      a,(de)
BE34: 1A                                ld      a,(de)
BE35: 1A                                ld      a,(de)
BE36: 1A                                ld      a,(de)
BE37: 1A                                ld      a,(de)
BE38: 1A                                ld      a,(de)
BE39: 1A                                ld      a,(de)
BE3A: 1A                                ld      a,(de)
BE3B: 1A                                ld      a,(de)
BE3C: 1A                                ld      a,(de)
BE3D: 1A                                ld      a,(de)
BE3E: 1A                                ld      a,(de)
BE3F: 1A                                ld      a,(de)
BE40: 1A                                ld      a,(de)
BE41: 1A                                ld      a,(de)
BE42: 1A                                ld      a,(de)
BE43: 1A                                ld      a,(de)
BE44: 1A                                ld      a,(de)
BE45: 1A                                ld      a,(de)
BE46: 1A                                ld      a,(de)
BE47: 1A                                ld      a,(de)
BE48: 1A                                ld      a,(de)
BE49: 1A                                ld      a,(de)
BE4A: 1A                                ld      a,(de)
BE4B: 1A                                ld      a,(de)
BE4C: 1A                                ld      a,(de)
BE4D: 1A                                ld      a,(de)
BE4E: 1A                                ld      a,(de)
BE4F: 1A                                ld      a,(de)
BE50: 1A                                ld      a,(de)
BE51: 1A                                ld      a,(de)
BE52: 1A                                ld      a,(de)
BE53: 1A                                ld      a,(de)
BE54: 1A                                ld      a,(de)
BE55: 1A                                ld      a,(de)
BE56: 1A                                ld      a,(de)
BE57: 1A                                ld      a,(de)
BE58: 1A                                ld      a,(de)
BE59: 1A                                ld      a,(de)
BE5A: 1A                                ld      a,(de)
BE5B: 1A                                ld      a,(de)
BE5C: 1A                                ld      a,(de)
BE5D: 1A                                ld      a,(de)
BE5E: 1A                                ld      a,(de)
BE5F: 1A                                ld      a,(de)
BE60: 1A                                ld      a,(de)
BE61: 1A                                ld      a,(de)
BE62: 1A                                ld      a,(de)
BE63: 1A                                ld      a,(de)
BE64: 1A                                ld      a,(de)
BE65: 1A                                ld      a,(de)
BE66: 1A                                ld      a,(de)
BE67: 1A                                ld      a,(de)
BE68: 1A                                ld      a,(de)
BE69: 1A                                ld      a,(de)
BE6A: 1A                                ld      a,(de)
BE6B: 1A                                ld      a,(de)
BE6C: 1A                                ld      a,(de)
BE6D: 1A                                ld      a,(de)
BE6E: 1A                                ld      a,(de)
BE6F: 1A                                ld      a,(de)
BE70: 1A                                ld      a,(de)
BE71: 1A                                ld      a,(de)
BE72: 1A                                ld      a,(de)
BE73: 1A                                ld      a,(de)
BE74: 1A                                ld      a,(de)
BE75: 1A                                ld      a,(de)
BE76: 1A                                ld      a,(de)
BE77: 1A                                ld      a,(de)
BE78: 1A                                ld      a,(de)
BE79: 1A                                ld      a,(de)
BE7A: 1A                                ld      a,(de)
BE7B: 1A                                ld      a,(de)
BE7C: 1A                                ld      a,(de)
BE7D: 1A                                ld      a,(de)
BE7E: 1A                                ld      a,(de)
BE7F: 1A                                ld      a,(de)
BE80: 1A                                ld      a,(de)
BE81: 1A                                ld      a,(de)
BE82: 1A                                ld      a,(de)
BE83: 1A                                ld      a,(de)
BE84: 1A                                ld      a,(de)
BE85: 1A                                ld      a,(de)
BE86: 1A                                ld      a,(de)
BE87: 1A                                ld      a,(de)
BE88: 1A                                ld      a,(de)
BE89: 1A                                ld      a,(de)
BE8A: 1A                                ld      a,(de)
BE8B: 1A                                ld      a,(de)
BE8C: 1A                                ld      a,(de)
BE8D: 1A                                ld      a,(de)
BE8E: 1A                                ld      a,(de)
BE8F: 1A                                ld      a,(de)
BE90: 1A                                ld      a,(de)
BE91: 1A                                ld      a,(de)
BE92: 1A                                ld      a,(de)
BE93: 1A                                ld      a,(de)
BE94: 1A                                ld      a,(de)
BE95: 1A                                ld      a,(de)
BE96: 1A                                ld      a,(de)
BE97: 1A                                ld      a,(de)
BE98: 1A                                ld      a,(de)
BE99: 1A                                ld      a,(de)
BE9A: 1A                                ld      a,(de)
BE9B: 1A                                ld      a,(de)
BE9C: 1A                                ld      a,(de)
BE9D: 1A                                ld      a,(de)
BE9E: 1A                                ld      a,(de)
BE9F: 1A                                ld      a,(de)
BEA0: 1A                                ld      a,(de)
BEA1: 1A                                ld      a,(de)
BEA2: 1A                                ld      a,(de)
BEA3: 1A                                ld      a,(de)
BEA4: 1A                                ld      a,(de)
BEA5: 1A                                ld      a,(de)
BEA6: 1A                                ld      a,(de)
BEA7: 1A                                ld      a,(de)
BEA8: 1A                                ld      a,(de)
BEA9: 1A                                ld      a,(de)
BEAA: 1A                                ld      a,(de)
BEAB: 1A                                ld      a,(de)
BEAC: 1A                                ld      a,(de)
BEAD: 1A                                ld      a,(de)
BEAE: 1A                                ld      a,(de)
BEAF: 1A                                ld      a,(de)
BEB0: 1A                                ld      a,(de)
BEB1: 1A                                ld      a,(de)
BEB2: 1A                                ld      a,(de)
BEB3: 1A                                ld      a,(de)
BEB4: 1A                                ld      a,(de)
BEB5: 1A                                ld      a,(de)
BEB6: 1A                                ld      a,(de)
BEB7: 1A                                ld      a,(de)
BEB8: 1A                                ld      a,(de)
BEB9: 1A                                ld      a,(de)
BEBA: 1A                                ld      a,(de)
BEBB: 1A                                ld      a,(de)
BEBC: 1A                                ld      a,(de)
BEBD: 1A                                ld      a,(de)
BEBE: 1A                                ld      a,(de)
BEBF: 1A                                ld      a,(de)
BEC0: 1A                                ld      a,(de)
BEC1: 1A                                ld      a,(de)
BEC2: 1A                                ld      a,(de)
BEC3: 1A                                ld      a,(de)
BEC4: 1A                                ld      a,(de)
BEC5: 1A                                ld      a,(de)
BEC6: 1A                                ld      a,(de)
BEC7: 1A                                ld      a,(de)
BEC8: 1A                                ld      a,(de)
BEC9: 1A                                ld      a,(de)
BECA: 1A                                ld      a,(de)
BECB: 1A                                ld      a,(de)
BECC: 1A                                ld      a,(de)
BECD: 1A                                ld      a,(de)
BECE: 1A                                ld      a,(de)
BECF: 1A                                ld      a,(de)
BED0: 1A                                ld      a,(de)
BED1: 1A                                ld      a,(de)
BED2: 1A                                ld      a,(de)
BED3: 1A                                ld      a,(de)
BED4: 1A                                ld      a,(de)
BED5: 1A                                ld      a,(de)
BED6: 1A                                ld      a,(de)
BED7: 1A                                ld      a,(de)
BED8: 1A                                ld      a,(de)
BED9: 1A                                ld      a,(de)
BEDA: 1A                                ld      a,(de)
BEDB: 1A                                ld      a,(de)
BEDC: 1A                                ld      a,(de)
BEDD: 1A                                ld      a,(de)
BEDE: 1A                                ld      a,(de)
BEDF: 1A                                ld      a,(de)
BEE0: 1A                                ld      a,(de)
BEE1: 1A                                ld      a,(de)
BEE2: 1A                                ld      a,(de)
BEE3: 1A                                ld      a,(de)
BEE4: 1A                                ld      a,(de)
BEE5: 1A                                ld      a,(de)
BEE6: 1A                                ld      a,(de)
BEE7: 1A                                ld      a,(de)
BEE8: 1A                                ld      a,(de)
BEE9: 1A                                ld      a,(de)
BEEA: 1A                                ld      a,(de)
BEEB: 1A                                ld      a,(de)
BEEC: 1A                                ld      a,(de)
BEED: 1A                                ld      a,(de)
BEEE: 1A                                ld      a,(de)
BEEF: 1A                                ld      a,(de)
BEF0: 1A                                ld      a,(de)
BEF1: 1A                                ld      a,(de)
BEF2: 1A                                ld      a,(de)
BEF3: 1A                                ld      a,(de)
BEF4: 1A                                ld      a,(de)
BEF5: 1A                                ld      a,(de)
BEF6: 1A                                ld      a,(de)
BEF7: 1A                                ld      a,(de)
BEF8: 1A                                ld      a,(de)
BEF9: 1A                                ld      a,(de)
BEFA: 1A                                ld      a,(de)
BEFB: 1A                                ld      a,(de)
BEFC: 1A                                ld      a,(de)
BEFD: 1A                                ld      a,(de)
BEFE: 1A                                ld      a,(de)
BEFF: 1A                                ld      a,(de)
BF00: DF                                rst     0x18

BF01: B0                         LBF01: or      b
BF02: B1                                or      c
BF03: DF                                rst     0x18

BF04: 32 D3 DF                   LBF04: ld      (0DFD3h),a
BF07: AB                                xor     e
BF08: B7                                or      a
BF09: BA                                cp      d
BF0A: B1                                or      c
BF0B: DF                                rst     0x18

BF0C: AB                         LBF0C: xor     e
BF0D: A6                                and     (hl)
BF0E: AF                                xor     a
BF0F: BA                                cp      d
BF10: DF                                rst     0x18

BF11: AD                         LBF11: xor     l
BF12: BA                                cp      d
BF13: AB                                xor     e
BF14: AA                                xor     d
BF15: AD                                xor     l
BF16: B1                                or      c
BF17: FF                                rst     0x38

BF18: AF                         LBF18: xor     a
BF19: BA                                cp      d
BF1A: AD                                xor     l
BF1B: B2                                or      d
BF1C: BE                                cp      (hl)
BF1D: B1                                or      c
BF1E: BA                                cp      d
BF1F: B1                                or      c
BF20: AB                                xor     e
BF21: DF                                rst     0x18

BF22: BA                         LBF22: cp      d
BF23: AD                                xor     l
BF24: AD                                xor     l
BF25: B0                                or      b
BF26: AD                                xor     l
BF27: D3 DF                             out     (0DFh),a
BF29: AB                                xor     e
BF2A: A6                                and     (hl)
BF2B: AF                                xor     a
BF2C: BA                                cp      d
BF2D: DF                                rst     0x18

BF2E: AD                         LBF2E: xor     l
BF2F: BA                                cp      d
BF30: AB                                xor     e
BF31: AA                                xor     d
BF32: AD                                xor     l
BF33: B1                                or      c
BF34: DF                                rst     0x18

BF35: AB                         LBF35: xor     e
BF36: B0                                or      b
BF37: DF                                rst     0x18

BF38: B6                         LBF38: or      (hl)
BF39: B8                                cp      b
BF3A: B1                                or      c
BF3B: B0                                or      b
BF3C: AD                                xor     l
BF3D: BA                                cp      d
BF3E: FF                                rst     0x38

BF3F: B9                         LBF3F: cp      c
BF40: AA                                xor     d
BF41: B1                                or      c
BF42: BC                                cp      h
BF43: AB                                xor     e
BF44: B6                                or      (hl)
BF45: B0                                or      b
BF46: B1                                or      c
BF47: DF                                rst     0x18

BF48: BC                         LBF48: cp      h
BF49: B0                                or      b
BF4A: B2                                or      d
BF4B: AF                                xor     a
BF4C: B3                                or      e
BF4D: BA                                cp      d
BF4E: AB                                xor     e
BF4F: BA                                cp      d
BF50: FF                                rst     0x38

BF51: B6                         LBF51: or      (hl)
BF52: B1                                or      c
BF53: A9                                xor     c
BF54: BE                                cp      (hl)
BF55: B3                                or      e
BF56: B6                                or      (hl)
BF57: BB                                cp      e
BF58: DF                                rst     0x18

BF59: BB                         LBF59: cp      e
BF5A: AD                                xor     l
BF5B: B6                                or      (hl)
BF5C: A9                                xor     c
BF5D: BA                                cp      d
BF5E: DF                                rst     0x18

BF5F: B1                         LBF5F: or      c
BF60: BE                                cp      (hl)
BF61: B2                                or      d
BF62: BA                                cp      d
BF63: DF                                rst     0x18

BF64: D7                         LBF64: rst     0x10

BF65: AA                         LBF65: xor     d
BF66: AC                                xor     h
BF67: BA                                cp      d
BF68: DF                                rst     0x18

BF69: BE                         LBF69: cp      (hl)
BF6A: D3 DF                             out     (0DFh),a
BF6C: BD                                cp      l
BF6D: D3 DF                             out     (0DFh),a
BF6F: BC                                cp      h
BF70: D3 DF                             out     (0DFh),a
BF72: B0                                or      b
BF73: AD                                xor     l
BF74: DF                                rst     0x18

BF75: BB                         LBF75: cp      e
BF76: D6 FF                             sub     0FFh
BF78: B1                                or      c
BF79: B0                                or      b
BF7A: DF                                rst     0x18

BF7B: AC                         LBF7B: xor     h
BF7C: B0                                or      b
BF7D: AA                                xor     d
BF7E: AD                                xor     l
BF7F: BC                                cp      h
BF80: 1A                                ld      a,(de)
BF81: AB                                xor     e
BF82: BA                                cp      d
BF83: AC                                xor     h
BF84: AB                                xor     e
BF85: DF                                rst     0x18

BF86: DF                         LBF86: rst     0x18

BF87: DF                         LBF87: rst     0x18

BF88: DF                         LBF88: rst     0x18

BF89: DF                         LBF89: rst     0x18

BF8A: DF                         LBF8A: rst     0x18

BF8B: DF                         LBF8B: rst     0x18

BF8C: FF                         LBF8C: rst     0x38

BF8D: FF                         LBF8D: rst     0x38

BF8E: FF                         LBF8E: rst     0x38

BF8F: FE 9A                      LBF8F: cp      9Ah
BF91: FF                                rst     0x38

BF92: FF                         LBF92: rst     0x38

BF93: FF                         LBF93: rst     0x38

BF94: FF                         LBF94: rst     0x38

BF95: FF                         LBF95: rst     0x38

BF96: FF                         LBF96: rst     0x38

BF97: FF                         LBF97: rst     0x38

BF98: FF                         LBF98: rst     0x38

BF99: FF                         LBF99: rst     0x38

BF9A: FF                         LBF9A: rst     0x38

BF9B: FF                         LBF9B: rst     0x38

BF9C: FF                         LBF9C: rst     0x38

BF9D: FF                         LBF9D: rst     0x38

BF9E: FF                         LBF9E: rst     0x38

BF9F: FF                         LBF9F: rst     0x38

BFA0: 1A                         LBFA0: ld      a,(de)
BFA1: AB                                xor     e
BFA2: BA                                cp      d
BFA3: AC                                xor     h
BFA4: AB                                xor     e
BFA5: DF                                rst     0x18

BFA6: DF                         LBFA6: rst     0x18

BFA7: DF                         LBFA7: rst     0x18

BFA8: DF                         LBFA8: rst     0x18

BFA9: AF                         LBFA9: xor     a
BFAA: AD                                xor     l
BFAB: B1                                or      c
BFAC: FF                                rst     0x38

BFAD: FF                         LBFAD: rst     0x38

BFAE: FF                         LBFAE: rst     0x38

BFAF: FF                         LBFAF: rst     0x38

BFB0: FF                         LBFB0: rst     0x38

BFB1: FF                         LBFB1: rst     0x38

BFB2: FF                         LBFB2: rst     0x38

BFB3: FF                         LBFB3: rst     0x38

BFB4: FF                         LBFB4: rst     0x38

BFB5: FF                         LBFB5: rst     0x38

BFB6: FF                         LBFB6: rst     0x38

BFB7: FF                         LBFB7: rst     0x38

BFB8: FF                         LBFB8: rst     0x38

BFB9: FF                         LBFB9: rst     0x38

BFBA: FF                         LBFBA: rst     0x38

BFBB: FF                         LBFBB: rst     0x38

BFBC: FF                         LBFBC: rst     0x38

BFBD: FF                         LBFBD: rst     0x38

BFBE: FF                         LBFBE: rst     0x38

BFBF: FF                         LBFBF: rst     0x38

BFC0: 1A                         LBFC0: ld      a,(de)
BFC1: AB                                xor     e
BFC2: BA                                cp      d
BFC3: AC                                xor     h
BFC4: AB                                xor     e
BFC5: DF                                rst     0x18

BFC6: DF                         LBFC6: rst     0x18

BFC7: DF                         LBFC7: rst     0x18

BFC8: DF                         LBFC8: rst     0x18

BFC9: B7                         LBFC9: or      a
BFCA: BA                                cp      d
BFCB: A7                                and     a
BFCC: FF                                rst     0x38

BFCD: FF                         LBFCD: rst     0x38

BFCE: FF                         LBFCE: rst     0x38

BFCF: FF                         LBFCF: rst     0x38

                                        ; Referenced from BC91, BCAA
BFD0: FF                         LBFD0: rst     0x38

BFD1: FF                         LBFD1: rst     0x38

                                        ; Referenced from BC95, BCB7
BFD2: FF                         LBFD2: rst     0x38

BFD3: FF                         LBFD3: rst     0x38

                                        ; Referenced from BC98, BCB3
BFD4: FF                         LBFD4: rst     0x38

BFD5: FF                         LBFD5: rst     0x38

                                        ; Referenced from BC9C, BCAF
BFD6: FF                         LBFD6: rst     0x38

BFD7: FF                         LBFD7: rst     0x38

                                        ; Referenced from BCA0
BFD8: FF                         LBFD8: rst     0x38

BFD9: FF                         LBFD9: rst     0x38

                                        ; Referenced from BC40, BCEA
BFDA: FF                         LBFDA: rst     0x38

                                        ; Referenced from BC45, BCE3
BFDB: FF                         LBFDB: rst     0x38

                                        ; Referenced from BC2A, BC30, BCD4
BFDC: FF                         LBFDC: rst     0x38

                                        ; Referenced from BCD8, BCDD
BFDD: FF                         LBFDD: rst     0x38

                                        ; Referenced from BC4F, BCBE, BCC6
BFDE: FF                         LBFDE: rst     0x38

BFDF: FF                         LBFDF: rst     0x38

BFE0: FF                         LBFE0: rst     0x38

BFE1: AF                         LBFE1: xor     a
BFE2: B3                                or      e
BFE3: BD                                cp      l
BFE4: DF                                rst     0x18

BFE5: DF                         LBFE5: rst     0x18

BFE6: DF                         LBFE6: rst     0x18

BFE7: DF                         LBFE7: rst     0x18

BFE8: DF                         LBFE8: rst     0x18

BFE9: AF                         LBFE9: xor     a
BFEA: AD                                xor     l
BFEB: B1                                or      c

                                        ; Referenced from BCEE
BFEC: FF                         LBFEC: rst     0x38

BFED: FF                         LBFED: rst     0x38

BFEE: FF                         LBFEE: rst     0x38

BFEF: FF                         LBFEF: rst     0x38

BFF0: FF                         LBFF0: rst     0x38

BFF1: FF                         LBFF1: rst     0x38

BFF2: FF                         LBFF2: rst     0x38

BFF3: FF                         LBFF3: rst     0x38

BFF4: FF                         LBFF4: rst     0x38

BFF5: FF                         LBFF5: rst     0x38

BFF6: FF                         LBFF6: rst     0x38

BFF7: FF                         LBFF7: rst     0x38

BFF8: FF                         LBFF8: rst     0x38

BFF9: FF                         LBFF9: rst     0x38

BFFA: FF                         LBFFA: rst     0x38

BFFB: FF                         LBFFB: rst     0x38

BFFC: FF                         LBFFC: rst     0x38

BFFD: FF                         LBFFD: rst     0x38

BFFE: FF                         LBFFE: rst     0x38

BFFF: FF                         LBFFF: rst     0x38


references to external address 0000h:
        AC1A ld hl,0000h
        ACA1 jp z,0000h
        ACB7 jp 0000h
        AD3D jp z,0000h
        AEBA jp z,0000h
        B3F9 ld hl,0000h
        B62D ld bc,0000h
        B883 ld hl,0000h
        BA33 jp 0000h
        BA36 jp 0000h
        BA39 jp 0000h
        BA3C jp 0000h
        BA3F jp 0000h
        BA42 jp 0000h
        BA45 jp 0000h
        BA48 jp 0000h
        BA4B jp 0000h
        BB30 ld (0000h),a
        BC26 ld hl,0000h

references to external address 0001h:
        B110 ld hl,0001h
        BA55 ld sp,0001h
        BB36 ld (0001h),hl

references to external address 0003h:
        AEED ld a,(0003h)
        AEF3 ld hl,0003h
        B50F ld bc,0003h
        BB13 ld (0003h),a
        BB7B ld a,(0003h)
        BBA2 ld a,(0003h)
        BBC8 ld a,(0003h)
        BBE1 ld a,(0003h)
        BC06 ld a,(0003h)

references to external address 0004h:
        A525 ld (0004h),a
        A52C ld (0004h),a
        BB16 ld (0004h),a
        BB49 ld a,(0004h)

references to external address 0005h:
        A48F jp 0005h
        A4BA jp 0005h
        A4C0 jp 0005h
        A4C3 call 0005h
        A4F1 jp 0005h
        A4F4 call 0005h
        A510 jp 0005h
        A517 jp 0005h
        A5A1 call 0005h
        A5C4 call 0005h
        A5CB call 0005h
        A5D2 jp 0005h
        A5DA jp 0005h
        BB39 ld (0005h),a
        BD4E ld de,0005h

references to external address 0006h:
        BB3F ld (0006h),hl

references to external address 0080h:
        A565 ld hl,0080h
        A5D5 ld de,0080h
        A798 ld de,0080h
        A84B ld hl,0080h
        A988 ld hl,0080h
        A9DB ld hl,0080h
        AAF0 ld de,0080h
        AB50 ld (0080h),a
        B890 ld hl,0080h
        BAD1 ld sp,0080h
        BAF5 ld de,0080h

references to external address 0100h:
        A9D1 ld de,0100h
        AADE ld hl,0100h
        AB5C call 0100h

references to external address 21BAh:
        BA72 jp nz,21BAh

references to external address 2420h:
        ACC7 ld a,(2420h)

references to external address 31BAh:
        BA82 jp nz,31BAh

references to external address 41BAh:
        BA92 jp nz,41BAh

references to external address 51BAh:
        BAA2 jp nz,51BAh

references to external address 0DFD3h:
        BF04 ld (0DFD3h),a

references to external address 0E003h:
        BBB8 ld iy,(0E003h)

references to external address 0E3DCh:
        BB6D jp 0E3DCh
        BD66 ld hl,0E3DCh

references to external address 0E3FAh:
        BB1C call 0E3FAh
        BC83 call 0E3FAh

references to external address 0E403h:
        BB72 call 0E403h
        BB77 call 0E403h
        BBEF call 0E403h

references to external address 0E650h:
        BA4E jp 0E650h

references to external address 0E800h:
        BAD9 call 0E800h

references to external address 0E803h:
        BB0A call 0E803h
        BCF2 call nz,0E803h

references to external address 0E806h:
        BAE9 call 0E806h
        BCE7 call 0E806h

references to external address 0E809h:
        BAD6 call 0E809h
        BCE0 call nz,0E809h

references to external address 0E80Ch:
        BAEE call 0E80Ch
        BB45 call 0E80Ch

references to external address 0E80Fh:
        BC70 call 0E80Fh

references to external address 0E812h:
        BAF1 call 0E812h
        BC5A call 0E812h

references to external address 0E82Ah:
        BCF6 call 0E82Ah

references to external address 0EDAEh:
        AC53 call nc,0EDAEh

references to external address 0F2F3h:
        BDD3 call p,0F2F3h

references to external address 0F5B8h:
        AC73 call pe,0F5B8h

references to external address 0F8F9h:
        BDB2 jp m,0F8F9h

possible references to internal address A400:
        A7D5 ld hl,0A400h
        AAF4 ld de,0A400h
        B6D4 ld hl,0A400h
        BAE2 ld hl,0A400h
        ----------
        A7D2 ld (LA400),hl
        BB4D jp LA400

possible references to internal address A406:
        A59E ld de,0A406h

possible references to internal address A407:
        A562 ld de,0A407h
        A5A7 ld hl,0A407h
        A930 ld hl,0A407h
        ----------
        A759 ld (LA407),a
        A77B ld a,(LA407)

possible references to internal address A408:
        A584 ld hl,0A408h
        A5BB ld hl,0A408h
        AB2D ld hl,0A408h

possible references to internal address A710:
        A72E ld hl,0A710h

possible references to internal address A728:
        A5F5 ld de,0A728h

possible references to internal address A7C1:
        A7B4 ld hl,0A7C1h

possible references to internal address A7DF:
        A7D9 ld bc,0A7DFh

possible references to internal address A7F0:
        A7EA ld bc,0A7F0h

possible references to internal address A952:
        A927 ld bc,0A952h

possible references to internal address AA07:
        A9FB ld bc,0AA07h

possible references to internal address AA82:
        AA79 ld bc,0AA82h

possible references to internal address AB7A:
        AB71 ld bc,0AB7Ah

possible references to internal address AB83:
        AAD2 ld hl,0AB83h

possible references to internal address ABAB:
        A5DD ld hl,0ABABh
        A75C ld sp,0ABABh
        A782 ld sp,0ABABh
        AB5F ld sp,0ABABh
        ----------
        A539 ld a,(LABAB)
        A76E ld (LABAB),a

possible references to internal address ABAC:
        A549 ld de,0ABACh
        A559 ld de,0ABACh
        A574 ld de,0ABACh
        A5E9 ld de,0ABACh

possible references to internal address ABBA:
        A56D ld hl,0ABBAh

possible references to internal address ABCD:
        A4D4 ld de,0ABCDh
        A4E9 ld de,0ABCDh
        A4FE ld de,0ABCDh
        A660 ld hl,0ABCDh
        A945 ld de,0ABCDh
        A9BA ld de,0ABCDh
        A9E3 ld de,0ABCDh
        A9F1 ld de,0ABCDh
        AA23 ld hl,0ABCDh
        AA64 ld de,0ABCDh
        AAE6 ld de,0ABCDh
        AB25 ld hl,0ABCDh
        ----------
        A855 ld (LABCD),a
        AA5B ld (LABCD),a
        AB11 ld (LABCD),a

possible references to internal address ABCE:
        A737 ld de,0ABCEh
        A802 ld hl,0ABCEh
        A87D ld hl,0ABCEh
        ----------
        AA97 ld a,(LABCE)
        AAA8 ld a,(LABCE)
        AB8C ld a,(LABCE)

possible references to internal address ABD6:
        AAC4 ld de,0ABD6h

possible references to internal address ABDD:
        AA26 ld de,0ABDDh
        ----------
        AB1B ld (LABDD),a

possible references to internal address ABEF:
        A521 ld hl,0ABEFh
        A85E ld hl,0ABEFh
        A86C ld hl,0ABEFh
        ----------
        A529 ld a,(LABEF)
        A540 ld a,(LABEF)
        A57D ld a,(LABEF)
        A5EF ld a,(LABEF)
        A689 ld a,(LABEF)
        A775 ld (LABEF),a
        A7A1 ld (LABEF),a
        A871 ld a,(LABEF)
        AAB8 ld (LABEF),a

possible references to internal address ABF0:
        AA4C ld hl,0ABF0h
        AB0C ld hl,0ABF0h
        AB91 ld hl,0ABF0h
        ----------
        A669 ld (LABF0),a
        A691 ld (LABF0),a
        A7AA ld a,(LABF0)
        A7FB ld a,(LABF0)
        A858 ld a,(LABF0)
        A866 ld a,(LABF0)
        AA16 ld a,(LABF0)
        AAB0 ld a,(LABF0)

possible references to internal address ABF1:
        A96F ld hl,0ABF1h
        A974 ld hl,0ABF1h

possible references to internal address AC00:
        A5F8 ld hl,0AC00h

possible references to internal address AC06:
        BB3C ld hl,0AC06h

possible references to internal address AC09:
        AFBD ld hl,0AC09h

possible references to internal address AC0B:
        AF47 ld hl,0AC0Bh

possible references to internal address AC0D:
        B158 ld hl,0AC0Dh

possible references to internal address AC0F:
        B14E ld hl,0AC0Fh

possible references to internal address AC47:
        AC37 ld hl,0AC47h

possible references to internal address ACBA:
        ACF1 ld bc,0ACBAh

possible references to internal address ACCA:
        AC99 ld hl,0ACCAh

possible references to internal address ACD5:
        ACA5 ld hl,0ACD5h

possible references to internal address ACDC:
        ACB1 ld hl,0ACDCh

possible references to internal address ACE1:
        ACAB ld hl,0ACE1h

possible references to internal address AF0A:
        AE9C ld hl,0AF0Ah
        ----------
        AD48 ld a,(LAF0A)
        AE10 ld (LAF0A),a
        AE8B ld a,(LAF0A)
        AE96 ld (LAF0A),a

possible references to internal address AF0B:
        ADBC ld hl,0AF0Bh
        ----------
        ADE4 ld (LAF0B),a
        AE31 ld (LAF0B),a
        AE4E ld a,(LAF0B)

possible references to internal address AF0C:
        AD63 ld hl,0AF0Ch
        AE51 ld hl,0AF0Ch
        AE92 ld hl,0AF0Ch
        ----------
        AD9B ld a,(LAF0C)
        ADB9 ld a,(LAF0C)
        ADE1 ld a,(LAF0C)
        AE0D ld a,(LAF0C)

possible references to internal address AF0D:
        AE3D ld hl,0AF0Dh
        ----------
        AD5A ld a,(LAF0D)

possible references to internal address AF0E:
        ACFB ld hl,0AF0Eh
        ----------
        AD23 ld a,(LAF0E)
        AD42 ld (LAF0E),a

possible references to internal address AF41:
        AC24 ld sp,0AF41h
        ----------
        B2E4 ld a,(LAF41)
        B875 ld a,(LAF41)
        B935 ld a,(LAF41)
        B93D ld (LAF41),a

possible references to internal address AF42:
        B848 ld hl,0AF42h
        ----------
        ACE9 ld a,(LAF42)
        AF59 ld a,(LAF42)
        B10C ld a,(LAF42)
        B121 ld a,(LAF42)
        B824 ld a,(LAF42)
        B865 ld a,(LAF42)
        B88D ld (LAF42),a
        B904 ld a,(LAF42)

possible references to internal address AF45:
        B51F ld hl,0AF45h
        B6F2 ld hl,0AF45h
        ----------
        AC1D ld (LAF45),hl
        AF01 ld (LAF45),a
        B2F3 ld (LAF45),a
        B388 ld (LAF45),a
        B4A3 ld (LAF45),a
        B5DF ld a,(LAF45)
        B66E ld a,(LAF45)
        B750 ld a,(LAF45)
        B764 ld a,(LAF45)
        B778 ld a,(LAF45)
        B78D ld (LAF45),a
        B929 ld (LAF45),hl
        B995 ld hl,(LAF45)

possible references to internal address B974:
        AC2E ld hl,0B974h

possible references to internal address B9AC:
        B52B ld hl,0B9ACh

possible references to internal address B9AD:
        B12C ld hl,0B9ADh
        ----------
        B11E ld hl,(LB9AD)
        B135 ld (LB9AD),hl
        B886 ld (LB9AD),hl
        B917 ld hl,(LB9AD)
        B963 ld hl,(LB9AD)
        B970 ld (LB9AD),hl

possible references to internal address B9B1:
        B1DA ld hl,0B9B1h
        ----------
        B1ED ld hl,(LB9B1)
        B893 ld (LB9B1),hl
        B90B ld (LB9B1),hl

possible references to internal address B9B9:
        AF7A ld hl,0B9B9h
        B1E0 ld hl,0B9B9h
        ----------
        B0F9 ld hl,(LB9B9)
        B15E ld hl,(LB9B9)
        B1E9 ld hl,(LB9B9)
        B688 ld hl,(LB9B9)

possible references to internal address B9C1:
        AF86 ld hl,0B9C1h
        ----------
        AFEC ld hl,(LB9C1)
        AFFB ld hl,(LB9C1)

possible references to internal address B9C3:
        B03E ld hl,0B9C3h
        ----------
        B08A ld a,(LB9C3)

possible references to internal address B9D2:
        B579 ld hl,0B9D2h
        ----------
        B519 ld (LB9D2),a
        B55B ld (LB9D2),a

possible references to internal address B9D4:
        B38B ld hl,0B9D4h
        ----------
        B301 ld a,(LB9D4)
        B31A ld (LB9D4),a

possible references to internal address B9D8:
        B31D ld hl,0B9D8h
        ----------
        B34D ld a,(LB9D8)

possible references to internal address B9DD:
        AF92 ld hl,0B9DDh
        ----------
        B066 ld a,(LB9DD)
        B279 ld a,(LB9DD)
        B4CD ld a,(LB9DD)
        B653 ld a,(LB9DD)

possible references to internal address B9E1:
        B5CC ld hl,0B9E1h
        B6C7 ld hl,0B9E1h
        ----------
        B0C4 ld (LB9E1),a
        B0E5 ld a,(LB9E1)

possible references to internal address B9E5:
        AFD1 ld hl,0B9E5h
        ----------
        AFCB ld (LB9E5),hl
        B080 ld (LB9E5),hl
        B084 ld hl,(LB9E5)
        B08D ld hl,(LB9E5)
        B0A2 ld (LB9E5),hl
        B648 ld (LB9E5),hl
        B69A ld (LB9E5),hl
        B6A5 ld hl,(LB9E5)
        B6B5 ld (LB9E5),hl

possible references to internal address B9EA:
        B1F5 ld hl,0B9EAh
        ----------
        AFC3 ld hl,(LB9EA)
        B17F ld hl,(LB9EA)
        B201 ld (LB9EA),hl
        B209 ld hl,(LB9EA)
        B20D ld (LB9EA),hl
        B219 ld a,(LB9EA)
        B383 ld a,(LB9EA)
        B4A6 ld (LB9EA),a

possible references to internal address BA03:
        BB33 ld hl,0BA03h

possible references to internal address BA56:
        BB22 ld hl,0BA56h

possible references to internal address BA68:
        BC3A ld de,0BA68h

possible references to internal address BB50:
        BB19 ld hl,0BB50h

possible references to internal address BD30:
        BC80 ld hl,0BD30h

possible references to internal address BDA5:
        BB42 ld hl,0BDA5h
        BCBB ld de,0BDA5h
        BCC3 ld de,0BDA5h

possible references to internal address BFD0:
        BCA4 ld sp,0BFD0h
        ----------
        BC91 ld (LBFD0),sp
        BCAA ld sp,(LBFD0)

possible references to internal address BFE0:
        BD44 ld ix,0BFE0h

possible references to external address 0000h:
        AC1A ld hl,0000h
        B3F9 ld hl,0000h
        B62D ld bc,0000h
        B883 ld hl,0000h
        BC26 ld hl,0000h
        ----------
        ACA1 jp z,0000h
        ACB7 jp 0000h
        AD3D jp z,0000h
        AEBA jp z,0000h
        BA33 jp 0000h
        BA36 jp 0000h
        BA39 jp 0000h
        BA3C jp 0000h
        BA3F jp 0000h
        BA42 jp 0000h
        BA45 jp 0000h
        BA48 jp 0000h
        BA4B jp 0000h
        BB30 ld (0000h),a

possible references to external address 0001h:
        B110 ld hl,0001h
        BA55 ld sp,0001h
        ----------
        BB36 ld (0001h),hl

possible references to external address 0002h:
        B583 ld bc,0002h

possible references to external address 0003h:
        AEF3 ld hl,0003h
        B50F ld bc,0003h
        ----------
        AEED ld a,(0003h)
        BB13 ld (0003h),a
        BB7B ld a,(0003h)
        BBA2 ld a,(0003h)
        BBC8 ld a,(0003h)
        BBE1 ld a,(0003h)
        BC06 ld a,(0003h)

possible references to external address 0005h:
        BD4E ld de,0005h
        ----------
        A48F jp 0005h
        A4BA jp 0005h
        A4C0 jp 0005h
        A4C3 call 0005h
        A4F1 jp 0005h
        A4F4 call 0005h
        A510 jp 0005h
        A517 jp 0005h
        A5A1 call 0005h
        A5C4 call 0005h
        A5CB call 0005h
        A5D2 jp 0005h
        A5DA jp 0005h
        BB39 ld (0005h),a

possible references to external address 0009h:
        B147 ld de,0009h

possible references to external address 000Bh:
        A6FE ld bc,000Bh
        A805 ld bc,000Bh

possible references to external address 000Ch:
        B0A9 ld de,000Ch
        B471 ld hl,000Ch
        B568 ld bc,000Ch
        B733 ld hl,000Ch
        B757 ld hl,000Ch
        B7AA ld hl,000Ch

possible references to external address 000Dh:
        B54C ld hl,000Dh

possible references to external address 000Eh:
        B16C ld de,000Eh
        B73C ld hl,000Eh
        B75C ld hl,000Eh
        B7BE ld hl,000Eh

possible references to external address 000Fh:
        B0B1 ld de,000Fh
        B476 ld hl,000Fh
        B48E ld de,000Fh
        B53F ld hl,000Fh
        B7ED ld de,000Fh

possible references to external address 0010h:
        B061 ld de,0010h
        B26E ld de,0010h
        B422 ld de,0010h
        B4BF ld bc,0010h
        B64F ld bc,0010h

possible references to external address 0011h:
        B0B6 ld hl,0011h

possible references to external address 0014h:
        A728 ld de,0014h
        AC00 ld de,0014h

possible references to external address 0020h:
        B72E ld hl,0020h
        B811 ld de,0020h

possible references to external address 0021h:
        B70C ld hl,0021h
        B7DA ld de,0021h
        B817 ld hl,0021h

possible references to external address 005Ch:
        AB22 ld de,005Ch

possible references to external address 0080h:
        A565 ld hl,0080h
        A5D5 ld de,0080h
        A798 ld de,0080h
        A84B ld hl,0080h
        A988 ld hl,0080h
        A9DB ld hl,0080h
        AAF0 ld de,0080h
        B890 ld hl,0080h
        BAD1 ld sp,0080h
        BAF5 ld de,0080h
        ----------
        AB50 ld (0080h),a

possible references to external address 0081h:
        AB40 ld de,0081h

possible references to external address 0100h:
        A9D1 ld de,0100h
        AADE ld hl,0100h
        ----------
        AB5C call 0100h

possible references to external address 0317h:
        BAAF ld de,0317h

possible references to external address 0D07h:
        BAA8 ld bc,0D07h

possible references to external address 2CB9h:
        AC7D ld de,2CB9h

possible references to external address 76F3h:
        A7CF ld hl,76F3h

possible references to external address 0E3DCh:
        BD66 ld hl,0E3DCh
        ----------
        BB6D jp 0E3DCh

possible references to external address 0FFECh:
        B503 ld bc,0FFECh

possible references to external address 0FFFFh:
        B1FE ld hl,0FFFFh

references to port 3Fh
        BD09 in a,(3Fh)
        BD0E in a,(3Fh)
        BD13 in a,(3Fh)
        BD18 in a,(3Fh)
        BD20 in a,(3Fh)

references to port 5Dh
        BBB4 in a,(5Dh)

references to port 78h
        BBDB in a,(78h)
        BBFF out (78h),a

references to port 7Ah
        BB8F in a,(7Ah)
        BB9C in a,(7Ah)
        BBD4 in a,(7Ah)
        BBF7 in a,(7Ah)
        BB26 out (7Ah),a
        BB8D out (7Ah),a
        BB9A out (7Ah),a
        BBD2 out (7Ah),a
        BBF5 out (7Ah),a

references to port 0BCh
        BD26 in a,(0BCh)
        BD03 out (0BCh),a

references to port 0DFh
        BF27 out (0DFh),a
        BF6A out (0DFh),a
        BF6D out (0DFh),a
        BF70 out (0DFh),a

references to port 0FFh
        BB84 in a,(0FFh)

Procedures (192):
  Proc  Length  References Dependants
  LA48C  0006            7          1
  LA492  0006            7          1
  LA498  000A            7          1
  LA4A2  0005            3          1
  LA4A7  0006            6          2
  LA4AC  000C            2          1
  LA4B8  0005            1          1
  LA4BD  0006            9          1
  LA4C3  0008            5          1
  LA4CB  0005            2          1
  LA4D0  000A            2          1
  LA4DA  0005            2          1
  LA4DF  0005            1          1
  LA4E4  0005            1          1
  LA4E9  0006            3          1
  LA4EF  0005            3          1
  LA4F4  0005            2          1
  LA4F9  0005            3          1
  LA4FE  0006            1          1
  LA504  0005            1          1
  LA509  0005            1          1
  LA50E  0005            1          1
  LA513  0004            1          1
  LA515  0005            2          1
  LA51A  000F            2          1
  LA529  0007            3          0
  LA530  0009            1          0
  LA539  0089            2         13
  LA5C2  000E            3          1
  LA5D0  0005            3          1
  LA5D5  0005            2          1
  LA5D8  0005            3          1
  LA5DD  0018            3          2
  LA5F5  0014            1          1
  LA609  0027           19          4
  LA630  001F            4          1
  LA64F  000A            3          0
  LA659  0005            3          0
  LA65E  0005           10          1
  LA660  00B0            1          3
  LA72E  002A            1          0
  LA782  003F            6          9
  LA7CF  000A            1          0
  LA7D9  0006            1          1
  LA7EA  0006            3          1
  LA7F8  0048            2          2
  LA840  0003            1          1
  LA842  0009            4          0
  LA84B  0009            3          1
  LA854  0012            6          1
  LA866  0011            5          1
  LA898  0027            1          7
  LA8BE  02DD            1         10
  LA8CC  0046            1          5
  LA90E  0004            2          1
  LA90F  000C            1          4
  LA91B  0004            2          1
  LAAA5  00F6            1         19
  LAB86  0015           10          4
  LACE5  0019            2          3
  LACFB  000B            2          1
  LAD06  000E            1          3
  LAD14  000F            2          0
  LAD23  0025            2          3
  LAD48  0037            8          3
  LAD7F  0012            2          3
  LAD90  0014            3          1
  LADA4  000A            2          2
  LADAC  0005            1          1
  LADB1  0018            2          2
  LADC9  000A            3          1
  LADD3  000E            4          1
  LAF01  0004           13          0
  LAF05  0005            3          1
  LAF47  0004            1          1
  LAF4A  0005            3          0
  LAF4F  000A            5          0
  LAF59  0048            1          2
  LAFA1  0011            2          1
  LAFB2  0006            2          2
  LAFB8  000B            3          2
  LAFBB  0008            1          1
  LAFC3  0011            2          2
  LAFD1  006D            3          3
  LB03E  0020            2          0
  LB05E  0019            2          0
  LB077  000D            2          2
  LB084  0006            2          0
  LB08A  001C            2          0
  LB0A6  0008            3          0
  LB0AE  000D            2          0
  LB0BB  0017            3          2
  LB0D2  0018            3          1
  LB0EA  000D            4          0
  LB0F7  000D            1          0
  LB104  0007            1          0
  LB10B  0013            2          1
  LB11E  000E            2          1
  LB12C  0018            1          1
  LB144  0006            2          2
  LB147  000D            1          1
  LB154  000A            4          2
  LB15E  0007            9          1
  LB164  0005            1          0
  LB169  0009            5          0
  LB172  0006            3          1
  LB178  0007            4          1
  LB17F  000D            3          0
  LB18C  0009            2          1
  LB195  0007            2          0
  LB19C  002A            1          4
  LB19E  0028            1          4
  LB1C6  000E            2          4
  LB1D4  0009            1          3
  LB1DA  0006            4          1
  LB1E0  0009            3          1
  LB1E3  0006            1          1
  LB1F5  0009           12          0
  LB1FE  0007            4          0
  LB205  0030            2          5
  LB235  0027            3          0
  LB25C  0009            1          2
  LB264  0007            2          0
  LB26B  0038            2          2
  LB2A3  005E            1          8
  LB307  0011            1          0
  LB318  0017            9          3
  LB32D  006F            7          7
  LB39C  0022            1          8
  LB3BE  003F            1          2
  LB3FD  0005            1          1
  LB401  0015            2          4
  LB410  0006            1          2
  LB416  0025            1          6
  LB43B  0016            1          4
  LB451  000C            2          3
  LB45A  003A            1          4
  LB494  000E            2          0
  LB4A2  0082            3          7
  LB524  0036            3          6
  LB55A  0062            2          9
  LB5C1  003D            1         10
  LB5FB  0003            3          1
  LB603  0100            2         20
  LB700  0003            2          1
  LB703  0005            2          1
  LB707  008C            1          6
  LB7A5  002D            2          0
  LB821  0024            2          5
  LB845  000C            2          1
  LB851  002D           14          1
  LBA06  0003            3          1
  LBA09  0003            5          1
  LBA0C  0003            4          1
  LBA0F  0003            1          1
  LBA15  0003            1          1
  LBA18  0003            1          1
  LBA1B  0003            1          1
  LBA1E  0003            1          1
  LBA21  0003            1          1
  LBA24  0003            1          1
  LBA27  0003            1          1
  LBA2A  0003            1          1
  LBA30  0003            1          1
  LBA4E  0003            1          1
  LBB6D  0003            1          1
  LBB7B  001E            1          0
  LBBC8  0016            2          1
  LBBDE  0025            1          4
  LBBEE  0006            1          2
  LBBF4  000F            3          1
  LBC03  0014            2          4
  LBC17  0006            3          2
  LBC1B  0002            2          1
  LBC1D  0009            1          2
  LBC26  0019            1          0
  LBC3F  0005            2          0
  LBC44  0005            2          0
  LBC49  0003            1          0
  LBC4F  0005            1          0
  LBC54  000F            1          5
  LBC63  002D            1          8
  LBC8C  0004            2          1
  LBC8D  0004            2          1
  LBC91  0018            4          0
  LBCA9  0012            1          0
  LBCBB  0008            1          1
  LBCC3  0011            1          0
  LBCCA  000A            1          0
  LBCD4  0022            2          3
  LBCF6  003A            1          1
  LBD59  0016            1          0

Call Graph: