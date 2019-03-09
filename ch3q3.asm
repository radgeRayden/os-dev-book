; vim: set ft=nasm:

;chapter 3, question 3: convert this code to asm
;   mov bx , 30
;   if (bx <= 4) {
;      mov al , ’A’
;   } else if (bx < 40) {
;       mov al , ’B’
;   } else {
;       mov al , ’C’
;   }
;
;   mov ah , 0x0e
;   int 0x10
;
;   jmp $
;   times   510-($-$$) db 0
;   dw 0xaa55

    mov bx, 4

    cmp bx, 4
    jle print_A
    cmp bx, 40
    jl print_B
    jmp print_C

print_A:
    mov al, 'A'
    jmp cmp_end
print_B:
    mov al, 'B'
    jmp cmp_end
print_C:
    mov al, 'C'

cmp_end:
    mov ah, 0x0e
    int 0x10

    jmp $

    times 510-($-$$) db 0
    dw 0xaa55

