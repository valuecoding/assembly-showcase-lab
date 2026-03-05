default rel
section .text

global sum_u64

; uint64_t sum_u64(const uint64_t* values, uint64_t len)
; Windows x64 calling convention:
;   rcx = values
;   rdx = len
; return:
;   rax = sum
sum_u64:
    xor rax, rax        ; sum = 0
    xor r8, r8          ; i = 0

.loop:
    cmp r8, rdx
    jae .done
    add rax, [rcx + r8 * 8]
    inc r8
    jmp .loop

.done:
    ret
