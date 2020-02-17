; assemble:
; nasm -f elf32 printfloop.s -o printfloop.o

; link (gcc for printf):
; gcc -m32 printfloop.o -o printfloop 

; printf will store return result in EAX, and clobber ECX, EDX
; arguments: fmt string, value...
; e.g. printf("my numbers: %d, %d", 24, 25);
; push args onto stack from right to left

extern printf

section .data
	; 0 = null character, very important or else this db will run onto the next
	fmtDec db "%d", 10, 0

	msg db "Entering loop", 10, 0

	newline db 10, 0

section .text
	global main 

	main:

		mov ecx, 10 ; set counter 

		; display message
		push ecx
		push msg
		call printf
		add esp, 4
		pop ecx


    	L1:
			mov eax, ecx
			mov ebx, fmtDec
			push ecx ; save ecx from printf
			call printReg
			pop ecx

            loop L1

		mov eax, 0
		ret

		; print decimal value with printf
		; push ecx before calling, pop after
		; prints eax=val, ebx=fmt_string
		printReg:
			push eax
			push ebx

			call printf

			pop ebx
			pop eax
