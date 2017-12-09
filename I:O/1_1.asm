port1 equ 2A0h
port2 equ 2A8h
code segment
assume cs:code
start:
  L1:mov dx,port1
     in al,dx
     call delay
     mov dx,port2
     out dx,al
     call delay
     jmp L1
     mov ah,4ch
     int 21h
  delay proc 
     mov cx,0
     wat2:push cx
          mov cx,200h
     wat1:loop wat1
          pop cx
          loop wat2
  ret 
  delay endp 
  code ends
end start