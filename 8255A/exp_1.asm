pa equ 2a0h
pb equ 2a1h
pc equ 2a2h
ctl_55 equ 2a3h

data segment
   tab db 3fh,06h,5bh,4fh,66h,6dh,7dh,07h,7fh,6fh
   key db ?          ; initialization
data ends

code segment
   assume cs:code,ds:data

start:
   mov ax,data       ; load data segment
   mov ds,ax
   mov cx,10

                     ; Initial 8255
   mov dx,ctl_55
   mov al,10010001b  ; A: Mode0, Input, C(A) I/O Output; B: Mode0, Output, C(B) I/O Input
   out dx,al
   
                     ; pulse: 0-1-0-1-...

                     ; read pulse
ag1:
   call crt_8        ; call function crt_8
                     
   mov dx,pc         ; read PC0(experiment requirement)
   in al,dx          

   test al,00000001b 
   jz ag1            ; if read 1, continue, else loop back and wait for 1
   
   mov dx,pa         ; read the key value from PA0
   in al,dx
   mov key,al        ; record the key value in 'key'

ag2:
   call crt_8        ; 
   
   mov dx,pc         ; read PC0
   in al,dx          
                     ; end of reading pulse

   test al,00000001b 
   jnz ag2           ; if read 0, continue, else loop back and wait for 0
   
   loop ag1          ; loop 

   mov ah,4ch        ; back to OS
   int 21h
   
crt_8 proc
   push cx           ; push the value of cx to stack
   
   mov al,key        ; show highB
   mov cl,04h        ; 
   ror al,cl         ; bitwise rotation
   
   and al,0fh        ; ignore highest 4b

                     ; lookup the table
   mov bx,offset tab ; bx = offset of tab
   XLAT              ; (al) = ((bx)+(al))
   
   mov dx,pb         ; output highb segment code
   out dx,al
   
   mov dx,pc         ; output highb bit code
   mov al,10000000b  
   out dx,al
   
   mov dx,pc         ; close the light
   mov al,0
   out dx,al
                     
   mov al,key        ; show lowB
   and al,0fh
   mov bx,offset tab
   XLAT
                     
   mov dx,pb         ; output lowb segment code
   out dx,al
   
   mov dx,pc         ; output lowb bit code
   mov al,01000000b
   out dx,al
   
   mov dx,pc         ; close the light
   mov al,0
   out dx,al

   pop cx            ; recover
   ret
crt_8 endp

code ends
end start
