section .data
	string_format db "Float: %f",10,0 ; Printf formatted string
	value dq 3.14			  ; Defined Quadword (64-bit) float value

section .text
	global main   ; Create a global for the entry point main
	extern printf ; Declare printf as an external function (in libc)

main:
	;; Match 16-byte boundary of libc
	sub rsp, 8

	;; Function call (printf)
	mov rdi, string_format
	movsd xmm0, [value]
	mov rax, 1
	call printf

	;; Switch boundary back
	add rsp, 8

	;; Return from main
	mov rax, 0
	ret
