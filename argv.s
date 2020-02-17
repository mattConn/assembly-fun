; printing argv

; assemble:
; nasm -f elf32 argv.s -o argv.o
; link:
; gcc -m32 argv.o -o argv



extern printf

section .data
msg db "%s",10,0

section .text

global main
main:

mov eax, [esp+8] ; address of argv[], esp+4 is argc (CDECL calling convention on main(argc,argv))
mov ecx, 0 ; counter
mov edi, [esp+4]; argc

L1:

	mov ebx, [eax+ecx*4] ; value in argv

	push ecx ; save ecx from printf
	push eax ; save eax from printf
	push ebx ; value
	push msg
	call printf
	add esp, 4 ; discard msg
	pop ebx
	pop eax
	pop ecx

	inc ecx ; inc counter
    cmp ecx, edi ; check if counted up to argc
    jl L1

mov eax, 0
ret
