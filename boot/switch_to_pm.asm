; switch_to_pm: function to make the switch from 16-bit real mode to 32-bit protected mode
; No return from this function
; Instead, we jump to some well known label at the end

[bits 16]
switch_to_pm:

  cli   ; disable interrupts

  lgdt [gdt_descriptor]   ; load global descriptor table which defines the protected mode segments
                          ; gdt_descriptor is in gdt.asm

  mov eax, cr0   ; to make the switch, set the first bit of control register cr0. 
  or eax, 0x1
  mov cr0, eax


  jmp CODE_SEG:INIT_PM  ; make a far jmp (i.e. to a new segment) to our 32-bit code segment, to flush the instruction pipeline
                        ; important cause 16-bit instr in cpu instruction pipeline can cause mess

;----------------;
[bits 32]

; initialise registers and stack, once in protected mode
INIT_PM:
  mov ax, DATA_SEG
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  ; check the stack address
  mov ebp, 0x90000    ; setup the stack for pm so that it's right on top of the free space
  mov esp, ebp

  call BEGIN_PM     ; Finally call some well-known label
