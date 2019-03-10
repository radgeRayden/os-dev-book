; vim: set ft=nasm:

%ifndef DISK_LOAD
    %define DISK_LOAD

disk_load:
    push dx         ; store DX on stack so later we can recall
                    ; how many sectors were requested to be read,
                    ; even if it is altered in the meantime.
    mov ah, 0x02    ; BIOS read sector function
    mov al, dh      ; Read DH sectors
    mov ch, 0x00    ; select cylinder 0
    mov dh, 0x00    ; select head 0
    mov cl, 0x02    ; start reading from second sector (ie.
                    ; after the boot sector)

    int 0x13        ; disk related interrupt

    jc disk_error  

    pop dx          
    cmp dh, al      ; if al (sectors read) != dh (sectors expected)
    jne disk_error 
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

%include "print_string.asm"

DISK_ERROR_MSG db "Disk read error!", 0

%endif
