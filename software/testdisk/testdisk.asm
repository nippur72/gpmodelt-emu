

WRSTG EQU $E3FA    ; prints string in HL until char with 7 bit on

ORG $0100

START:
    LD HL, MESSAGE
    CALL WRSTG
    HALT

MESSAGE:
    defb "QUESTO DISCO FUNZIONA"
    defb 255



