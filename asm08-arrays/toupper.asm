	section .data
        string db "Hello World!",0  ; The string, followed by a null (0)

	section .bss
	outstr resb 32		; Create an uninitialized outstr for output

	section .text
	global _start		; Declare _start as a global

_start:
	mov rsi, string		; Index for input string
	mov rdi, outstr		; Index for output outstr

convert_loop:
	mov al, [rsi]		; rax = string[index] // rsi is a pointer to the string position
	cmp al, 0		; if (rax == 0) goto done_convert // See if we are done
	je done_convert		;

	cmp al, 'a'		; if (rax < 'a') goto not_lower   // Less than a lowercase letter
	jl not_lower
	cmp al, 'z'		; if (rax > 'z') goto not_lower   // Greater than a lowercase letter
	jg not_lower

	sub al, 32		; convert to uppercase ('a' - 'A' = 32)

not_lower:
	mov [rdi], al		; outstr[index] = rax // rdi is a pointer to the outstr position

	inc rsi			; rsi++ // Increment the string pointer
	inc rdi			; rdi++ // Increment the outstr pointer
	jmp convert_loop

done_convert:
	mov byte [rdi], 10      ; Put a newline at the end
	inc rdi			; rdi++ // Increment the outste pointer (for length)

	; Calculate length = rdi - outstr
	lea rbx, [rel outstr]	; Same as mov rbx, outste
	mov rdx, rdi		; rdx = rdi // Getting ready for subtraction
	sub rdx, rbx		; rdx = length of output // rdx is used for length in sys_write

	; Print string in outstr
	mov rax, 1		; sys_write
	mov rdi, 1		; stdout
	lea rsi, [rel outstr]	; Same as mov rsi, outstr // Location of outstr
	syscall

	; exit(0)
	mov rax, 60              ; sys_exit
	xor rdi, rdi             ; rdi = 0 (exit code)
	syscall
