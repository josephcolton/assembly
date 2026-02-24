	section .data
	filename db "haiku.txt",0

	section .bss
	buffer resb 4096	; Buffer for reading file
	fd resq 1		; File descriptor variable
	bytes resq 1		; Bytes read

	section .text
	global _start

_start:
	;; Open file
	mov rax, 2		; sys_open
	mov rdi, filename	; Pointer to filename
	mov rsi, 0		; Read only flag: O_RDONLY
	mov rdx, 0		; Permission Mode (unused)
	syscall

	;; See if the open was successful
	cmp rax, 0		; Return value < 0 on error
	jl exit
	mov [fd], rax		; Save file descriptor

readfile:
	;; Read file
	mov rax, 0		; sys_read
	mov rdi, [fd]		; File descriptor
	mov rsi, buffer		; Buffer for reading from file
	mov rdx, 4096		; Max bytes to read
	syscall

	;; See if we read any bytes
	cmp rax, 0		; 0 = End of file, <0 = error
	jle closefile
	mov [bytes], rax	; Save the number of bytes read
	
	;; Print file contents
	mov rax, 1		; sys_write
	mov rdi, 1		; stdout
	mov rsi, buffer		; File contents
	mov rdx, [bytes]
	syscall

	;; Continue reading until the end of the file
	jmp readfile

closefile:
	;; Close file descriptor
	mov rax, 3		; sys_close
	mov rdi, [fd]
	syscall

exit:
	;; Exit
	mov rax, 60		; sys_exit
	mov rdi, 0		; exit code
	syscall
