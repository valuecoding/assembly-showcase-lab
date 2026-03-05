default rel
section .text

global bitcount_u64

; uint64_t bitcount_u64(uint64_t value)
; rcx = value
; rax = count of set bits
bitcount_u64:
    xor rax, rax

.loop:
    test rcx, rcx
    jz .done

    mov rdx, rcx
    and rdx, 1
    add rax, rdx
    shr rcx, 1
    jmp .loop

.done:
    ret
