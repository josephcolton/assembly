	section .bss
	buffer resb 4096
	infile resq 1
	outfile resq 1
	fhin resq 1
	fhout resq 1
	bytes resq 1
	
	section .text
	global _start

_start:
	;; Set infile pointer to argv[1]
	mov rax, [rsp + 16]
	mov [infile], rax

	;; Set outfile pointer to argv[2]
	mov rax, [rsp + 24]
	mov [outfile], rax

	;; Open infile
	mov rax, 2		; sys_open
	mov rdi, [infile]	; filename
	mov rsi, 0		; Read only
	mov rdx, 0		; Mode (not used)
	syscall
	mov [fhin], rax		; Save file handle

	;; Open outfile
	mov rax, 2		; sys_open
	mov rdi, [outfile]	; filename
	mov rsi, 65		; 1=O_WRONLY, 64=O_CREAT
	mov rdx, 0o644		; Mode in octal: rw-r--r--
	syscall
	mov [fhout], rax	; Save file handle

	;; Copy Loop
copyfile:
	;; Read bytes
	mov rax, 0		; sys_read
	mov rdi, [fhin]		; infile
	mov rsi, buffer		; Page buffer
	mov rdx, 4096		; Max bytes to read
	syscall

	;;  Save number of bytes read
	cmp rax, 0		; if (rax <= 0) goto close
	jle close
	mov [bytes], rax	; Bytes read

	;; Write bytes
	mov rax, 1		; sys_write
	mov rdi, [fhout]	; outfile
	mov rsi, buffer		; Page buffer
	mov rdx, [bytes]	; bytes to write
	syscall

	jmp copyfile

close:
	;; Close infile
	mov rax, 3		; sys_close
	mov rdi, [fhin]		; infile
	syscall

	;; Close outfile
	mov rax, 3		; sys_close
	mov rdi, [fhout]	; outfile
	syscall

exit:
	mov rax, 60		; sys_exit
	mov rdi, 0		; exit code
	syscall
