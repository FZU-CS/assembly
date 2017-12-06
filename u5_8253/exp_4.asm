; U5 8253
t0 equ 288h
t1 equ 289h
t2 equ 28Ah
ctl_53 equ 28Bh

code segment
   assume cs:code

start:
   mov dx,ctl_53
   mov al,01100101b ; counter1, R/W highB, Mode2, BCD
   out dx,al
   mov dx,t1
   mov al,40h       ; 40h
   out dx,al  
   
   mov dx,ctl_53
   mov al,10010101b ; counter2, R/W lowB, Mode2, BCD
   out dx,al
   mov dx,t2
   mov al,04h       ; 04h
   out dx,al
   
   mov ah,4ch
   int 21h
   code ends
end start
