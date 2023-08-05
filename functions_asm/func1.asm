; Simple example function to find and return
; the sum and average of an array.
; HLL call:
; stats1(arr, len, sum, ave);
; -----
; Arguments:
; arr, address – rdi
; len, dword value – esi
; sum, address – rdx
; ave, address - rcx
global stats1
stats1:
push r12 ; prologue. The choice of the r12 register is arbitrary, however a 'saved register' was selected.
mov r12, 0 ; counter/index
mov rax, 0 ; running sum
sumLoop:
add eax, dword [rdi+r12*4] ; sum += arr[i]
inc r12
cmp r12, rsi
jl sumLoop
mov dword [rdx], eax ; return sum
cdq
idiv esi ; compute average
mov dword [rcx], eax ; return ave
pop r12 ; epilogue
ret

; stats1(arr, len, sum, ave);
mov rcx, ave ; 4th arg, addr of ave
mov rdx, sum ; 3rd arg, addr of sum
mov esi, dword [len] ; 2nd arg, value of len
mov rdi, arr ; 1st arg, addr of arr
call stats1