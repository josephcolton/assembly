	section .text
	global _start

_start:
	;; Get 5! = 5*4*3*2*1 = 120
	mov rdi, 5		; Set arg1 = 5
	call factorial		; Call the function
	mov rdi, rax		; Set answer to exit code
	jmp exit

factorial:
	;; arg1 - rdi
	;; Return value - rax
	mov rax, 1		; Default return value
loop:
	cmp rdi, 1		; if (arg1 <= 1) got done
	jle done

	imul rax, rdi		; return value *= arg1
	dec rdi			; arg1 -= 1
	jmp loop
done:
	;; Set return value
	ret			; Return


exit:
	mov rax, 60		; sys_exit
	;; rdi - return value
	syscall
