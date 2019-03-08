; vim: set ft=nasm:
    [org 0x7c00]

    mov ah, 0x0e ; scrolling teletype BIOS routine
    
    mov bx, 0
print_loop:
    mov al, [boot_msg + bx]
    add bx, 1
    int 0x10
    cmp al, 0
    jnz print_loop
    jmp $ ;$ = current address, so jump forever

boot_msg:
    db "Booting OS", 0

    ;padding and magic BIOS number

    times 510-($-$$) db 0 
    dw 0xaa55 
