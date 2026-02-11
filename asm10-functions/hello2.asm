	section .data
	hello db "Hello World!",10 ; String to print
	hellolen equ $ - hello	   ; Length of the string

	section .text
	global _start		; Global entry point

_start:
	;; Call functions
	call funct_hello
	call funct_hello
	call funct_hello
	call funct_hello

	;; Go to the end of the program
	jmp exit

funct_hello:	
	;; Write System Call
	mov rax, 1		; sys_write
	mov rdi, 1		; stdout
	mov rsi, hello		; Address of string
	mov rdx, hellolen	; Length of the string
	syscall			; Call the sys_write system call
	ret			; Return from function
	
	;; Exit
exit:
	mov rax, 60		; sys_exit
	mov rdi, 0		; Return value
	syscall
	
