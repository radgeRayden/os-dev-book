; vim: set ft=nasm:
[org 0x7c00]

.loop:
    inc dx
    call print_hex
    cmp dx, 0xffff
    jne .loop 

    mov bx, END_MSG
    call print_string 
    jmp $

%include "print_hex.asm"
%include "print_string.asm"

END_MSG: db "end!", 0

times 510 - ($ - $$) db 0
dw 0xaa55
