; Prints text on si register
print_str:
    mov bx, 0
    
    .begin:
        lodsb
        cmp al, 0
        je .done
        call print_char
        call .begin
    .done:
        ret

print_char:
    mov ah, 0eh
    int 0x10
    ret