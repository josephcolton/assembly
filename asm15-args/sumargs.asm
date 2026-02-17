	section .data
	total db "Total: ",0

	section .bss
	count resq 1		; Used to store argc
	index resq 1		; Used for the index into argv
	argaddr resq 1		; Used for the address starting argv pointers
	sum resq 1		; Used to keep track of the sum
	
	section .text
	global _start

	extern printnum		; Print an unsigned integer
	extern printchar	; Print a single character
	extern printstr		; Print a string until the null character
	extern atoi		; Convert a string to an unsigned int

_start:
	;; Initialize numbers
	mov rdi, [rsp]		; Get argc from the stack [rsp]
	mov [count], rdi	; Save argc in count

	;; Loop through arguments
	mov rax, rsp		; We want to save the address for argv
	add rax, 8		; Offset to &argv[0]
	mov [argaddr], rax	; Save &argv[0]
	mov qword [index], 1	; Initialize index = 1 (Not the program name)
	mov qword [sum], 0	; Initialize sum = 0

next_arg:
	mov rax, [index]	; Load the index
	cmp rax, [count]	; if (index >= count) goto exit
	jge done
	
	;; Get the number
	mov rdi, [argaddr]	; Get the address of argv pointers
	mov rax, [index]	; Get the argv index
	imul rax, rax, 8	; Calculate offset
	add rdi, rax		; rdi = &argv[index]
	mov rdi, [rdi]		; rdi = argv[index] ; Dereference string
	call atoi		; Returns value of number in rax

	;; Add to sum
	add rax, [sum]		; rax += sum
	mov [sum], rax		; sum = rax

	;; Move to next argument
	mov rax, [index]	; rax = index ; Increment the index
	inc rax			; rax++
	mov [index], rax	; index = rax ; Save updated index

	jmp next_arg

done:
	;; Display total
	mov rdi, total		; Print "Total: "
	call printstr

	mov rdi, [sum]		; Print the sum
	call printnum

	mov rdi, 10		; Print a newline
	call printchar

	;; Exit
	mov rax, 60		; sys_exit
	mov rdi, 0		; exit code
	syscall
