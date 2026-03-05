default rel
section .text

global strlen_asm

; uint64_t strlen_asm(const char* s)
; rcx = pointer to '\0' terminated string
; rax = length
strlen_asm:
    xor rax, rax

.loop:
    cmp byte [rcx + rax], 0
    je .done
    inc rax
    jmp .loop

.done:
    ret
