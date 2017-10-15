include irvine32.inc

.data
	DAT dw 12h,12h,34h,56h,78h,9Ah,0BCh,0DEh,00h,5 dup(23h),5 dup(89h)
	len dw ($-DAT)/2
	Max dw 00h
	Min dw 0ffh

.code

	main proc

		;//---init
		xor eax,eax;
		;mov ebx,ebx;
		xor ecx,ecx;
		mov cx,len
		xor esi,esi;

		;//--cal

		rep1:
			mov ax,Max
			cmp DAT[si],ax
			jb ok1
			mov ax,DAT[si];
			mov Max,ax
			ok1:

			mov ax,Min
			cmp DAT[si],ax
			ja ok2
			mov ax,DAT[si];
			mov Min,ax;

			ok2:

			add si,02h
		loop rep1

		;//---print
		mov ax,Max
		call writehex
		mov ax,Min
		call writehex

		exit
	main endp

end main