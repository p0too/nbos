; provides entry point to kernel code

[bits 32]
[extern main] ; for referencing external symbol 'main' so that linker can substitute the final address

  call main   ; invoke main() in C kernel

  jmp $
