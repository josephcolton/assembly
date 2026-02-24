	section .data
	filename db "outfile.txt",0
	prompt db "Type file contents (blank line to stop).",10,0
	promptlen equ $ - prompt

	section .bss
	buffer resb 256		; Buffer for reading file
	fd resq 1		; File descriptor variable
	bytes resq 1		; Bytes read

	section .text
	global _start

_start:
	;; Open file for writing
	mov rax, 2		; sys_open
	mov rdi, filename	; Pointer to filename
	mov rsi, 65		; Open for writing flags: O_WRONLY=1, O_WRONLY=64
	mov rdx, 0o644		; Mode in octal: rw-r--r--
	syscall

	;; See if the open was successful
	cmp rax, 0		; Return value < 0 on error
	jl exit
	mov [fd], rax		; Save file descriptor

	;; Prompt user for input
	mov rax, 1		; sys_write
	mov rdi, 1		; stdout
	mov rsi, prompt		; Pointer to prompt
	mov rdx, promptlen	; Length of prompt
	syscall

getinput:
	;; Read file
	mov rax, 0		; sys_read
	mov rdi, 0		; stdin file descriptor
	mov rsi, buffer		; Buffer for reading from file
	mov rdx, 256		; Max bytes to read
	syscall

	;; See if we read any bytes
	cmp rax, 0		; 0 = End of file, <0 = error
	jle closefile
	mov [bytes], rax	; Save the number of bytes read

	;; See if the first character was a newline
	cmp byte [buffer], 10
	je closefile

	;; Print file contents
	mov rax, 1		; sys_write
	mov rdi, [fd]		; outfile file descriptor
	mov rsi, buffer		; Buffer from stdin
	mov rdx, [bytes]	; Bytes entered
	syscall

	;; Continue getting input until a newline
	jmp getinput

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
