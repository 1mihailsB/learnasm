section .data
n dd 35
section .text
global _start
_start:
; assume n > 2
mov edx, dword [n]
; n - 1
dec edx

; previous value
mov rbx, 0
; previous previous value
mov rcx, 1
fib:
    mov rax, rcx
    add rax, rbx

    mov rbx, rcx
    mov rcx, rax

    dec rdx
    cmp rdx, 0
    jne fib

mov rax, 60
mov rdi, 0
syscall