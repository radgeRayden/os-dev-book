; vim: set ft=nasm:

[org 0x7c00]

    mov dx, 0x1fb6
    call print_hex 
    jmp $

%include "print_string.asm"

print_hex:
    ;TODO: manipulate chars at HEX_OUT to reflect DX
    pusha

first_byte:
    ; separate the 2 nibbles of dh
    mov cl, dh
    mov ch, dh
    and cl, 0x0f    ; get low nibble by AND high with 0
    shr ch, 4       ; get high nibble by 'evicting' low nibble

    ; set corresponding digit according to value
    first_digit:
        cmp ch, 0x0a
        jg .letter
        add ch, 0x30    ; offset for ASCII digit
        jmp second_digit
        .letter:
        add ch, 0x61 - 0x0a ; offset for letter 'a', minus 10 for the first ten numbers

    second_digit:
        cmp cl, 0x0a
        jg .letter
        add cl, 0x30    ; offset for ASCII digit
        jmp store_first_byte
        .letter:
        add cl, 0x61 - 0x0a ; offset for letter 'a', minus 10 for the first ten numbers

    store_first_byte:
        mov [HEX_OUT + 2],  ch
        mov [HEX_OUT + 3],  cl

second_byte:
    mov cl, dl
    mov ch, dl
    and cl, 0x0f    ; get low nibble by AND high with 0
    shr ch, 4       ; get high nibble by 'evicting' low nibble

    third_digit:
        cmp ch, 0x0a
        jg .letter
        add ch, 0x30    ; offset for ASCII digit
        jmp second_digit
        .letter:
        add ch, 0x61 - 0x0a ; offset for letter 'a', minus 10 for the first ten numbers

    fourth_digit:
        cmp cl, 0x0a
        jg .letter
        add cl, 0x30    ; offset for ASCII digit
        jmp store_second_byte
        .letter:
        add cl, 0x61 - 0x0a ; offset for letter 'a', minus 10 for the first ten numbers

    store_second_byte:
        mov [HEX_OUT + 4],  ch
        mov [HEX_OUT + 5],  cl

    mov bx, HEX_OUT ; print the string pointed by bx
    call    print_string
    popa
    ret

; global variables
HEX_OUT: db '0x0000', 0

times 510-($-$$) db 0
dw 0xaa55
