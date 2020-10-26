

; standard definitions
include "../../docs/defs.asm"

ORG $0100

START:
    LD HL, MESSAGE
    CALL WRSTG
    HALT

MESSAGE:
    defb 12, "QUESTO DISCO FUNZIONA !", $A0

    db $00
    db $00





