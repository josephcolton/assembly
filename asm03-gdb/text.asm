section .data
	textstr db "text",10
	len dd 5

section .text
	global _start

_start:
	; System call for sys_write (write to stdout)
	mov rax, 1        ; System call number for sys_write
	mov rdi, 1        ; File descriptor for stdout (1)
	mov rsi, textstr  ; Address of the string
	mov rdx, [len]    ; Length of the string
	syscall           ; Execute the system call

	; System call for sys_exit (exit the program)
	mov rax, 60       ; System call number for sys_exit
	mov rdi, 0        ; Exit status (0 for success)
	syscall           ; Execute the system call
