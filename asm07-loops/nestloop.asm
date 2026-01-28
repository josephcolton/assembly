	section .data
	cols dd 5
	rows dd 3
	star db "*"
	newline db 10

	section .text
	global _start

_start:
	movsx rcx, dword [rows]	; Get the number of rows

outer_loop:
	movsx rbx, dword [cols]	; Get the number of columns
	dec rcx			; Number of remaining rows

;;; Write a full row
inner_loop:
	cmp rbx, 0
	jle inner_end	; Jump out if rbx <= 0
	dec rbx		; Decrement rbx

	;; Write a star
	mov rax, 1	; System call number for sys_write
	mov rdi, 1	; File descriptor for stdout (1)
	mov rsi, star	; Print
	mov rdx, 1	; Number of characters to write

	push rbx	; Save rbx register
	push rcx	; Save rcx register
	syscall		; Execute the system call
	pop rcx		; Restore rcx register
	pop rbx		; Restore rbx register

	jmp inner_loop

inner_end:
	;; Write a newline
	mov rax, 1	 ; System call number for sys_write
	mov rdi, 1	 ; File descriptor for stdout (1)
	mov rsi, newline ; Print
	mov rdx, 1	 ; Number of characters to write

	push rbx	; Save rbx register
	push rcx	; Save rcx register
	syscall		; Execute the system call
	pop rcx		; Restore rcx register
	pop rbx		; Restore rbx register

	;; See if we have more rows
	cmp rcx, 0
	jg outer_loop

;;; Exit the program
end:
	;; System call for sys_exit (exit the program)
	mov rax, 60      ; System call number for sys_exit
	mov rdi, 0       ; Exit status (0 for success)
	syscall          ; Execute the system call
