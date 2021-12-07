; Boot Sector for switching to 32-bit pm
[org 0x7c00]

  mov bp, 0x9000    ; set the stack 16-bit real mode
  mov sp, bp

  mov bx, MSG_REAL_MODE
  call print_string

  call switch_to_pm   ; we don't return from here

  jmp $

%include "print_string.asm"
%include "gdt.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"

;-------------------------;

; [bits 32]  ; don't really need to specify this here as it's specified at switch_to_pm: init_pm (where we're jumping from)
; we arrive here after switching and initialising protected mode
BEGIN_PM:

  mov ebx, MSG_PROT_MODE  ; just print a message then hang
  call print_string_pm    ; use 32-bit print function

  jmp $   ; hang


; global variables
MSG_PROT_MODE db "2. Successfully landed in 32-bit Protected Mode",0
MSG_REAL_MODE db "1. Started in 16-bit Real Mode",0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55
