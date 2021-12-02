; print_hex
[org 0x7c00]

mov dx, 0xC1A4     ; want to print this hex number
call print_hex


jmp $

%include "print_string.asm"

print_hex:
  pusha
  mov bx, HEX_OUT + 5 ;point to the end char of string before null
  mov cx, 0x4         ;loop counter, fixed coz 16-bit real mode has 16-bit addressed to deal with

  LOOP:
  cmp cx, 0        ;loop condition
  je END_LOOP

  mov al, dl
  and al, 0x0F

  cmp al, 0x9     ;check if a number (0..9)
  jg ALPHABET     ;if not number(0..9), then it's a alphabet (a..f)
  add al, 0x30    ;if number add 30H to get ASCII value
  jmp COMMON_STEP

  ALPHABET:       ;if alphabet
  add al, 0x37    ;add 37h or 55d to make it A(41h or 65d)...F

  COMMON_STEP:
  mov [bx], al    ;mov the ASCII val to suitable place in string HEX_OUT
  dec bx          ;Writing string HEX_OUT from end to front, so decrement bx
  shr dx, 4       ;get the next digit to the right
  dec cx          ;decrement loop counter
  jmp LOOP        ;loop

  END_LOOP:
  mov bx, HEX_OUT
  call print_string
  popa
  ret


; Data
HEX_OUT:
  db '0x0000', 0


times 510-($-$$) db 0
dw 0xaa55
