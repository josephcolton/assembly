section .data
    msg db "Hello world!",10
    length equ $ - msg

section .text
    global _start

_start:
    ; Print plain text
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, length
    syscall

    ; Encrypt the message
    mov rbx, 0
    mov rdx, length
loop:
    ; Single letter conversion
    movzx rax, byte [msg + rbx]  ; rax = msg[rbx]

    ; if rax < 'A': goto ink
    cmp rax, 'A'
    jl ink

    ; if rax > 'z': goto ink
    cmp rax, 'z'
    jg ink

    ; if rax <= 'Z': goto upper
    cmp rax, 'Z'
    jle upper

    ; if rax >= 'a': goto lower
    cmp rax, 'a'
    jge lower

    jmp ink

upper:
    sub rax, 'A'         ; rax -= 'A'
    mov rcx, 25          ; rcx = 25
    sub rcx, rax         ; rcx = 25 - rax
    add rcx, 'A'         ; rcx += 'A'
    mov [msg + rbx], cl  ; msg[rbx] = rcx
    jmp ink

lower:
    sub rax, 'a'         ; rax -= 'a'
    mov rcx, 25          ; rcx = 25
    sub rcx, rax         ; rcx = 25 - rax
    add rcx, 'a'         ; rcx += 'a'
    mov [msg + rbx], cl  ; msg[rbx] = rcx

ink:
    ; Increment index
    inc rbx
    cmp rbx, rdx
    jl loop

    ; Print encrypted message
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, length
    syscall

    ; Exit
    mov rax, 60
    mov rdi, 0
    syscall

