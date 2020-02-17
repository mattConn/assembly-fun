; fib number calculator
; calculates fib numbers until edx overflows or ecx = 2^31 - 1

; assemble:
; nasm fibonacci.s -f elf32 -o fibonacci.o
; link:
; gcc -m32 fibonacci.o -o fibonacci


extern printf

section .data

MAX equ 0x7fffffff ; 2^31 - 1  max int with sign bit

msg db "%d: %d", 10, 0 ; printf fmt string, display count and fib

section .text

global main

main:

	mov ecx, 0

	mov eax, 1 ;fib 1
	mov ebx, 1 ;fib 2

	L1:
		; calculate next fib
		mov edx, 0 
		add edx, ebx
		add edx, eax

		; check for overflow
		cmp edx,0
		jl END

		; print sum
		push edx ; push sum
		push ecx ; push counter
		add dword [esp], 3 ; offset count by 3, starting from 3rd fib
		push msg ; fmt string
		call printf

		pop edx ; discard msg
		sub dword [esp], 3 ; subtract offset
		pop ecx ; pop counter
		pop edx ; pop sum

		; shift over fibs
		mov eax, ebx
		mov ebx, edx

		; inc loop counter
		inc ecx
		cmp ecx, MAX
		jl L1


	END:

	mov eax, 0
	ret
