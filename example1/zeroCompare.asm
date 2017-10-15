include irvine32.inc

.data
	DAT db 12h,12h,34h,56h,78h,9Ah,0BCh,0DEh,00h,5 dup(23h),5 dup(89h)
	len db $-DAT
	t0 db 0
	t1 db 0

.code

	main proc

		; initial these variables
		xor esi,esi;
		xor ecx,ecx;
		xor eax,eax;
		mov cl,len;

		; major loop
		rep1:
			cmp DAT[si],00h ; compare with 00h
			jz  ok1         ; if the current number = +0, goto condition1

			cmp DAT[si],80h ; compare with 80h 
			jz  ok1         ; if the current number = -0, goto condition1
			js  ok2         ; if the current number < 0, goto condition2
			jmp ok3         ; if the current number > 0, goto condition3

			ok2:inc t0      ; condition2: add 1 to t0
			jmp ok1         ; then goto condition1

			ok3:inc t1      ; condition3: add 1 to t1 

			ok1:inc si      ; condition1: add 1 to si 
		loop rep1

		; print the total number
		mov al,t0		
		call writeint
		mov al,t1
		call writeint
		exit
	main endp

end main