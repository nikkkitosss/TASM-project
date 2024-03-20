.model small
.stack 100h
.data
    countOne db ?
    countZero db ?
    nln db 0ah,0dh,'$'
.code
     main proc
     
     mov ax,@data
     mov ds,ax
     
     mov countOne,30h
     mov countZero,30h
     
     mov ah,
     int 21h
     mov bl,al
     
     
     cmp bl,65
     jge hex
     
     sub bl,48
     jmp doit
     
     hex:
     sub bl,55
     
     doit:
     mov ah,9
     lea dx, nln
     int 21h
     
     mov cl,0
             
     rotate:        
     rol bl,1
     
     jnc zero
     jc one
     
     zero:
     inc countZero
     
     cmp cl,4
     jl do1
     
     mov ah,2
     mov dl,'0'
     int 21h
     
     do1:
     jmp looper
     
     one:
     inc countOne
     
     cmp cl,4
     
     jl do2
     mov ah,2
     mov dl,'1'
     int 21h
     do2:
     jmp looper
     
     
     looper:
     inc cl
     cmp cl,8
     jl rotate
     
     
     finish:
     mov ah,9
     lea dx,nln
     int 21h


    main endp
end main