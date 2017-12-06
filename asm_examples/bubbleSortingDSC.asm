title bubbleSortingDSC
 include irvine32.inc
 
 .data
  tab db 12,9,4,5,7,3,1,8
  count EQU ($-tab)
  dab db count dup(?)
 
 .code
 main proc
     
  mov cx,count
  mov si,0
  
  put1:
    movsx eax,tab[si]
    call writeint
    mov al,32
    call writechar
    inc si
    loop put1
    mov al,10
    call writechar

  mov cx,count
  mov si,0
  
  s:
    mov bl,tab[si]
    mov dab[si],bl
    inc si
    loop s
      
  mov cx,count
  dec cx  
    
  lop1:  
    mov di,cx 
    mov si,0   
    
  lop2:    
    mov al,dab[si]
    cmp al,dab[si+1]
    jg go_on 
    xchg al,dab[si+1]
    mov dab[si],al   
  
  go_on:  
    add si,1 
    loop lop2   
      
    mov cx,di
    loop lop1
  
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
