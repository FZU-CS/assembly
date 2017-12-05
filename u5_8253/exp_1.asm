; U5 8253

; 8253 Control Word: D7 D6 D5 D4 D3 D2 D1 D0
; D7: SC1, D6: SC0 [Select Counter Channel, 00=Counter0, 01=Counter1, 10=Counter2, 11=Useless]
; D5: RL1, D4: RL0 [Operation Type, 00=latch, 01=R/W lowB, 10=R/W highB, 11=R/W 16B, lowB first]
; D3: M2, D2: M1, D1: M0 [Mode Selection, 000=Mode0, 001=Mode1, X10=Mode2, X11=Mode3, 100=Mode4, 101=Mode5]
; D0: BCD, 0=Bin, 1=BCD.
; Example:
;   * "mov al, 00100111b"
;   * Counter0, R/W lowB, Mode3, BCD.

; Experiment requirements:
; * Using Counter t0 and t1 to generate a squarewave and a negative 
;   pulse, with T=1ms.
; * Clock: 1MHZ
; * CS: 280h-287h

t0 equ 280H        ; Counter0 port
t1 equ 281H        ; Counter1 port
t2 equ 282h        ; Counter2 port
ctl_53 equ 283h    ; The port of control register, address=283H

code segment
   assume cs:code
   
start:
                      ; Generating squarewave
   
                      ; (1) write control word of counter0:

   mov dx,ctl_53      ; dx(control register) = ctl_53(the port of control register)

   mov al,00100111b   ; t0 control word: 00 10 011 1 b, Counter0, R/W lowB, Mode3, BCD.
                      ; Note: the calculated initail value of counter0 < 256, using lowB

   out dx,al          ; write control word of counter0

                      ; (2) write initial value of counter0:

   mov dx,t0          ; dx(control register) = counter0 port
   
   mov al,10h         ; acquire the lowB of initial value
   out dx,al          ; write initial value of counter0, lowB
   

   
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