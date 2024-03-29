; vim: set ft=nasm:
; A simple boot sector program that demonstrates the stack.
    
    mov ah, 0x0e

    mov bp, 0x8000      ; set the base of the stack a little above where BIOS
    mov sp, bp          ; loads out boot sector - so it won't overwrite us.

    push    'A'         ;push some characters on the stack for later
    push    'B'         ;retrieval. Note, there are pushed on as
    push    'C'         ;16-bit values, so the most significant byte
                        ;will be added by our assembler as 0x00.

    pop bx              ;note, we can only pop 16-bits, so pop to bx
    mov al, bl          ;then copy bl (ie. 8-bit char) to al
    int 0x10            ;print(al)

    pop bx              ;pop the next value
    mov al, bl
    int 0x10

    mov al, [0x7ffe]    ;to prove our stack grows downwards from bp,
                        ;fecth the char at 0x8000 - 0x2 (ie. 16-bits)
    int 0x10

    jmp $

    times 510-($-$$) db 0
    dw 0xaa55


