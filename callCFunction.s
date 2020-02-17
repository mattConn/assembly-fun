; calling a c function from assembly
; assemble: 
; nasm -f elf32 callCFunction.s -o callCFunction.o
; link:
; gcc -m32 cfunction.c callCFunction.o -o callCFunction

extern cfunction
extern printf

section .data

	hexFmt db "%x", 10, 0

section .text

	global main

	main:

	call cfunction

	push eax
	push hexFmt
	call printf

	add esp, 8
	
	mov eax, 0
	ret
