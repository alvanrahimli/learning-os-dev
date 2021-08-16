org 0
bits 16
_start:
    jmp short start
    nop

times 33 db 0       ; Workaround for some BIOSes replacing data (BIOS Parameter Block) 
                    ; in sector (to make USB bootable, i guess)

handle_zero:
    mov si, ivt_zero_msg
    call print_str
    iret

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

    mov word[ss:0x00], handle_zero
    mov word[ss:0x02], 0x7c0

    int 0

    mov si, message
    call print_str
    mov si, msg2
    call print_str
    jmp $           ; Forever loop

%include "print_str.asm"

ivt_zero_msg: db 'This is IVT!', 0
message: db 'Custom bootloader!', 0
msg2: db 'Saalaam :D', 0

times 510-($-$$) db 0
dw 0xaa55