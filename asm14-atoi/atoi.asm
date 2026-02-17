	section .data
	prompt db "Enter a number from 0 to 255: ",0
	promptlen equ $ - prompt

	section .bss
	buffer resb 64		; Buffer for reading input

	section .text
	global _start

_start:
	;; Print prompt for number
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

	;; Call atoi function
	mov rdi, buffer		; Address of the entered number string
	call atoi		; Call the atoi function

	;; Exit
	mov rdi, rax		; Set exit code to return value
	mov rax, 60		; sys_exit
	syscall

atoi:
	;; Convert a string to an unsigned integer
	;; Input: rdi - number string address
	;; Output: rax - Unsigned integer value (-1 on error)
	xor rax, rax		; Value = 0

atoi_convert:
	movzx rsi, byte [rdi]	; Load a character into rsi
	test rsi, rsi		; if (ch == 0) goto atoi_done
	je atoi_done

	cmp rsi, 10		; if (ch == '\n') goto atoi_done
	je atoi_done

	cmp rsi, '0'		; if (ch < '0') goto atoi_error
	jl atoi_error

	cmp rsi, '9'		; if (ch > '9') goto atoi_error
	jg atoi_error

	sub rsi, '0'		; Convert ASCII digit to a number 0-9
	imul rax, rax, 10	; rax *= 10 ; Shift value and make space
	add rax, rsi		; rax += rsi ; Add the digit to the space

	inc rdi			; Move to next character in buffer
	jmp atoi_convert

atoi_error:
	mov rax, -1		; -1 for error

atoi_done:
	ret
