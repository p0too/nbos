; Boot Sector using BIOS to Read the Disk
; This is to test the disk_load function

  [org 0x7c00]

  ; set the address that we'd like BIOS to read the sectors to, which BIOS expects to find in ES:BX
  mov bx, 0xa00
  mov es, bx
  mov bx, 0x1234
  ; so the data will be read to 0xa000:0x1234, which the CPU translates to physical address 0xa1234

  mov dx, 0x02    ; argument <no. of sectors to read>
  call disk_load


%include "print_string.asm"
%include "disk_load.asm"

  times 510-($-$$) db 0
  dw 0xaa55

; add some more sectors to the code
; the BIOS is only going to load the first 512-byte sector
; so no harm done
  times 256 dw 0xdada
  times 256 dw 0xface
