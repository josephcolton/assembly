section .data
	string db "Value: x",10

section .text
	global _start

_start:

	;; Perform integer multiplication and division
	mov rax, 3         ; First value (dividend in division)
	mov rbx, 2	   ; Second value (divisor in division)
	mov rdx, 0	   ; Clear (remainder in division)
	mul rbx		   ; rax *= rbx (unsigned)
	;imul rbx	   ; rax *= rbx (signed)
	;div rbx 	   ; rax /= rbx (unsigned, rdx = rax % rbx)
	;idiv rbx 	   ; rax /= rbx (signed, rdx = rax % rbx)
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
