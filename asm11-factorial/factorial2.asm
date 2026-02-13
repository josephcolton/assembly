	section .text
	global _start

_start:
	;; Get 5! = 5*4*3*2*1 = 120
	mov rdi, 5		; arg1 = 5
	call factorial

	;; exit(result)
	mov rdi, rax		; Move result into the exit code
	mov rax, 60		; sys_exit
	syscall

factorial:
	;; factorial(n) - rdi; return value - rax
	cmp rdi, 1 		; if (arg1 <= 1) goto return 1
	jle base_case

	;; Inductive case - factorial(n-1) * n
	push rdi		; Save n
	dec rdi			; n = n - 1
	call factorial		; Call factorial(n-1)
	pop rdi			; Return n
	imul rax, rdi		; return value * n
	ret
	
base_case:
	mov rax, 1
	ret
