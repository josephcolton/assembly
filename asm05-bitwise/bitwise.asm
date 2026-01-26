section .text
	global _start

_start:
	;; Bitwise Operations
	mov rax, 7
	mov rbx, 6
	mov rcx, 5
	mov rdx, 4

	and rax, rbx		; ADD operation -> 111 & 110 = 110 (6)
	or rax, rcx		; OR operation  -> 110 | 101 = 111 (7)
	xor rax, rdx		; XOR operation -> 111 ^ 400 = 011 (3)
	not rcx			; NOT operation

	;; Shifting
	shr rbx, 2		; Shift right -> 110 >> 2 = 001 (1)
	shl rbx, 2		; Shift left  -> 001 << 2 = 100 (4)

	;; System call for sys_exit (exit the program)
	mov rax, 60       ; System call number for sys_exit
	mov rdi, 0        ; Exit status (0 for success)
	syscall           ; Execute the system call
