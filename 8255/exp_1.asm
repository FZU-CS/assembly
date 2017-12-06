pa equ 288h
pb equ 289h
pc equ 28Ah
ctl_55 equ 28Bh

code segment
   assume cs:code

start:
   mov cx,10         ; for 10 times

                     ; 8255 Initialization
   mov dx,ctl_55     ; register indirect addressing
   mov al,10001011b  ; control word, A: Mode0, Output, C(A) I/O Input;
                     ;               B: Mode0, Input, C(B) I/O Input
   out dx,al         ; write control word

ag:
   mov dx,pb         ; read PB0
   in al,dx          ; 

   test al,00000001b ; if the lowest bit is not 1, go ag
   jz ag

   mov dx,pc         ; read PC0
   in al,dx

   mov dx,pa         ; send to PA0 to show the LED light
   out dx,al

ag2:
   mov dx,pb         ; read PB0
   in al,dx

   test al,00000001b ; if the value of al is not 0, loop back
   jnz ag2

   loop ag           ; go back to ag
   
   mov ah,4ch
   int 21h
   code ends
end start