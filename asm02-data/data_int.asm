section .data
	string_format db "Integer: %d",10,0 ; String format, newline(10), and null(0)
	value dd 1234 ; Define doubleword (32-bit) integer value

section .text
	global main   ; Global entry point main
	extern printf ; Declare printf as an external function

main:
	;; Match 16-byte boundary of libc
	sub rsp, 8

	;; Function call (printf)
	mov rdi, string_format
	mov rsi, [value]
	xor rax, rax
	call printf

	;; Switch boundary back
	add rsp, 8

	;; Return from main
	mov rax, 0
	ret
