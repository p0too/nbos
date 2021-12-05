; function for reading from disk using BIOS
; parameter <how many sectors to read> is in dx

disk_load:
  push dx         ; preserve dx for error checking later 

  mov ah, 0x02    ; BIOS read sector function

  mov al, dh      ; read dl number of sectors from start point
  mov ch, 0x00    ; select Cylinder
  mov dh, 0x00    ; select Track, set Head (base of 0)
  mov cl, 0x02    ; select Sector (base of 1)


  ; set the address that we'd like BIOS to read the sectors to, which BIOS expects to find in ES:BX
  mov bx, 0xa00
  mov es, bx
  mov bx, 0x1234
  ; so the data will be read to 0xa000:0x1234, which the CPU translates to physical address 0xa1234

  int 0x13    ; BIOS interrupt to do the actual read

  ; error checking
  jc disk_error   ; jmp if carry flag set i.e. error

  pop dx
  cmp dh, al   ; if actual no. of sectors read is different from what we expected 
  jne disk_error

  ; if no error, return
  mov bx, SUCCESS_MSG
  call print_string

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
  db "success",0
