; print string in protected mode (32-bit mode)
; why? cause BIOS functions are not available once we switch from 16 to 32 bit

[bits 32]   ; important to specify this as this function is meant to be used in 32-bit protected mode
; constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f
YELLOW_ON_BLUE equ 0x1e


print_string_pm:
  pusha
  ; as usual string to be printed is pointed to by EBX

  mov edx, VIDEO_MEMORY

print_string_pm_loop:
  mov al, [ebx]   ; mov the character to be printed
  mov ah, YELLOW_ON_BLUE    ; it's attributes (background, foreground, blinking etc)

  cmp al, 0       ; check for null termination of string
  je print_string_pm_end

  mov [edx], ax   ; mov the character with attributes to the video memory


  add ebx, 1      ; next character in string
  add edx, 2      ; next cell in video memory

  jmp print_string_pm_loop

print_string_pm_end:

  popa
  ret
