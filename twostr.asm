.model small
.stack 100h

.data
    string1 db 'a1 $'  
    string2 db 'a1 $'  ;
    msg1 db 'Strings are equal.$'
    msg2 db 'Strings are not equal.$'

.code
main proc
    mov ax, @data
    mov ds, ax

    lea si, string1  ; Load address 
    lea di, string2  ; Load address 

compare_loop:
    mov al, [si]    ; Load character 
    mov bl, [di]    ; Load characterm
    cmp al, bl      ; Compare characters
    jne not_equal   
    cmp al, '$'     ; Check if end of string is reached
    je end_compare  ; If end of string is reached, strings are equal
    inc si          ; Move to next character in string1
    inc di          ; Move to next character in string2
    jmp compare_loop 

not_equal:
    mov ah, 09h     ; Print string
    lea dx, msg2    
    int 21h         
    jmp end_program

end_compare:
    mov ah, 09h     ; Print string
    lea dx, msg1    
    int 21h         

end_program:
    mov ah, 4Ch     ; Exit program
    int 21h
main endp
end main
