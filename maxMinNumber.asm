title maxMinNumber
 include irvine32.inc          ; Assembly lib

 .data                         ; Data Segment
  t0 db 12,13,10,37,92,94,10   ; 12 -> t0, 13 -> t0+1, 10 -> t0+2 ...

  count EQU ($-t0)             ; $ means Program Counter, its original value is 0, current $=t0+3
                               ; EQU means "equal to", make count equal to value ($-t0)=3

  max db -128                  ; -128 -> max, db means 8b
  min db 127                   ; 127 -> min, db means 8b

 .code                         ; Code Segment
 main proc                     ; Main Procedure
  mov cx,count                 ; Make CX(16b Operator) equal to the value of count

                               ; SI stores the index of data array
  mov si,0                     ; Make SI(16b Operator) equal to 0

                               ; AX stores the MAX number, and BX stores the MIN number
  xor ax,ax                    ; Make AX(16b Operator) and CF(Carry Flag) equal to 0
  xor bx,bx                    ; Make BX(16b Operator) and CF(Carry Flag) equal to 0
  mov al,max                   ; Make al = max, al(ah) is the lower(higher) 8b of AX
  mov bl,min                   ; Make bl = min, bl(bh) is the lower(higher) 8b of BX


                               ; Main loop of this procedure
                               ; At the beginning, the procedure carries out cx = cx-1,
                               ; then it judges if the cx > 0, if not ends up this loop

  again: cmp t0[si],al         ; Loop again point, Compare the value stored in (t0+si) and al
	       jg max_number         ; if t0[si] > al (jump great transition): Move to max_number
	       jl next               ; if t0[si] < al (jump less transition): Move to next

                               ; if t0[si] > al
  max_number: mov al,t0[si]    ; max_number: 1.Make al = t0[si];
	            mov max,al       ;             2.Make max = al;
	            jmp next         ;             3.Move to next

  next: cmp t0[si],bl          ; next: 1.Compare t0[si] and bl
        jl min_number          ;       2.if t0[si] < bl, move to min_number
        jg final               ;       3.if t0[si] > bl, move to final

                               ; if t0[si] < bl
  min_number: mov bl,t0[si]    ; min_number: 1.Make bl = t0[si];
	            mov min,bl       ;             2.Make min = bl;
	            jmp final        ;             3.Move to final

  final: inc si                ; final: 1.add 1 to si
         loop again            ;        2.loop again, move to loop again point
  exit                         ; exit the loop

 main endp                     ; End of Procedure
 end main