; vim: set ft=nasm:

    mov ah, 0x0e ; scrolling teletype BIOS routine
    
    mov bx, the_secret
    add bx, 0x7c00
    mov al, [bx]
    int 0x10    ;well does it?

    mov al, [0x7c14]
    int 0x10    ;what about this one?

    jmp $ ;$ = current address, so jump forever

the_secret:
    db "X"    

    ;padding and magic BIOS number

    times 510-($-$$) db 0 
    dw 0xaa55 
