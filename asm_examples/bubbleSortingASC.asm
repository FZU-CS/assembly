title bubbleSortingASC
 include irvine32.inc

 .data
  tab db 12,9,4,5,7,3,1,8 ; $ = tab+8
  count EQU ($-tab)       ; count = 8
  dab db count dup(?)     ; "db count dup(?)" decalres 8 uninitialized bytes in memory

 .code
 main proc
  mov cx,count            ; cx = count = 8
  mov si,0                ; si = 0
  
                          ; print the original array
  put1:
    movsx eax,tab[si]     ; eax = tab[si](a signed number, so leverage movsx)
    call writeint         ; write eax to the console
    mov al,32             ; TBD: why make al(lower 8b of eax) equal to 32?
    call writechar        ; write al to the console
    inc si                ; si += 1
    loop put1             ; loop back, cx -= 1

  mov al,10 
  call writechar 
      
                          ; give values to dab array
  mov cx,count
  mov si,0
  
  s:
    mov bl,tab[si]
    mov dab[si],bl
    inc si
    loop s

                          ; bubble sorting, ascending
  mov cx,count            ; cx = count
  dec cx                  ; cx -= 1
  
  lop1:
      mov di,cx           ; di = cx
      mov si,0            ; si = 0
  
  lop2:
    mov al,dab[si]        ; al = array[i]
    cmp al,dab[si+1]      ; compare array[i] and array[i+1]
    jb go_on              ; if array[i] < array[i+1]: move to go_on

                          ; else if array[i] > array[i+1]:
    xchg al,dab[si+1]     ;   exchange al(val=old_array[i]) and array[i+1]
    mov dab[si],al        ;   array[i] = al(val=old_array[i+1])
  
  go_on:
    add si,1              ; si += 1
    loop lop2             ; move to lop2
      
    mov cx,di             ; cx = di
    loop lop1             ; move to lop1


                          ; print to CRT
  mov cx,count
  mov si,0

  put2:
    movsx eax,dab[si]
    call writeint
    mov al,32
    call writechar
    inc si
    loop put2
  
  exit
 
 main endp
 end main