	section .data
	count dq 5		; count = 5
        array dq 1,2,3,4,5	; array = [1,2,3,4,5] // dq is quadword (8 bytes)
	result dq 0

	section .text
	global _start		; Declare _start as a global

_start:
	mov rax, 0		; rax = 0 // Array index
	mov rbx, [result]	; rbx = 0 // Result start as zero
	mov rcx, [count]	; rcx = 5 // Number of items in the array
	
loop:
	cmp rax, rcx		; if (rax >= rcx) goto done
	jge done

	; rdx = array[rax] // Get number at quadword location - multiply index by 8 (quadword)
	mov rdx, [array + rax * 8]
	add rbx, rdx		; rbx += rdx
	mov [result], rbx	; result = rbx // Save on each loop
	inc rax			; rax++ // Increment the index
	jmp loop

done:
	; exit(0)
	mov rax, 60		; sys_exit
	mov rdi, [result]	; rdi = result (exit code)
	syscall
