; function

  [org 0x7c00]

  mov al, 'Z'
  call the_print_function

  jmp $

the_print_function:
  pusha
  mov ah, 0x0e
  int 0x10
  popa
  ret


  times 510-($-$$) db 0
  dw 0xaa55
