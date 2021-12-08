; Define GDT

gdt_start:
  
gdt_null:     ; gdt's first entry should be null, a null descriptor
  dd 0x0      ; dd -> double word i.e. 4 bytes
  dd 0x0

gdt_code:     ; code segment descriptor
  ; base=0x0 (32 bits), limit=0xfffff (20 bits)
  ; 1st flags: present-1, privelege-00, descriptor_type-1  => 1001b
  ; type flags: code-1, conforming-0, readable-1, accessed-0  => 1010b
  ; 2nd flags: granularity-1, 32-bit_default-1, 64-bit_seg-0, AVL=0   =>1100b
  dw 0xffff     ; Limit (bits 0-15)
  dw 0x0        ; Base (bits 0-15)
  db 0x0        ; Base (bits 16-23)
  db 10011010b  ; 1st flags and type flags
  db 11001111b  ; 2nd flags and Limit(bits 16-19)
  db 0x0        ; Base (bits 24-31)

gdt_data:
  ; same as code segment with type flags changed
  ; type flags: code-0, conforming-0, readable-1, accessed-0  => 0010b
  dw 0xffff     ; Limit (bits 0-15)
  dw 0x0        ; Base (bits 0-15)
  db 0x0        ; Base (bits 16-23)
  db 10010010b  ; 1st flags and type flags
  db 11001111b  ; 2nd flags and Limit(bits 16-19)
  db 0x0        ; Base (bits 24-31)

gdt_end:    ; label to easily calculate gdt size


; GDT descriptor (6 bytes)
  ; gdt size (16 bits)
  ; gdt address (32 bits)
gdt_descriptor:
  dw gdt_end - gdt_start - 1
  dd gdt_start

; handy constants for GDT segment descriptor offsets.
; 0x0 -> NULL segment descriptor
; 0x8 -> CODE segment descriptor
; 0x10 -> DATA segment descriptor
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
