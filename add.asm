 title add
 include irvine32.inc
 .data
  t0 db 13h
  t1 db 56h
  sum dw 0
 .code 
 main proc
  xor ax,ax  ;clean the ax
  mov al,t0
  add sum,ax
  xor ax,ax
  mov al,t1
  add sum,ax
  exit
  main endp
  end main
