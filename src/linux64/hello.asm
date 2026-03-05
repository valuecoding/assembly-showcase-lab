section .data
msg db "hello from x64 assembly", 10
msg_len equ $ - msg

section .text
global _start

_start:
    ; write(1, msg, msg_len)
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg_len
    syscall

    ; exit(0)
    mov rax, 60
    xor rdi, rdi
    syscall
