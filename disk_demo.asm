; vim: set ft=nasm:
[org 0x7c00]
    mov ah, 0x02    ; BIOS read sector function

    mov dl, 0       ; read drive 0 (ie. first floppy drive)
    mov ch, 3       ; select cylinder 3
    mov dh, 1       ; select the track on 2nd side of floppy
                    ; disk, since this count has a base of 0
    mov cl, 4       ; select the 4th sector on the track -
                    ; not the 5th, since this has a base of 1.
    mov al, 5       ; read 5 sectors from the start point

    ; Lastly, set the address that we'd like BIOS to read the
    ; sectors to, which BIOS expects to find in ES:BX
    ; (ie. segment ES with offset BX).
    mov bx, 0xa000
    mov es, bx
    mov bx, 0x1234

    int 0x13    ; read

    jc disk_error   ; jc -> jump if carry, set by BIOS if reding failed
                    ; this jumps if what BIOS reported as the number
                    ; of sectors read in AL is not equal to the number
                    ; we expected.
    cmp al, 0x05
    jne disk_error
    mov bx, BOOT_MSG 
    call print_string
    jmp $

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    mov dx, 0
    mov dl, al
    call print_hex
    jmp $


    %include "print_string.asm"
    %include "print_hex.asm"

DISK_ERROR_MSG: db "Disk read error! Number of sectors read: ", 0
BOOT_MSG:       db "Welcome!", 0x0a, 0x0d, 0

    times 510-($ - $$) db 0

    dw 0xaa55
