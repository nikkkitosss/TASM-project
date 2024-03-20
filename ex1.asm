.model small
.stack 100h

.data
buffer db 256 dup(?)      ; буфер для зчитування рядка
key db 17 dup(?)          ; місце для збереження ключа (макс 16 символів + 1 для завершувача рядка)
value dw ?                ; змінна для збереження значення
CR equ 0Dh                ; код символу CR
LF equ 0Ah                ; код символу LF

.code
main proc
    mov ax, @data
    mov ds, ax

    mov cx, 10000          ; максимальна кількість рядків
read_loop:
    ; зчитування рядка з stdin
    lea dx, buffer
    mov ah, 0Ah             ; зчитати рядок з stdin
    int 21h

    ; перевірка на EOF  
    cmp buffer, '$'
    je end_input

    ; пошук кінця рядка
    mov si, offset buffer + 2 ; адресу початку рядка
    mov cx, 255             ; обмежити пошук до максимальної довжини рядка
    xor al, al
    repne scasb             ; шукаємо перший не нульвий символ в al
    mov cx, 16              ; максимальна довжина ключа
    mov di, offset key      ; початок адреси для зберігання ключа 
    mov al, ' '             ; роздільник між ключем та значенням
    cld
    repne scasb             ; шукаємо пробіл, що розділяє ключ та значення, за допомогоб порівнння з al 
    je invalid_input        ; якщо пробіл не знайдено, це невірний формат введення

    ; копіюємо ключ до key, включно з пробілом
    mov cx, di
    sub cx, offset key
    mov al, 0               ; додаємо завершувач рядка
    mov byte ptr [di], al
    inc di                  ; перехід до наступного байту 

    ; перевірка довжини ключа
    cmp cx, 17
    jge invalid_input       ; якщо довжина ключа перевищує 16 символів, ввід недійсний

    ;...

    jmp read_loop

end_input:
    mov ax, 4C00h
    int 21h

invalid_input:
    ; обробка недійсного вводу
    jmp read_loop

main endp
end main
