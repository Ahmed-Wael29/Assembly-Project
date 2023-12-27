.MODEL large
.DATA
MENU DB '*****************MENU*********************','$'
MENU1 DB 'PRESS 1 FOR LAPTOPS','$'
MENU2 DB 'PRESS 2 FOR MOBILE PHONES','$'
MENU3 DB 'PRESS 3 FOR APPLE WATCHES','$'
MENU4 DB 'PRESS 4 TO SHOW YOUR BILL','$'
MENU5 DB 'PRESS 5 TO DELETE YOUR SHOPPING BAG','$'
MENU6 DB 'PRESS 6 TO EXIT','$'
MSG1 DB 'YOU HAVE REACHED THE MAXIMUM CAPCITY','$'
MSG2 DB 'WRONG INPUT','$'
MSG3 DB 'MOBILE PHONES','$'
MSG4 DB 'LAPTOP','$'
MSG5 DB 'YOUR BILL','$'
MSG6 DB 'SORRY THERE IS NO STOCK','$'
MSG7 DB 'THE TOTAL PRICE=$'
MSG8 DB 'NO. OF PRODUCTS=$'
MSG9 DB 'NO. OF LAPTOPS=$''
MSG10 DB 'NO. OF APPLE WATCHES=$'
MSG11 DB 'NO. OF MOBILE PHONES=$'
MSG12 DB '***BILL DELETED SUCCEFULLY***$'
AMOUNT DW 0
COUNT DW  '0'
AM1 DW ?
AM2 DW ?
AM3 DW ?
M DW '0'
L DW '0'
A DW '0'
.CODE    
MAIN PROC FAR
.STARTUP
START:   
;Menu
MOV DX,10
MOV AH,2
INT 21H
MOV DX,13
MOV AH,2
INT 21H
LEA DX,MENU
CALL PRINT
LEA DX,MENU1
CALL PRINT
LEA DX,MENU2
CALL PRINT
LEA DX,MENU3
CALL PRINT
LEA DX,MENU4
CALL PRINT
LEA DX,MENU5
CALL PRINT
LEA DX,MENU6
CALL PRINT

CALL READ
MOV BL,AL
CALL PRINT
;COMPARE
MOV AL,BL
CMP AL,'1'
JE MOBILE
CMP AL,'2'
JE APLE
CMP AL,'3'
JE LAP
CMP AL,'4'
JE BILL
CMP AL,'5'
JE DEL
CMP AL,'6'
JE EXIT

LEA DX,MSG2
CALL PRINT
JMP START

MOBILE:
CALL MOB

APLE:
CALL WATCH

BILL:
CALL BILL1

DEL:
CALL DELETE

LAP:
CALL LAPTOP




EXIT:
.EXIT
MAIN ENDP
MOB PROC NEAR
CMP COUNT,'8'
JLE MOB1
LEA DX,MSG1
MOV AH,9
INT 21H
JMP START
JMP EXIT

MOB1:
MOV AX,900
ADD AMOUNT,AX
MOV DX,0
MOV BX,10
MOV CX,0
D:
DIV BX
PUSH DX
MOV DX,0
MOV AH,0
INC CX
CMP AX,0
JNE D   
C:
POP DX
ADD DX,48
MOV AH,2
INT 21H
LOOP C
INC COUNT
INC M
JMP START
JMP EXIT
MOB ENDP

WATCH PROC NEAR
CMP COUNT,'8'
JLE WATCH1
LEA DX,MSG1
MOV AH,9
INT 21H
JMP START
JMP EXIT

WATCH1:
MOV AX,500
ADD AMOUNT,AX
MOV DX,0
MOV BX,10
MOV CX,0
W:
DIV BX
PUSH DX
MOV DX,0
MOV AH,0
INC CX
CMP AX,0
JNE W
H:
POP DX
ADD DX,48
MOV AH,2
INT 21H
LOOP H
INC COUNT
INC A
JMP START
JMP EXIT
WATCH ENDP

LAPTOP PROC NEAR
CMP COUNT,'8'
JLE LAB1
LEA DX,MSG1
MOV AH,9
INT 21H
JMP START
JMP EXIT

LAB1:
MOV AX,200
ADD AMOUNT,AX
MOV DX,0
MOV BX,10
MOV CX,0
LO:
DIV BX
PUSH DX
MOV DX,0
MOV AH,0
INC CX
CMP AX,0
JNE LO
T:
POP DX
ADD DX,48
MOV AH,2
INT 21H
LOOP T
INC COUNT
INC L
JMP START
JMP EXIT
LAPTOP ENDP

BILL1 PROC NEAR
LEA DX,MSG7
MOV AH,9
INT 21H
MOV AX,AMOUNT
MOV DX,0
MOV BX,10
MOV CX,0
TOTAL:
DIV BX
PUSH DX
MOV DX,0
INC CX
CMP AX,0
JNE TOTAL  
TOTAL1:
POP DX
ADD DX,48
MOV AH,2
INT 21H
LOOP TOTAL1
MOV DX,10
MOV AH,2
INT 21H
MOV DX,13
MOV AH,2
INT 21H

LEA DX,MSG8
MOV AH,9
INT 21H
MOV DX,COUNT
MOV AH,2
INT 21H
MOV DX,10
MOV AH,2
INT 21H
MOV DX,13
MOV AH,2
INT 21H

LEA DX,MSG9
MOV AH,9
INT 21H
MOV DX,M
MOV AH,2
INT 21H
MOV DX,10
MOV AH,2
INT 21H
MOV DX,13
MOV AH,2
INT 21H

LEA DX,MSG10
MOV AH,9
INT 21H
MOV DX,L
MOV AH,2
INT 21H
MOV DX,10
MOV AH,2
INT 21H
MOV DX,13
MOV AH,2
INT 21H

LEA DX,MSG11
MOV AH,9
INT 21H
MOV DX,A
MOV AH,2
INT 21H

JMP START
JMP EXIT
BILL1 ENDP

DELETE PROC NEAR
MOV M,'0'
MOV L,'0'
MOV A,'0'
MOV AMOUNT,0
MOV COUNT,'0'
LEA DX,MSG12
CALL PRINT

JMP START
JMP EXIT
DELETE ENDP
PRINT PROC NEAR
MOV AH,9
INT 21H
MOV DX,10
MOV AH,2
INT 21H
MOV DX,13
MOV AH,2
INT 21H
RET
PRINT ENDP
READ PROC NEAR
MOV AH,1
INT 21h
RET
READ ENDP
END MAIN