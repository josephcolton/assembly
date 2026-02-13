	section .text
	global printchar	; Print a single character (rdi)
	global printnum		; Print a number (rdi)

printchar:
	dec rsp			; Decrement stack pointer
	mov [rsp], dil		; Mov lower byte from rdi into the stack
	mov rax, 1		; sys_write
	mov rdi, 1		; stdout
	mov rsi, rsp		; Write location in the stack
	mov rdx, 1		; Number of bytes to write
	syscall			; Call write
	inc rsp			; Increment stack pointer
	ret			; Return from function call

printnum:
	push rbx		; Preserve callee-saved register
	;; Initialization
	sub rsp, 32		; Allocate 32 bytes on the stack (from rsp to rsp+31)
	mov rax, rdi		; Number to print (arg1)
	mov rbx, 10		; Divisor (base 10)
	mov rsi, rsp		; Point rsi to the stack pointer buffer[0]
	add rsi, 31		; Point to the end of the buffer buffer[31]
	mov byte [rsi], 0	; buffer[31] = 0 (NULL)
	mov rcx, 0		; Digit count (for string length)

printnum_loop:
	xor rdx, rdx		; Clear remainder - mov rdx, 0
	div rbx			; rax = rax/10 (result), rdx = rax%10 (remainder)

	add rdx, '0'		; Add '0' to convert rdx to ASCII value
	dec rsi			; Move the buffer pointer (next digit position)
	mov [rsi], dl		; Put lower byte from rdx in buffer
	inc rcx			; Increment digit count

	cmp rax, 0		; if (rax > 0) goto printnum_loop (next digit)
	jg printnum_loop

	;; Write number in buffer
	mov rax, 1		; sys_write
	mov rdi, 1		; stdout
	;; rsi already pointing to the buffer location
	mov rdx, rcx		; Length
	syscall

	add rsp, 32		; Free the stack buffer
	pop rbx			; Restore callee-saved register
	ret
