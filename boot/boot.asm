org 0x7c00
bits 16


start:
    mov si, message
    call print_str

    jmp $           ; Forever loop

%include "print_str.asm"

message: db 'Custom bootloader!', 0

times 510-($-$$) db 0
dw 0xaa55