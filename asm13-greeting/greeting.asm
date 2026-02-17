	section .data
	prompt db "What is your name? ",0
	promptlen equ $ - prompt

	greeting db "Hello ",0
	greetinglen equ $ - greeting

	section .bss
	buffer resb 64		; Buffer for reading input
	length resq 1		; Length of characters read

	section .text
	global _start

_start:
	;; Print name prompt
	mov rax, 1		; sys_write
	mov rdi, 1		; stdout
	mov rsi, prompt		; Prompt string
	mov rdx, promptlen	; Length of string
	syscall

	;; Read from STDIN
	mov rax, 0		; sys_read
	mov rdi, 0		; stdin
	mov rsi, buffer		; Buffer for reading data
	mov rdx, 63		; Space to allow in buffer (-1 for null)
	syscall
	mov [length], rax	; Characters read in (includes newline)

	;; Display Greeting
	mov rax, 1		; sys_write
	mov rdi, 1		; stdout
	mov rsi, greeting	; Greeting string
	mov rdx, greetinglen	; Length of string
	syscall

	;; Print name
	mov rax, 1		; sys_write
	mov rdi, 1		; stdout
	mov rsi, buffer		; Buffer (should have copied out)
	mov rdx, [length]	; Length of bytes read in
	syscall

	;; Exit
	mov rax, 60		; sys_exit
	mov rdi, 0		; exit code
	syscall
