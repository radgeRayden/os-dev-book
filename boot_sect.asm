; vim: set ft=nasm:

    mov ah, 0x0e ; scrolling teletype BIOS routine

    mov al, 'H'
    int 0x10
    mov al, 'e'
    int 0x10
    mov al, 'l'
    int 0x10
    mov al, 'l'
    int 0x10
    mov al, 'o'
    int 0x10
    mov al, '!'
    int 0x10

    jmp $ ;$ = current address, so jump forever

    times 510-($-$$) db 0 ;pad the boot sector out with zeros

    dw 0xaa55 ; 2-byte magic number for BIOS - identifies boot sector
