; Simple example function to find and return the minimum,
; maximum, sum, medians, and average of an array.
; -----
; HLL call:
; stats2(arr, len, min, med1, med2, max, sum, ave);
; Arguments:
; arr, address – rdi
; len, dword value – esi
; min, address – rdx
; med1, address - rcx
; med2, address - r8
; max, address - r9
; sum, address – stack (rbp+16)
; ave, address – stack (rbp+24)
global stats2
stats2:
push rbp ; prologue
mov rbp, rsp
push r12
; -----
; Get min and max.
mov eax, dword [rdi] ; get min
mov dword [rdx], eax ; return min
mov r12, rsi ; get len
dec r12 ; set len-1
mov eax, dword [rdi+r12*4] ; get max
mov dword [r9], eax ; return max
; -----
; Get medians
mov rax, rsi
mov rdx, 0
mov r12, 2
div r12 ; rax = length/2
cmp rdx, 0 ; even/odd length?
je evenLength
mov r12d, dword [rdi+rax*4] ; get arr[len/2]
mov dword [rcx], r12d ; return med1
mov dword [r8], r12d ; return med2
jmp medDone
evenLength:
mov r12d, dword [rdi+rax*4] ; get arr[len/2]
mov dword [r8], r12d ; return med2
dec rax
mov r12d, dword [rdi+rax*4] ; get arr[len/2-1]
mov dword [rcx], r12d ; return med1
medDone:
; -----
; Find sum
mov r12, 0 ; counter/index
mov rax, 0 ; running sum
sumLoop:
add eax, dword [rdi+r12*4] ; sum += arr[i]
inc r12
cmp r12, rsi
jl sumLoop
mov r12, qword [rbp+16] ; get sum addr
mov dword [r12], eax ; return sum
; -----
; Calculate average.
cdq
idiv rsi ; average = sum/len
mov r12, qword [rbp+24] ; get ave addr
mov dword [r12], eax ; return ave
pop r12 ; epilogue
pop rbp
ret

; stats2(arr, len, min, med1, med2, max, sum, ave);
push ave ; 8th arg, add of ave
push sum ; 7th arg, add of sum
mov r9, max ; 6th arg, add of max
mov r8, med2 ; 5th arg, add of med2
mov rcx, med1 ; 4th arg, add of med1
mov rdx, min ; 3rd arg, addr of min
mov esi, dword [len] ; 2nd arg, value of len
mov rdi, arr ; 1st arg, addr of arr
call stats2
add rsp, 16 ; clear passed arguments
