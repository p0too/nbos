; function for reading from disk using BIOS
; parameter <how many sectors to read> is in dx

disk_load:
  pusha

  push dx         ; preserve dx for error checking later 

  mov ah, 0x02    ; BIOS read sector function

  mov al, dh      ; read dl number of sectors from start point
  mov ch, 0x00    ; select Cylinder
  mov dh, 0x00    ; select Track, set Head (base of 0)
  mov cl, 0x02    ; select Sector (base of 1)

  int 0x13    ; BIOS interrupt to do the actual read

  ; error checking
  jc disk_error   ; jmp if carry flag set i.e. error

  pop dx
  cmp dh, al   ; if actual no. of sectors read is different from what we expected 
  jne disk_error

  ; if no error, return
  mov bx, SUCCESS_MSG
  call print_string

  popa
  ret


; if disk error, don't return, just hang
disk_error:
  mov bx, DISK_ERROR_MSG
  call print_string
  jmp $


; global variables
DISK_ERROR_MSG:
  db "disk read error",0

SUCCESS_MSG:
  db "disk_load: success",0
