; Boot Sector using BIOS to Read the Disk
; This is to test the disk_load function

  [org 0x7c00]

  mov [BOOT_DRIVE], dl    ; BIOS stores boot drive in dl, so save it for later

  mov bp, 0x8000    ; set up stack at safer address
  mov sp, bp

  mov bx, 0x9000   ; load 2 sectors to 0x0000(ES):0x9000(BX)
  mov dh, 2
  mov dl, [BOOT_DRIVE]
  call disk_load

  mov dx, [0x9000]    ; print the first loaded word, expected 0xdada
  call print_hex

  mov dx, [0x9000 + 512]    ; print first word from second loaded sector, expected 0xface
  call print_hex

  jmp $


%include "print_string.asm"
%include "print_hex.asm"
%include "disk_load.asm"


BOOT_DRIVE:
  db 0

  times 510-($-$$) db 0
  dw 0xaa55

; add some more sectors to the code
; the BIOS is only going to load the first 512-byte sector
; so no harm done
  times 256 dw 0xdada
  times 256 dw 0xface
