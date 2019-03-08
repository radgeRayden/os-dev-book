; vim: set ft=nasm:
    [org 0x7c00]

    
    mov bx, 0
    mov cx, 0

main_loop:
    mov ah, 0x0e    ; scrolling teletype BIOS routine
    mov dx, cx
    add dx, 0x30    ; offset for number digits in ASCII
    mov al, dl
    int 0x10        ; print iteration number
    mov al, 0x20    ; " "

    jmp print_loop

print_end:
    int 0x10
    mov al, 0x0a    ; \n
    int 0x10
    mov al, 0x0d    ; \r
    int 0x10

    mov ah, 0x06    ; scroll window up
    mov al, 0x01
    int 0x10
    mov bx, 0       ; reinit string counter

    add cx, 1
    cmp cx, 0xa
    jne main_loop   ; only do this 10 times
    jmp $           ;$ = current address, so jump forever

print_loop:
    mov al, [boot_msg + bx]
    cmp al, 0
    je  print_end
    int 0x10
    add bx, 1
    jmp print_loop

boot_msg:
    db "Booting OS", 0 ; "Booting OS \n\r\0"

    ;padding and magic BIOS number

    times 510-($-$$) db 0 
    dw 0xaa55 
