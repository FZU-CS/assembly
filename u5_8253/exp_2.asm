; U5 8253
t0 equ 290H
t1 equ 291H
t2 equ 292h
ctl_53 equ 293h

code segment
   assume cs:code
   
start:
   mov dx,ctl_53
   mov al,10010000b ; counter2, W/R lowB, Mode0, BIN
   out dx,al
   mov dx,t2
   mov al,09h       ; initial value
   out dx,al
   
   mov ah,4ch
   int 21h
   code ends
end start