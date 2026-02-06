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
    add rax, 3           ; rax += 3
    mov rdx, 0		 ; rdx = 0 (clear remainder)
    mov rcx, 26		 ; rcx = 26
    div rcx		 ; Remainder in rdx
    add rdx, 'A'         ; rdx += 'A'
    mov [msg + rbx], dl  ; msg[rbx] = rdx
    jmp ink

lower:
    sub rax, 'a'         ; rax -= 'a'
    add rax, 3           ; rax += 3
    mov rdx, 0		 ; rdx = 0 (clear remainder)
    mov rcx, 26		 ; rcx = 26
    div rcx		 ; Remainder in rdx
    add rdx, 'a'         ; rdx += 'a'
    mov [msg + rbx], dl  ; msg[rbx] = rdx

ink:
    ; Increment index
    inc rbx
    mov rdx, length
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

