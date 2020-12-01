

EPROM2_PRINTSTRING EQU $E009     ; print string routine in rom set 2

ORG $100

BOOTRIG:
       LD      SP,0080h          ; set temporary stack
       LD      C,21h             ; numero drive: 1 or 32, cos'è il bit 5?
       CALL    EPROM_SETDRIVE    ; imposta drive
       CALL    EPROM_INITD       ; inizializza sistema dischi
       LD      B,1Ah             ; B counts 26 sectors of 256 bytes each, lenght of CCP+BDOS+BIOS
       LD      C,00h             ; track 0
       LD      D,01h             ; sector 1
       LD      HL,STARTCCP       ; destination address of CCP at $A400
LOAD_LOOP:
       PUSH    BC                ;
       PUSH    DE                ;
       PUSH    HL                ; save registers

       LD      C,D               ;
       CALL    EPROM_SETSECTOR   ; set sector in D

       POP     HL                ;
       PUSH    HL                ; refresh HL from stack, HL = destination in memory
       CALL    EPROM_SETDMA      ; set destination buffer
       CALL    LOAD_SECTOR       ; read sector with error handling

       POP     HL                ;
       LD      DE,0100h          ;
       ADD     HL,DE             ; increment pointer by sector size (256)

       POP     DE                ;
       POP     BC                ; pops registers from stack

       DEC     B                 ; decrement number of sectors to read
       JP      Z,END_LOAD        ; if Z=0 finished
       INC     D                 ; else increment sector
       LD      A,D               ;
       CP      10h               ; ??? compare with 16
       JP      LOAD_LOOP         ; loops

;
; Questo pezzo non è mai usato, probabilemente fa parte del vecchio
; codice che leggeva il boot sector su più tracce. Qui invece con
; i settori da 256 bytes, la traccia è sempre quella 0
;
L0135: LD      D,00h
       INC     C
       PUSH    BC
       PUSH    DE
       PUSH    HL
       CALL    EPROM_SETTRACK
       POP     HL
       POP     DE
       POP     BC
       JP      LOAD_LOOP

END_LOAD:
       NOP
       NOP
       NOP
       JP      END_LOAD1
       NOP
       NOP
       NOP

MESSAGE_MENU:
        DB 0Ch,09h,20h,09h,09h,"G E N E R A L   P R O C E S S O R",0Dh,0Ah
        DB 0Ah,0Ah,09h,09h,09h,"Drive disponibili:",0Dh,0Ah,0Ah
        DB "A",09h,"Rig. I",09h,09h
        DB "B",09h,"back-up",09h,09h
        DB "C",09h,"Rig. II",0Dh,0Ah,0Ah,0A0h

;
; loads a sector in memory and displays message
; if there is error
;
LOAD_SECTOR:
       CALL    EPROM_READSECTOR   ; reads the sector
       RET     Z                  ; if read is ok return
       NOP
       NOP
       NOP
       LD      HL,MESSAGE_ERROR   ; points to "Errore di caricamento DOS"
       CALL    EPROM2_PRINTSTRING       ; prints message
HANG:  JR      HANG               ; hangs the computer


;
; called after all sectors are loaded into memory
;

END_LOAD1:
       NOP
       NOP
       NOP
       NOP
       LD      HL,MESSAGE_MENU
       CALL    EPROM2_PRINTSTRING      ; prints message
       JP      STARTBIOS         ; jumps to bios at BA00

       ; unused bytes
       DB 01h,80h,0ACh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h

MESSAGE_ERROR:
        DB "Errore di caricamento DOS"
        DB 00h,00h,00h,00h,00h,00h,00h
