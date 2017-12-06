pa equ 290h
pb equ 291h
pc equ 292h
ctl_55 equ 293h
t0 equ 280h
t1 equ 281h
t2 equ 282h
ctl_53 equ 283h

data segment
   tab db 3fh,06h,5bh,4fh,66h,6dh,7dh,07h,7fh,6fh
   second db 0
data ends

code segment
   assume cs:code,ds:data

start:
   
   mov ax,data
   mov ds,ax
   
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
   
   mov dx,ctl_55
   mov al,10001000b
   out dx,al

ag:
   call led_8
   
   mov dx,pc
   in al,dx
   test al,10000000b
   jz ag
   
   mov al,second
   add al,1
   DAA
   mov second,al
   
   .IF second==60h
   mov second,0
   .endif
ag1:
   call led_8
   
   mov dx,pc   
   in al,dx
   test al,10000000b
   jnz ag1
   jmp ag
   mov ah,4ch
   int 21h
   
led_8 proc
   
   mov cl,04h
   mov al,second
   ror al,cl
   and al,0fh
   
   mov bx,offset tab
   XLAT
   
   mov dx,pa
   out dx,al
   
   mov dx,pb
   mov al,10000000b
   out dx,al
   
   mov dx,pb
   mov al,0
   out dx,al
   
   mov al,second
   and al,0fh
   mov bx,offset tab
   XLAT
   
   mov dx,pa
   out dx,al
   
   mov dx,pb
   mov al,01000000b
   out dx,al
   
   mov dx,pb
   mov al,0 
   out dx,al
   ret
led_8 endp

code ends
end start   
