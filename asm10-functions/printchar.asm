	section .text
	global _start

_start:
	;; Function Input (rdi, rsi, rdx, rcx, r8, r9)
	;; Function Output (rax) Return Value
	mov rdi, 'h'
	call printchar
	mov rdi, 'e'
	call printchar
	mov rdi, 'l'
	call printchar
	mov rdi, 'l'
	call printchar
	mov rdi, 'o'
	call printchar

	jmp exit

printchar:
	dec rsp			; decrement stack pointer
	mov [rsp], dil		; lowest byte of rdi
	
	mov rax, 1		; sys_write
	mov rdi, 1		; stdout
	mov rsi, rsp		; Location of the string
	mov rdx, 1		; Size
	syscall

	inc rsp			; increment stack pointer
	ret			; Return

exit:
	mov rax, 60		; sys_exit
	mov rdi, 0		; return value
	syscall
