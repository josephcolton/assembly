	section .text
	global _start		; Start of program
	extern printchar	; printchar from asmlib
	extern printnum		; printnum from asmlib

_start:
	;; Display 12+34=46
	mov rdi, 12		; Print 12
	call printnum
	mov rdi, '+'		; Print +
	call printchar
	mov rdi, 34		; Print 34
	call printnum
	mov rdi, '='		; Print =
	call printchar
	mov rdi, 46		; Print 46
	call printnum
	mov rdi, 10		; Print a newline
	call printchar

	;; Exit
	mov rax, 60		; sys_exit
	mov rdi, 0		; return value
	syscall
