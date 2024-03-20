.model small
.data
    key db 10, 20, 30, 40, 50   
    value db 5, 3, 4, 1, 2      
    key_length equ $ - key        
    value_length equ $ - value    

.code
main proc
    mov ax, @data
    mov ds, ax

    ; bubble sort
    mov cx, value_length        ; cx = довжина масиву value
    dec cx                      ; cx - 1
    mov si, 0                   ; ініціалізація зовнішнього індексу
outer_loop:
    mov di, 0                   ; ініціалізація внутрішнього індексу
inner_loop:
    mov al, [value + di]        ; завантаження елементу масиву в al
    mov bl, [value + di + 1]    ; завантаження наступного елементу масиву в bl
    cmp al, bl                  ; порівняння двох елементів масиву
    jle no_swap                 ; якщо al <= bl, перехід до мітки no_swap
    ; обмін елементів
    mov [value + di], bl
    mov [value + di + 1], al

    ; обмін елементів у масиві key
    mov al, [key + di]
    mov bl, [key + di + 1]
    mov [key + di], bl
    mov [key + di + 1], al
no_swap:
    inc di                      ; інкремент внутрішнього індексу
    cmp di, cx                  ; перевірка, чи досягнуто кінця масиву
    jl inner_loop               ; якщо ні, повторюємо внутрішній цикл
    dec cx                      ; зменшуємо зовнішній індекс
    jnz outer_loop              ; якщо cx != 0, повторюємо зовнішній цикл

main endp

end main
