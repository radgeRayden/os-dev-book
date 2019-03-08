; vim: set ft=nasm:
    [org 0x7c00]

    mov ah, 0x0e ; scrolling teletype BIOS routine
    
    ;first attempt
    mov al, the_secret
    int 0x10    ;does this print an X?

    ;second attempt
    mov al, [the_secret]
    int 0x10    ;does this print an X?

    ;third attempt
    mov bx, the_secret
    add bx, 0x7c00
    mov al, [bx]
    int 0x10    ;well does it?

    ;fourth attempt
    mov al, [0x7c1d]
    int 0x10    ;what about this one?

    jmp $ ;$ = current address, so jump forever

the_secret:
    db "X"    

    ;padding and magic BIOS number

    times 510-($-$$) db 0 
    dw 0xaa55 
