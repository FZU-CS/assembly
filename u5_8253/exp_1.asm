; U5 8253
t0 equ 280H        ; Counter t0, address=280H
t1 equ 281H        ; Counter t1, address=281H
t2 equ 282h        ; Counter t2, address=282H
ctl_53 equ 283h    ; The port of control register, address=283H

code segment
   assume cs:code
   
start:
                      ; dx: control register
   mov dx,ctl_53      ; dx = ctl_53(the port of control register)
   mov al,00100111b   ; al = 00100111b(the value of t0 control word)
   out dx,al          ; write the value of al to port dx
   mov dx,t0          ; dx = t0(the port of t0)
   mov al,10h         ; al = 10h
   out dx,al          ; write the value of al to port dx
   
   mov dx,ctl_53
   mov al,01100101b
   out dx,al
   mov dx,t1
   mov al,10h
   out dx,al

   mov ah,4ch         ; reach the end of procedure
   int 21h            ; return to operating system

   code ends
end start