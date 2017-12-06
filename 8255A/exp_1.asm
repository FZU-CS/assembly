pa equ 2a0h
pb equ 2a1h
pc equ 2a2h
ctl_55 equ 2a3h

data segment
   tab db 3fh,06h,5bh,4fh,66h,6dh,7dh,07h,7fh,6fh
   key db ?
data ends

code segment
   assume cs:code,ds:data

start:
   
   mov ax,data
   mov ds,ax
   mov cx,10
   
   mov dx,ctl_55
   mov al,10010001b
   out dx,al
   
ag1:
   call crt_8
   
   mov dx,pc
   in al,dx
   test al,00000001b
   jz ag1
   
   mov dx,pa
   in al,dx
   mov key,al
   
ag2:
   call crt_8
   
   mov dx,pc
   in al,dx
   test al,00000001b
   jnz ag2
   loop ag1
   mov ah,4ch
   int 21h
   
crt_8 proc
   push cx
   
   mov al,key
   mov cl,04h
   ror al,cl
   
   and al,0fh
   
   mov bx,offset tab
   XLAT
   
   mov dx,pb
   out dx,al
   
   mov dx,pc
   mov al,10000000b
   out dx,al
   
   mov dx,pc
   mov al,0
   out dx,al
   
   
   mov al,key
   and al,0fh
   mov bx,offset tab
   XLAT
   
   mov dx,pb
   out dx,al
   
   mov dx,pc
   mov al,01000000b
   out dx,al
   
   mov dx,pc
   mov al,0
   out dx,al
   pop cx
   ret
crt_8 endp

code ends
end start
