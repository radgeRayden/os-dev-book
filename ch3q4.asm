; vim: set ft=nasm:

; A boot sector that prints a string using our function.

[org 0x7c00]

    mov bx, HELLO_MSG
    call print_string

    mov bx, GOODBYE_MSG
    call print_string

    jmp $

%include "print_string.asm"

; Data
; note: 0x0a, 0x0d -> \n\r, telling the TTY to start at the beginning of next line.
HELLO_MSG:
    db 'Hello, World', 0x0a, 0x0d, 0

GOODBYE_MSG:
    db 'Goodbye!', 0x0a, 0x0d, 0

times 510-($-$$) db 0
dw 0xaa55

