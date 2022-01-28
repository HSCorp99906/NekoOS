org 0x7C00

xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax

mov bp, 0x9C00
mov sp, bp

_start:
    mov ah, 0x0
    mov al, 0x2
    int 0x10

    mov si, welcome_msg
    call puts

    mov si, boot_option
    call puts

    mov si, reboot_option
    call puts

    cli
    hlt


puts:
    mov ah, 0x0E
    lodsb
    or al, al
    jz rm_ret
    int 0x10
    jmp puts

rm_ret: ret

welcome_msg: db "Welcome to NekoOS nya~ Please choose an option nya~", 0x0D, 0x0A, 0
boot_msg: db "Booting NekoOS UwU~", 0x0D, 0x0A, 0
boot_option: db 0x0D, 0x0A, "[B]oot", 0x0D, 0x0A, 0
reboot_option: db "[R]eboot", 0x0D, 0x0A, 0


times 510-($-$$) db 0
dw 0xAA55
