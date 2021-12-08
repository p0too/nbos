print_string:
  pusha

  START_HERE:
  mov cx, [bx]  ; mov the character pointed by bx to cx
  cmp cl, 0
  je END

  mov al, cl
  mov ah, 0x0e
  int 0x10
  inc bx        ; increment bx
  jmp START_HERE


  END:          ; print newline at the end of the string
  mov al, 0xA   ; 10, Line Feed
  mov ah, 0x0e
  int 0x10

  mov al, 0xD   ; 13, Carriage Return
  mov ah, 0x0e
  int 0x10

  popa
  ret
