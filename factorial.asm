section .data
factorialStart dd 10
section .text
global _start
_start:
mov eax, dword [factorialStart]

mov ebx, dword [factorialStart]
dec ebx

facLoop:
    mul ebx

    dec ebx
    cmp ebx, 0
    jne facLoop

mov rax, 60
mov rdi, 0
syscall