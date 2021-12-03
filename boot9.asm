; Extended Memory Access Using Segments

; four ways to do the task
; 2 & 4 work

; Notes:
; In 16-bit real mode the highest address we can reference in an instruction is 0xffff (which amounts to 64 KB)
; with segments this becomes 0xffff * 16 + 0xffff (1 MB)

  mov ah, 0x0e

; 1
  mov al, [the_secret]    ; we haven't specified [org 0x7c00], so it's not offseted correctly
  int 0x10

; 2
; following calculation takes place when using segment register
; 0x7c0 * 16 = 0x7c00
; 0x7c00 + the_secret = our_address
  mov bx, 0x7c0   ; can't set ds directly, so move the value in bx
  mov ds, bx      ; set ds via bx
  mov al, [the_secret]    ; offset the address by using segment register appropriate for the context, here it's ds
  int 0x10


; 3
  mov al, [es:the_secret]   ; can also instruct the cpu which segment register to use to offset the address
  int 0x10                  ; just that es is not set here

; 4
  mov bx, 0x7c0
  mov es, bx
  mov al, [es:the_secret]
  int 0x10



  jmp $

the_secret:
  db "X"


  times 510-($-$$) db 0
  dw 0xaa55
