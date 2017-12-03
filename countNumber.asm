title countNumber
 include irvine32.inc
 
 .data
  
  t0 db 12,13,10,-5,-85,37,92,-25,94,10,-36
  count EQU ($-t0)
  
  p_number db 0 ; p_number stores the total number of positive number
  n_number db 0 ; n_number stores the total number of negative number
 
 .code
 main proc

  mov cx,count
  mov si,0

  again: cmp t0[si],0
	       jg p_number_add ; t0[si] > 0
	       jl n_number_add ; t0[si] < 0
	       jz next         ; t0[si] = 0
	       loop again
  
  p_number_add: inc p_number
	              jmp next
  
  n_number_add: inc n_number
	              jmp next
  
  next:	inc si
	      loop again
  exit

 main endp
 end main