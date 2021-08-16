org 0
bits 16
_start:
    jmp short start
    nop

times 33 db 0       ; Workaround for some BIOSes replacing data (BIOS Parameter Block) 
                    ; in sector (to make USB bootable, i guess)

start:
    jmp 0x7c0:step2

step2:
    cli             ; Clear interrupts
    mov ax, 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7c00
    sti             ; Enable interrupts

    mov ah, 2       ; Read sector command for int13
    mov al, 1       ; Read 1 sector
    mov ch, 0       ; Cylinder low 8 bits
    mov cl, 2       ; Read sector 2
    mov dh, 0       ; Head number

    mov bx, buffer
    int 0x13

    jc error

    mov si, buffer
    call print_str
    jmp $           ; Forever loop

error:
    mov si, read_error_msg
    call print_str
    jmp $

%include "print_str.asm"

read_error_msg: db 'Could not read data!', 0

times 510-($-$$) db 0
dw 0xaa55

buffer: 
