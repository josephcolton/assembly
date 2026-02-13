	section .text
	global _start
        extern printchar        ; printchar from asmlib
        extern printnum         ; printnum from asmlib

_start:
	mov rcx, 10		; Total rows to display
	mov r9, 0		; Current row index=0

nextRow:
	;; Initialize the row
	mov r8, 0		; Current column index=0

nextCol:
	;; Print the columns in the row
	;; Get rax = pascal(row, column)
	push rcx		; Save the number of rows
	mov rdi, r9		; row index
	mov rsi, r8		; column index
	call pascal
	pop rcx			; Restore the number of rows
	
	;; Print the number
	mov rdi, rax		; Move return value to arg1
	push rcx		; Save the number of rows	
	call printnum
	pop rcx			; Restore the number of rows

	;; Print a space
	mov rdi, ' '		; Space character
	push rcx		; Save the number of rows	
	call printchar
	pop rcx			; Restore the number of rows

	;; Next column - column++
	inc r8	    		; column++
	cmp r8, r9		; if (current column <= current row) keep printing
	jle nextCol

	;; End the current row
	;; Print a newline (end of the row)
	mov rdi, 10		; Newline ASCII value
	push rcx		; Save the number of rows
	call printchar
	pop rcx			; Restore the number of rows

	;; Increment the row index
	inc r9			; row++
	cmp r9, rcx		; if (current row <= total rows) print next row
	jle nextRow
    
	;; I guess we are done now
	jmp exit

pascal:
	;; Arguments
	;; rdi = arg1 (row)
	;; rsi - arg2 (column)

	push rbx		; Preserve callee-saved register
	
	;; Base cases
	cmp rsi, 0		; if (column == 0) return 1
	jz pascal_base
	cmp rsi, rdi		; if (column == row) return 1
	je pascal_base

	;; Save this current index
	push rdi		; Save row
	push rsi		; Save column

	;; Get value from pascal(row-1, col)
	dec rdi			; row--
	call pascal		; result in rax
	push rax		; Save first return value

	;; Get value from pascal(row-1, col-1)
	dec rsi			; col--
	call pascal		; result in rax
	pop rbx			; put first value in rbx
	add rax, rbx		; rax = pascal(row-1, col-1) + pascal(row-1, col)

	pop rsi			; Restore column
	pop rdi			; Restore row
	pop rbx			; Restore callee-saved register
	ret			; Return value in rax

pascal_base:
	;; Base case - return 1
	pop rbx			; Restore callee-saved register
	mov rax, 1		; Return value in rax is 1
	ret


exit:
	mov rax, 60		; sys_exit
	mov rdi, 0		; exit code
	syscall
