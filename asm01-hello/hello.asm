section .data
	hello db "Hello World!", 0x0A  ; The string, followed by a newline character (0x0A)
	hellolen equ $ - hello         ; Length of message from 'hello' label to this point ($)
	STDOUT: equ 1                  ; Set standard out label to the stdout file descriptor

section .text
	global _start                  ; Create a global for the entry point _start

_start:
	; System call for sys_write (write to stdout)
	mov rax, 1                     ; System call number for sys_write
	mov rdi, STDOUT                ; File descriptor for stdout (1)
	mov rsi, hello                 ; Address of the "Hello World!" string
	mov rdx, hellolen              ; Length of the "Hello World!" string
	syscall                        ; Execute the system call

	; System call for sys_exit (exit the program)
	mov rax, 60                    ; System call number for sys_exit
	mov rdi, 0                     ; Exit status (0 for success)
	syscall                        ; Execute the system call
