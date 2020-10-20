





ORG $0100

CASPORT EQU $77         
CASMASK EQU $2          
VIDEO   EQU $C000       

TESTCAS:
    LD   C,CASPORT
    LD   HL,VIDEO

READBIT:
    IN   A,(C)         
    AND  CASMASK       
    RLA                
    RLA                
    RLA                
    RLA                
    LD   (HL),A        
    INC  HL            
    LD   A,H           
    AND  $C3           
    LD   H,A           
    JR   READBIT       




