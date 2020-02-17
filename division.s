extern printf
; division mnemonic
; 32 bit:
; edx:eax = dividend hi and low
; register or imm val  = divisor
; div reg/imm => divide eax by reg/imm, quotient in eax, remainder in edx

; assemble:
; nasm -f elf32 divison.s -o divison.o
; link:
; gcc -m32 divison.o -o divison

section .data

msg db "q: %d, r: %d",10,0

section .text

global main

main:

	mov edx,0
	mov eax,12
	mov ebx, 7
	div ebx

	; print quotient and remainder
	push edx
	push eax
	push msg
	call printf
	add esp, 12

	ret
