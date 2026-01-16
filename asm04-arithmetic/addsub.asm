section .data
	string db "Value: x",10

section .text
	global _start

_start:

	;; Perform integer addition and subtraction
	mov rax, 3         ; First value
	mov rbx, 2	   ; Second value
	add rax, rbx	   ; rax += rbx
	;sub rax, rbx	   ; rax -= rbx
	;inc rax           ; rax++
	;dec rax 	   ; rax--
	add rax, 48	   ; Convert to ASCII digit
	mov [string+7], al ; Put the result character in the x place

	;; System call for sys_write (write to stdout)
	mov rax, 1        ; System call number for sys_write
	mov rdi, 1        ; File descriptor for stdout (1)
	mov rsi, string   ; Address of the string
	mov rdx, 9        ; Length of the string
	syscall           ; Execute the system call

	;; System call for sys_exit (exit the program)
	mov rax, 60       ; System call number for sys_exit
	mov rdi, 0        ; Exit status (0 for success)
	syscall           ; Execute the system call
