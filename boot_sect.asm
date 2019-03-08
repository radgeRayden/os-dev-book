; vim: set ft=nasm:
    [org 0x7c00]

    mov ah, 0x0e ; scrolling teletype BIOS routine
    
    mov bx, 0
print_loop:
    mov al, [boot_msg + bx]
    cmp al, 0
    je  loop_end
    int 0x10
    add bx, 1
    jmp print_loop

loop_end:
    jmp $ ;$ = current address, so jump forever

boot_msg:
    db "Booting OS", 0

    ;padding and magic BIOS number

    times 510-($-$$) db 0 
    dw 0xaa55 
