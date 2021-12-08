; control structures

; convert following to asm
; if(bx <= 4) {
;   mov al, 'A'
; } else if(bx < 40) {
;   mov al, 'B'
; } else {
;   mov al, 'C'
; }

  mov bx, 30

  cmp bx, 4
  jle label_A

  cmp bx, 40
  jl label_B

  jmp label_C


label_A:
  mov al, 'A'
  jmp print

label_B:
  mov al, 'B'
  jmp print

label_C:
  mov al, 'C'
  jmp print


print:
  mov ah, 0x0e
  int 0x10


jmp $

times 510-($-$$) db 0
dw 0xaa55
