title addTwoNumber
 include irvine32.inc ; Assembly lib

 .data                ; Data Segment
  t0 db 13h           ; 13h -> t0, db means 8b
  t1 db 56h           ; 56h -> t1
  sum dw 0            ; 0 -> sum, dw means 16b
 
 .code                ; Code Segment
 main proc            ; Main Procedure
 
  xor ax,ax           ; Make AX(16b Operator) and CF(Carry Flag) equal to 0
  mov al,t0           ; Make al = t0, al(ah) is the lower(higher) 8b of AX
  add sum,ax          ; Add the value of ax(t0) to sum
 
  xor ax,ax           ; Make AX(16b Operator) and CF(Carry Flag) equal to 0
  mov al,t1           ; Make al = t1
  add sum,ax          ; Add the value of ax(t1) to sum
 
  exit                ; Exit the operations
 
 main endp            ; 
  end main            ; End of Main Procedure