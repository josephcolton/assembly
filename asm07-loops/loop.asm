	section .data
	star db "*"
	newline db 10

	section .text
	global _start

_start:
	;; Number of stars to write
	mov rbx, 5

loop:
	cmp rbx, 0
	jle end		; Jump out if rbx <= 0
	dec rbx		; Decrement rbx

	;; Write a star
	mov rax, 1	; System call number for sys_write
	mov rdi, 1	; File descriptor for stdout (1)
	mov rsi, star	; Print
	mov rdx, 1	; Number of characters to write
	syscall		; Execute the system call
	jmp loop
	
end:
	;; Write a newline
	mov rax, 1	 ; System call number for sys_write
	mov rdi, 1	 ; File descriptor for stdout (1)
	mov rsi, newline ; Print
	mov rdx, 1	 ; Number of characters to write
	syscall		 ; Execute the system call

	;; System call for sys_exit (exit the program)
	mov rax, 60      ; System call number for sys_exit
	mov rdi, 0       ; Exit status (0 for success)
	syscall          ; Execute the system call
