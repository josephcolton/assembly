	section .text
	global printchar	; Print a single character (rdi->stdout)
	global printnum		; Print a number (rdi->stdout)
	global printoctal	; Print an octal number (rdi->stdout)
	global printstr		; Print a string to null character
	global atoi		; Convert a string to an unsigned int (rdi->rax)

;;; Print a single character to the screen
;;; Input: rdi - Character value
printchar:
	dec rsp			; Decrement stack pointer
	mov [rsp], dil		; Mov lower byte from rdi into the stack
	mov rax, 1		; sys_write
	mov rdi, 1		; stdout
	mov rsi, rsp		; Write location in the stack
	mov rdx, 1		; Number of bytes to write
	syscall			; Call write
	inc rsp			; Increment stack pointer
	ret			; Return from function call

;;; Print an unsigned int to the screen
;;; Input: rdi - Unsigned integer
printnum:
	push rbx		; Preserve callee-saved register
	;; Initialization
	sub rsp, 32		; Allocate 32 bytes on the stack (from rsp to rsp+31)
	mov rax, rdi		; Number to print (arg1)
	mov rbx, 10		; Divisor (base 10)
	mov rsi, rsp		; Point rsi to the stack pointer buffer[0]
	add rsi, 31		; Point to the end of the buffer buffer[31]
	mov byte [rsi], 0	; buffer[31] = 0 (NULL)
	mov rcx, 0		; Digit count (for string length)

printnum_loop:
	xor rdx, rdx		; Clear remainder - mov rdx, 0
	div rbx			; rax = rax/10 (result), rdx = rax%10 (remainder)

	add rdx, '0'		; Add '0' to convert rdx to ASCII value
	dec rsi			; Move the buffer pointer (next digit position)
	mov [rsi], dl		; Put lower byte from rdx in buffer
	inc rcx			; Increment digit count

	cmp rax, 0		; if (rax > 0) goto printnum_loop (next digit)
	jg printnum_loop

	;; Write number in buffer
	mov rax, 1		; sys_write
	mov rdi, 1		; stdout
	;; rsi already pointing to the buffer location
	mov rdx, rcx		; Length
	syscall

	add rsp, 32		; Free the stack buffer
	pop rbx			; Restore callee-saved register
	ret


;;; Print an unsigned octal number to the screen
;;; Input: rdi - Unsigned octal
printoctal:
	push rbx		; Preserve callee-saved register
	;; Initialization
	sub rsp, 32		; Allocate 32 bytes on the stack (from rsp to rsp+31)
	mov rax, rdi		; Number to print (arg1)
	mov rbx, 8		; Divisor (base 8)
	mov rsi, rsp		; Point rsi to the stack pointer buffer[0]
	add rsi, 31		; Point to the end of the buffer buffer[31]
	mov byte [rsi], 0	; buffer[31] = 0 (NULL)
	mov rcx, 0		; Digit count (for string length)

printoctal_loop:
	xor rdx, rdx		; Clear remainder - mov rdx, 0
	div rbx			; rax = rax/8 (result), rdx = rax%8 (remainder)

	add rdx, '0'		; Add '0' to convert rdx to ASCII value
	dec rsi			; Move the buffer pointer (next digit position)
	mov [rsi], dl		; Put lower byte from rdx in buffer
	inc rcx			; Increment digit count

	cmp rax, 0		; if (rax > 0) goto printnum_loop (next digit)
	jg printoctal_loop

	;; Write number in buffer
	mov rax, 1		; sys_write
	mov rdi, 1		; stdout
	;; rsi already pointing to the buffer location
	mov rdx, rcx		; Length
	syscall

	add rsp, 32		; Free the stack buffer
	pop rbx			; Restore callee-saved register
	ret


;;; Print until a null is reached
;;; Input: rdi - string
printstr:
	mov rcx, rdi		; rcx = address of string[0]
printstr_loop:
	movzx rsi, byte [rdi]	; ch = rdi[0]
	test rsi, rsi		; if (ch == 0) goto printstr_print
	je printstr_print

	inc rdi			; rdi++ ; next character
	jmp printstr_loop
printstr_print:
	mov rdx, rdi		; Current address of the string
	sub rdx, rcx		; Subtract original address for length
	mov rax, 1		; sys_write
	mov rdi, 1		; stdout
	mov rsi, rcx		; Original address of string
	syscall
	ret

;;; Convert a string to an unsigned integer
;;; Input: rdi - number string address
;;; Output: rax - Unsigned integer value (-1 on error)
atoi:
        xor rax, rax            ; Value = 0

atoi_convert:
        movzx rsi, byte [rdi]   ; Load a character into rsi
        test rsi, rsi           ; if (ch == 0) goto atoi_done
        je atoi_done

        cmp rsi, 10             ; if (ch == '\n') goto atoi_done
        je atoi_done

        cmp rsi, '0'            ; if (ch < '0') goto atoi_error
        jl atoi_error

        cmp rsi, '9'            ; if (ch > '9') goto atoi_error
        jg atoi_error

        sub rsi, '0'            ; Convert ASCII digit to a number 0-9
        imul rax, rax, 10       ; rax *= 10 ; Shift value and make space
        add rax, rsi            ; rax += rsi ; Add the digit to the space

        inc rdi                 ; Move to next character in buffer
        jmp atoi_convert

atoi_error:
        mov rax, -1             ; -1 for error

atoi_done:
        ret

