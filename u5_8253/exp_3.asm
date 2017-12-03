; U5 8253
t0 equ 298h
t1 equ 299h
t2 equ 29Ah
ctl_53 equ 29Bh

code segment
   assume cs:code
start:
   mov dx,ctl_53
   mov al,00100111b
   out dx,al
   mov dx,t0
   mov al,10h
   out dx,al

   mov dx,ctl_53
   mov al,01100111b
   out dx,al
   mov dx,t1
   mov al,10h
   out dx,al
   
   mov ah,4ch
   int 21h
   code ends
end start