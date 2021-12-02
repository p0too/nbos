; the stack
[org 0x7c00]

  mov ah, 0x0e;

;set up the stack
  mov bp, 0x8000;
  mov sp, bp

  push 'A'
  push 'B'
  push 'C'

;;0x8000  ___
;        |   |
;        | A |
;;0x7ffe
;        |   |
;        | B |
;;0x7ffc
;        |   |
;        | C |
;;0x7ffa


; in other words
;0x8000
;0x8000 - 0x2 : A
;0x8000 - 0x4 : B
;0x8000 - 0x6 : C

;should print C
  ;mov bx, bp
  ;sub bx, 4h
  ;mov al, [bx]
  mov al, [8000h-6h]
  int 0x10

;should print B
  mov al, [0x8000-0x4]
  int 0x10

;should print A
  mov al, [0x8000-0x2]
  int 0x10


;pop C
  pop bx
  mov al, bl
  int 0x10

;pop B
  pop bx
  mov al, bl
  int 0x10


jmp $

str:
  db 'hello',0

times 510-($-$$) db 0
dw 0xaa55
