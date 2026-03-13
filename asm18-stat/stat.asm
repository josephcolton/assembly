	section .data
	usage db "Usage:",10,"stat FILENAME",10,0
	str_file db "File: ",0
	str_size db "Size: ",0
	str_mode db "Mode: ",0
	str_filetype db "File Type: ",0

	section .bss
	buffer resb 144		; Space for the stat buffer

	section .text
	global _start

	extern printnum		; Print a number (from asmlib.asm)
	extern printoctal	; Print a number in octal
	extern printstr		; Print a string to the newline
	extern printchar	; Print a single character

_start:
	;; argc
	mov rax, [rsp]		; argc
	cmp rax, 2		; if (argc < 2) goto show_usage
	jl show_usage

	;; Print "File: FILENAME"
	mov rdi, str_file	; Print "File: "
	call printstr
	mov rdi, [rsp+16]	; Print the argv[1] - Filename
	call printstr
	mov rdi, 10		; Print a newline
	call printchar

	;; Call newfstatat syscall
	mov rax, 262		; sys_newfstatat
	mov rdi, -100		; AT_FDCWD - File Descriptor of Current Working Directory
	mov rsi, [rsp+16]	; argv[1] - Filename
	mov rdx, buffer		; Buffer for stat
	mov r10, 0		; Flags
	syscall

	cmp rax, 0		; if error goto exit
	jl exit

	;; Print "Size: ####"
	mov rdi, str_size	; Print "Size: "
	call printstr

	mov rdi, [buffer+48]	; Print size
	call printnum
	mov rdi, 10		; Print a newline
	call printchar

	;; Print "Mode: ###"
	mov rdi, str_mode	; Print "Mode: "
	call printstr

	mov rax, [buffer+24]	; Extract mode
	and rax, 07777o		; Get the permission part
	mov rdi, rax		; Print in octal
	call printoctal
	mov rdi, 10		; Print a newline
	call printchar

	;; Print "File Type: ##"
	;; Directory    = 0o4  (Dec 4)
	;; Regular File = 0o10 (Dec 8)
	mov rdi, str_filetype	; Print "File Type: "
	call printstr

	mov rax, [buffer+24]	; Extract mode
	and rax, 0170000o	; Get file type part
	shr rax, 12		; Shift over to see file type value
	mov rdi, rax		; Print in octal
	call printoctal
	mov rdi, 10		; Print a newline
	call printchar

	;; Print an extra newline
	mov rdi, 10		; Print a newline
	call printchar

exit:
	mov rax, 60		; sys_exit
	xor rdi, rdi		; exit code = 0
	syscall

show_usage:
	mov rdi, usage		; Print usage
	call printstr

	mov rax, 60		; sys_exit
	mov rdi, 1		; exit code = 1
	syscall
