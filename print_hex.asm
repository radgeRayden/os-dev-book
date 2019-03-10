; vim: set ft=nasm:
%ifndef PRINT_HEX
    %define PRINT_HEX

    %define HEX_OFFSET 2

print_hex:
    push cx
    push bx

    ; separate the high and low parts of dx
    mov ch, dh
    shr ch, 4       ; 4 >> high evicts right nibble 
    mov bx, DIGITS  ; store memory location of the DIGITS
    add bl, ch      ; and add the value offset
    mov ch, [bx]    ; load the character from memory
    mov [HEX_OUT + HEX_OFFSET], ch

    mov cl, dh      ; could've just reused ch I guess but it doesn't matter
    and cl, 0x0f    ; mask the low part with 0x0f, zeroing the left nibble
    mov bx, DIGITS
    add bl, cl
    mov cl, [bx]
    mov [HEX_OUT + HEX_OFFSET + 1], cl

    ; repeat process with low part of dx
    mov ch, dl
    and ch, 0x0f
    mov bx, DIGITS
    add bl, ch
    mov ch, [bx]
    mov [HEX_OUT + HEX_OFFSET + 2], ch

    mov cl, dl
    and cl, 0x0f
    mov bx, DIGITS
    add bl, cl
    mov cl, [bx]
    mov [HEX_OUT + HEX_OFFSET + 3], cl

    mov bx, HEX_OUT
    call print_string
    pop bx
    pop cx
    ret
%include "print_string.asm"

; global variables
HEX_OUT: db '0x0000', 0x20, 0
DIGITS: db "0123456789ABCDEF" ; I'm tired of this shit

%endif
