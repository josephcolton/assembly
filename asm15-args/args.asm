	section .data
	heading db "Arguments: ",0
	argstrA db "arg[",0
	argstrB db "] = '",0
	argstrC db "'",10,0

	section .bss
	count resq 1		; Used to store argc
	index resq 1		; Used for the index into argv
	argaddr resq 1		; Used for the address starting argv pointers

	section .text
	global _start

	extern printnum		; Print an unsigned integer
	extern printchar	; Print a single character
	extern printstr		; Print a string until the null character

_start:
	;; Display the command line arguments

	;; Display the program heading
	mov rdi, heading	; Print the heading
	call printstr

	mov rdi, [rsp]		; Get argc from the stack [rsp]
	mov [count], rdi	; Save argc in count
	call printnum		; Print argc

	mov rdi, 10		; Print a newline
	call printchar

	;; Loop through arguments
	mov rax, rsp		; We want to save the address for argv
	add rax, 8		; Offset to &argv[0]
	mov [argaddr], rax	; Save &argv[0]
	mov qword [index], 0	; Initialize index to 0

next_arg:
	mov rax, [index]	; Load the index
	cmp rax, [count]	; if (index >= count) goto exit
	jge exit
	
	;; arg[
	mov rdi, argstrA	; Print the first part of the string
	call printstr

	;; Display Argument number
	mov rdi, [index]	; Print the index number
	call printnum

	;; ] = '
	mov rdi, argstrB	; Print the next part of the string
	call printstr

	;; Display argument value
	mov rdi, [argaddr]	; Get the address of argv pointers
	mov rax, [index]	; Get the argv index
	imul rax, rax, 8	; Calculate offset
	add rdi, rax		; rdi = &argv[index]
	mov rdi, [rdi]		; rdi = argv[index] ; Dereference string
	call printstr		; Print argument

	;; '\n
	mov rdi, argstrC	; Print the end of the string
	call printstr
	
	mov rax, [index]	; rax = index ; Increment the index
	inc rax			; rax++
	mov [index], rax	; index = rax ; Save updated index

	jmp next_arg
exit:
	;; Exit
	mov rax, 60		; sys_exit
	mov rdi, 0		; exit code
	syscall
