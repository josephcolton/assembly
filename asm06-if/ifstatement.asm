	section .data
	str1 db "rbx = rcx",10,0
	str2 db "rbx < rcx",10,0
	str3 db "rbx > rcx",10,0
	str4 db "not match",10,0

	section .text
	global _start

_start:
	;; Set variables
	mov rbx, 5
	mov rcx, 5

	;; if statement
	cmp rbx, rcx
	je equal
	jl less
	jg greater

	;; Default
	mov rsi, str4
	jmp print

equal:
	mov rsi, str1
	jmp print

less:
	mov rsi, str2
	jmp print

greater:
	mov rsi, str3
	jmp print

print:	
	;; System call for sys_write (write the line)
	mov rax, 1	; System call number for sys_write
	mov rdi, 1	; File descriptor for stdout (1)
	mov rdx, 10	; Number of characters to write
	syscall		; Execute the system call

	;; System call for sys_exit (exit the program)
	mov rax, 60		; System call number for sys_exit
	mov rdi, 0		; Exit status (0 for success)
	syscall			; Execute the system call
