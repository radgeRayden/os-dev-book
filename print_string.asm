; vim: set ft=nasm:

print_string:
    pusha
    mov ah, 0x0e
putchar:
    mov al, [bx]    ; since we can't address a register in the first operand of cmp, it's
    cmp al, 0       ; necessary to first move the value of [bx] into ax
    je str_end
    int 0x10
    add bx, 1       ;iterate in place
    jmp putchar
str_end:
    popa
    ret
