base   equ 280h;
t0     equ base+0;
t1     equ base+1;
t2     equ base+2;
ctl_53 equ base+3;
 
 
code segment
assume cs:code
start:
 
       mov dx,ctl_53;
       mov al,00110110b;
       out dx,al;
       mov dx,t0;
       mov ax,1000;
       out dx,al;
       mov al,ah;
       out dx,al;
       
       mov dx,ctl_53;
       mov al,01110100b;
       out dx,al;
       mov dx,t1;
       mov ax,1000;
       out dx,al;
       mov al,ah;
       out dx,al;       
       
       mov ax,4c00h;
       int 21h;
       
code ends;
end start;