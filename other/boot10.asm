; Using BIOS to Read the Disk

  [org 0x7c00]

  mov ah, 0x02  ; BIOS read sector function

  mov ch, 0x00     ; select Cylinder
  mov dh, 0x00     ; select Track, set Head (base of 0)
  mov cl, 0x02     ; select Sector (base of 1)

  mov al, 2     ; read 2 sectors from start point

  ; set the address that we'd like BIOS to read the sectors to, which BIOS expects to find in ES:BX
  mov bx, 0xa00
  mov es, bx
  mov bx, 0x1234
  ; so the data will be read to 0xa000:0x1234, which the CPU translates to physical address 0xa1234

  int 0x13    ; BIOS interrupt to do the actual read

  ; error checking
  jc disk_error   ; jmp if carry flag set

  cmp al, 2   ; if actual no. of sectors read is different from what we expected 
  jne disk_error

  mov bx, SUCCESS_MSG
  call print_string
  jmp hang

disk_error:
  mov bx, DISK_ERROR_MSG
  call print_string

hang:
  jmp $

%include "print_string.asm"

; global variables
DISK_ERROR_MSG:
  db "disk read error",0

SUCCESS_MSG:
  db "success",0
    

  times 510-($-$$) db 0
  dw 0xaa55

; add some more sectors to the code
; the BIOS is only going to load the first 512-byte sector
; so no harm done
  times 256 dw 0xdada
  times 256 dw 0xface
