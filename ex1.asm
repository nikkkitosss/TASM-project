.model small
.stack 100h

.data
filename    db "V3TEST1.IN", 0
mes db "Success $"
mesBad db "File error $"
handle dw 0
oneChar db 0

keys db 5000*16 dup(0)
keyInd dw 0
isWord db 1
values db 5000*16 dup(0)
valInd dw 0



.code
main proc
    mov ax, @data
    mov ds, ax

mov dx, offset fileName; Address filename with ds:dx 
mov ah, 03Dh ;DOS Open-File function number 
mov  al, 0;  0 = Read-only access 
int 21h; Call DOS to open file 

jc error ;Call routine to handle errors
    jmp cont
 error:
     mov ah, 09h
 mov dx, offset mesBad
int 21h
jmp ending



cont:
mov [handle] , ax ; Save file handle(adress) for later

;read file and put characters into buffer
read_next:
    mov ah, 3Fh
    mov bx, [handle]  ; file handle
    mov cx, 1   ; 1 byte to read
    mov dx, offset oneChar   ; read to ds:dx 
    int 21h   ;  ax = number of bytes read
    ; do something with [oneChar]

    ;save ax
    push ax
    push bx ; 
    push cx ; 
    push dx ; not necessary?
    call procChar
;return ax vaulue
pop dx
pop cx
pop bx
pop ax ; for reading 
    or ax,ax  ;checking 
    jnz read_next
;clean values last number бо остання цифра в key записуеться двічі бо oneChar залишає останній символ в собі 
        mov si, offset values
        mov bx, valInd
        dec bx
        add si, bx
        mov al, 0
        mov [si], al

 mov ah, 09h
 mov dx, offset mes
int 21h
ending:
main endp



procChar proc
    ;pop dx; save adress to dx
    ;mov saveV, dx
    cmp oneChar,0Dh
jnz notCR
;change isWord to 1
 mov isWord,1
 ; go to next position in values
 mov ax, valInd
 mov cx, 16
 ;div cx; now ax has number of values
  shr ax, 4        ; Shift right by 4 position
 inc ax; go to next value 
mul cx; ax has position of next value
mov valInd,ax
  

    jmp endProc
notCR:
cmp oneChar,0Ah
jnz notLF
;change isWord to 1
mov isWord,1
    jmp endProc
notLF:
cmp oneChar,20h
jnz notSpace
;chance isWord to 0
mov isWord,0
; go to next position in keys
 mov ax, keyInd
 mov cx, 16
 ;div cx; now ax has number of keys
 shr ax, 4 ; Shift right by 4 position ділення на 16 не спрацювало тому побітовий сув на 4 ( щоб запонвити поусті комірки в одному key)
 inc ax; go to next key 
mul cx; ax has position of next key
mov keyInd,ax
 
jmp endProc



notSpace:
    cmp isWord, 0 ; key or value 
    jnz itsWord
        ;save char to values
        mov si, offset values
       
        mov bx, valInd
        add si, bx
        mov al, oneChar
        mov [si], al
        inc valInd
          jmp endProc
itsWord:
    
         ;save char to keys 
        mov si, offset keys

        mov bx, keyInd 
        add si, bx
        mov al, oneChar

        mov [si], al
        inc keyInd 
      

endProc:
    ;push dx
    ret
procChar endp   
end main