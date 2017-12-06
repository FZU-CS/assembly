t0 equ 280h
t1 equ 281h
t2 equ 282h
ctl_53 equ 283h
pa equ 290h
pb equ 291h
pc equ 292h
ctl_55 equ 293h

data segment
   tab db 0,01h,03h,07h,0fh,1fh,3fh,7fh,0ffh,7eh,3ch,18h
   count equ $-tab
data ends
code segment
   assume cs:code,ds:data

start:
                     ; load data segment
   mov ax,data
   mov ds,ax

                     ; 8253 1s pulse
   mov dx,ctl_53
   mov al,00100111b  ; 00, Counter0; 10, R/W highB; 011, Mode3; BCD
   out dx,al
   mov dx,t0
   mov al,10h
   out dx,al

   mov dx,ctl_53
   mov al,01100111b  ; 01, Counter1; 10 R/W highB; 011, Mode3; BCD
   out dx,al
   mov dx,t1
   mov al,10h
   out dx,al
   
                     ; Initail 8255
   mov dx,ctl_55
   mov al,10001000b  ; A: 00:Mode0; 0:Output; 1:C(A) I/O Input; 
                     ; B: 0:Mode0; 0:Output; 0:C(B) I/O Output.
   out dx,al

ag3:                 ; setup loop
   mov cx,count
   xor si,si

ag:
   mov dx,pc         ; read PC7 pulse
   in al,dx          

   test al,10000000b ; if the highest bit is not 1, go ag
   jz ag
   
   mov al,tab[si]    ; send tab to PA to show the LED light
   mov dx,pa
   out dx,al

ag2:
   mov dx,pc         ; read PC7
   in al,dx

   test al,10000000b ; if the highest bit is not 1, go ag2
   jnz ag2
   
   inc si            ; si--
   loop ag
   jmp ag3
   
   mov ah,4ch
   int 21h
   code ends
end start
