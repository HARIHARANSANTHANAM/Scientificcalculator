include emu8086.inc     
.model small
.stack
.data
message db "SCIENTIFIC CALCULATOR $"
message1 db "1.SIN(x) $"
message2 db "2.POWER $"
message3 db "3.DECTOBIN $"
message4 db "4.SQUAREROOT $" 
message5 db "5.FACTORIAL $" 
message6 db "6.EXIT $" 
fact   DB  'Enter the Factorial number: ', 0
power db "POWER IS:$"
squareroot db "ENTER THE SQUAREROOTNO:$" 
choice db "ENTER THE CHOICE:$"
squareprint db "SQUARE ROOT VALUE IS $"
number dw  ? 
sqrt db ?   
temp db ?                
 BASE    DB      ?
 POW     DW      ?
decimal db "ENTER THE VALUE:$"   
binary db "BINARY VALUE IS $"
bin db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0    
continue db "DO WANT TO CONTINUE,YES PRESS 1 ELSE PRESS 0 $"
.code

main proc far
mov ax,@data
mov ds,ax

while: 
CALL CLEAR_SCREEN
 ;CLEAR THE SCREEN
  MOV AH,06H
  MOV BH,8BH
  MOV CX,0000H
  MOV DX,184FH
  INT 10H

print 'SCIENTIFIC CALCULATOR' 

MOV ah,02h
mov dl,010
int 21h  
MOV ah,02h
mov dl,013
int 21h 
mov ah,09h
mov dx,offset message1   ;print the message
int 21h

MOV ah,02h
mov dl,010
int 21h 
MOV ah,02h
mov dl,013
int 21h 
mov ah,09h
mov dx,offset message2   ;print the message
int 21h

MOV ah,02h
mov dl,010
int 21h 
MOV ah,02h
mov dl,013
int 21h 
mov ah,09h
mov dx,offset message3   ;print the message
int 21h

MOV ah,02h
mov dl,010
int 21h 
MOV ah,02h
mov dl,013
int 21h 
mov ah,09h
mov dx,offset message4   ;print the message
int 21h  


MOV ah,02h
mov dl,010
int 21h 
MOV ah,02h
mov dl,013
int 21h 
mov ah,09h
mov dx,offset message5   ;print the message
int 21h



MOV ah,02h
mov dl,010
int 21h 
MOV ah,02h
mov dl,013
int 21h 
mov ah,09h
mov dx,offset message6   ;print the message
int 21h
 
 MOV ah,02h
mov dl,010
int 21h   
MOV ah,02h
mov dl,013
int 21h 
mov ah,09h
mov dx,offset choice   ;print the message
int 21h  
mov ah,01
int 21h
        


cmp al,31h
je execute1
jne case2
execute1:  
jmp cont


case2:
cmp al,32h
je execute2
jne case3
execute2:

ENTER_BASE:

        
        MOV ah,02h
        mov dl,010
        int 21h
        mov ah,02h
        mov dl,013
        int 21h
        PRINT " ENTER THE BASE : "
        
        MOV BH,00
        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV BL,AL

        MOV BASE,AL

ENTER_POWER:
        MOV ah,02h
        mov dl,010
        int 21h
        mov ah,02h
        mov dl,013
        int 21h  
        PRINT " ENTER THE POWER : "

        CALL SCAN_NUM
        
        
        DEC CX
        MOV CH,00
        MOV AX,00
        MOV AL,BASE
LBL1:

        MUL BX
        LOOP LBL1

        mov POW,ax
        
        MOV ah,02h
        mov dl,010
        int 21h
        mov ah,02h
        mov dl,013
        int 21h                
        mov ah,09h
       mov dx,offset power   ;print the message
       int 21h  
        MOV AX,POW
       call print_num
jmp cont


case3:
cmp al,33h
je execute3
jne case4
execute3:
mov ah,09h
mov dx,offset decimal   ;print the message
int 21h

CALL scan_num 
mov ax,cx 
mov bl,2
lea si,bin
dectobin:
     cmp al,2h
     jc  exit2
     mov ah,00
     div bl 
     mov [si],ah
     inc si   
     jmp dectobin
exit2:
mov [si],al 
mov cx,16  
lea si,bin+15

mov ah,02h
mov dl,010
int 21h  
mov ah,09h
mov dx,offset binary   ;print the message
int 21h
printbin: 
mov ah,02h
     mov dl,[si]
     add dl,30h
     int 21h
     dec si 
loop printbin 
mov ax,0 
jmp cont




case4:
cmp al,34h
je execute4
jne case5 
execute4:
MOV ah,02h
mov dl,010
int 21h  
 mov ah,09h
mov dx,offset squareroot   ;print the message
int 21h

mov ah,00
CALL scan_num 
mov number,cx
mov bl,2
mov ax,cx
div bl 
mov sqrt,al
mov bl,sqrt
mov cl,0  
mov temp,cl
mov cl,temp 
mov bh,00
squareroot1:
   mov bl,sqrt
   mov cl,temp
   cmp bx,cx         ;sqrt!=temp
   je exit1
   mov cx,0000h
   mov temp,bl       ;temp=sqrt
   
   mov cl,temp
   mov ax,number
   mov ah,00
   div cl             ;number/temp
   add al,temp        ;number/temp+temp
   mov bl,2
   mov ah,00
   div bl             ;(number/temp+temp)/2
   mov sqrt,al 
   mov bl,sqrt
jmp squareroot1 
exit1:
MOV ah,02h
mov dl,010
int 21h 
mov ah,0
mov al,temp  

mov ah,09h
mov dx,offset squareprint   ;print the message
int 21h

mov ah,00
mov al,temp
call print_num    ;print the squarerrot    
jmp cont    




case5:
cmp al,35h
je execute5
jne case6
execute5:
 LEA    SI, fact       ; ask for the number
CALL   print_string   ;
CALL   scan_num       ; get number in CX.

MOV    AX, CX         ; copy the number to AX.

; print the following string:

exit: 
mov bl,al
sub bl,1      
    factorial:
         cmp bl,00
         je exit3
         mul bl
         dec bl
    jmp factorial
    exit3: 
CALL   pthis
DB  13, 10, 'Factorial is: ', 0

CALL   print_num      ; print number in AX.
                 ; return to operating system. 
jmp cont  

case6:
cmp al,36h
JE  fullexit  

cont:
MOV ah,02h
mov dl,010
int 21h 
MOV ah,02h
mov dl,013
int 21h
mov ah,09h
mov dx,offset continue 
int 21h  ;print the message
mov ah,01
int 21h
cmp al,31h
je while
jmp fullexit


fullexit:
DEFINE_SCAN_NUM   
DEFINE_PRINT_NUM 
DEFINE_PRINT_NUM_UNS  
DEFINE_PRINT_STRING
DEFINE_PTHIS
DEFINE_CLEAR_SCREEN
