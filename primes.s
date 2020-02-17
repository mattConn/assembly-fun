; calculate the 10,000th prime with a terrible algorithm

; assemble:
; nasm -f elf32 primes.s -o primes.o
; link:
; gcc -m32 primes.o -o primes

extern printf

section .data

msg db "%d: %d",10,0

section .text

global main

main:

		mov esi, 1 ; init dividend (possible prime)
		mov ecx, 0 ; prime count

	RESET:
		inc esi ; inc dividend
		mov edi, 2 ; divisor

	L1:

		mov edx, 0 ; zero out remainder
		
		cmp edi, esi ; check if divisor = dividend
		je PRIME ; prime found

		mov eax, esi ; dividend
		mov ebx, edi ; divisor
		div ebx
		cmp edx,0
		je RESET ; if no remainder, not prime

		inc edi ; inc divisor
		jmp L1

	PRIME:

		inc ecx ; count prime
	
		; 10000th prime found
		cmp ecx, 10000
		je END
		jmp RESET


	END:
		; print prime
		push esi
		push ecx
		push msg
		call printf
		pop esi
		pop ecx
		pop esi

	mov eax, 0
	ret
