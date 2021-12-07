; Boot Sector for switching to 32-bit pm
[org 0x7c00]
KERNEL_OFFSET equ 0x1000  ; memory offset where kernel will be loaded

  mov [BOOT_DRIVE], dl  ; BIOS stores boot drive in dl; remember for later

  mov bp, 0x9000    ; set the stack 16-bit real mode
  mov sp, bp

  mov bx, MSG_REAL_MODE   ; print message
  call print_string

  call load_kernel    ; load the kernel

  call switch_to_pm   ; we don't return from here

  jmp $

%include "print_string.asm"
%include "disk_load.asm"
%include "gdt.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"

;-------------------------;

[bits 16]

load_kernel:
  pusha

  mov bx, MSG_LOAD_KERNEL   ; print message
  call print_string

  mov bx, KERNEL_OFFSET   ; set up parameters for disk_load routine
  mov dh, 15              ; so that 15 sectors are loaded (excl boot sector)
  mov dl, [BOOT_DRIVE]    ; from the boot disk (i.e. our kernel code) to the address KERNEL_OFFSET
  call disk_load

  popa
  ret

;-------------------------;

[bits 32]  ; We do need to specify this here
; we arrive here after switching and initialising protected mode
BEGIN_PM:

  mov ebx, MSG_PROT_MODE  ; just print a message then hang
  call print_string_pm    ; use 32-bit print function

  call KERNEL_OFFSET  ; finally jump to the address of the loaded kernel code

  jmp $   ; hang


; global variables
BOOT_DRIVE db 0
MSG_REAL_MODE db "1. Started in 16-bit Real Mode",0
MSG_LOAD_KERNEL db "2. Loading Kernel into memory",0
MSG_PROT_MODE db "3. Successfully landed in 32-bit Protected Mode",0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55
