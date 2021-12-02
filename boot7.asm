; Boot sector that prints a string

[org 0x7c00]

mov bx, HELLO_MSG  ; parameter(address of string) is in bx
call print_string

mov bx, GOODBYE_MSG  ; parameter(address of string) is in bx
call print_string


jmp $

%include "print_string.asm"

; Data
HELLO_MSG:
  db 'hello, world', 0

GOODBYE_MSG:
  db 'goodbye', 0

; padding & magic number
times 510-($-$$) db 0
dw 0xaa55
