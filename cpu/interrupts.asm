; defined in isr.c
[extern isr_handler]
[extern irq_handler]

isr_common_stub:
  ; 1. Save CPU state
  pusha

  mov ax, ds ; Lower 16-bits of eax = ds.
  push eax ; save the data segment descriptor
  mov ax, 0x10  ; kernel data segment descriptor
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  ; 2. Call C handler
  ; arguments are on the stack
  call isr_handler

  ; 3. Restore state
  pop eax 
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  popa
  add esp, 8 ; Cleans up the pushed error code and pushed ISR number

  sti ; enable interrupts
  iret ; pops 5 things at once: CS, EIP, EFLAGS, SS, and ESP


irq_common_stub:
  pusha

  mov ax, ds ; Lower 16-bits of eax = ds.
  push eax ; save the data segment descriptor
  mov ax, 0x10  ; kernel data segment descriptor
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  call irq_handler  ; different than isr_common_stub

  pop ebx     ; different than isr_common_stub
  mov ds, bx
  mov es, bx
  mov fs, bx
  mov gs, bx

  popa
  add esp, 8 ; Cleans up the pushed error code and pushed ISR number

  sti ; enable interrupts
  iret ; pops 5 things at once: CS, EIP, EFLAGS, SS, and ESP



; list of interrupt servide routines for respective interrupt number
; global so that it can be referenced from c code using extern
global isr0
global isr1
global isr2
global isr3
global isr4
global isr5
global isr6
global isr7
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21
global isr22
global isr23
global isr24
global isr25
global isr26
global isr27
global isr28
global isr29
global isr30
global isr31

; IRQs
global irq0
global irq1
global irq2
global irq3
global irq4
global irq5
global irq6
global irq7
global irq8
global irq9
global irq10
global irq11
global irq12
global irq13
global irq14
global irq15

; interrupt numbers 8, 10, 11, 12, 13, 14 push error code
; so we don't need to push dummy error code

;0 - Division by zero exception
isr0:
  cli                 ; disable interrupts
  push byte 0         ; push dummy error code
  push byte 0         ; push interrupt number
  jmp isr_common_stub ; go to common handler

;1 - Debug exception
isr1:
  cli
  push byte 0
  push byte 1
  jmp isr_common_stub

;2 - Non maskable interrupt
isr2:
  cli
  push byte 0
  push byte 2
  jmp isr_common_stub

;3 - Breakpoint exception
isr3:
  cli
  push byte 0
  push byte 3
  jmp isr_common_stub

;4 - 'Into detected overflow'
isr4:
  cli 
  push byte 0
  push byte 4
  jmp isr_common_stub

;5 - Out of bounds exception
isr5:
  cli
  push byte 0
  push byte 5
  jmp isr_common_stub

;6 - Invalid opcode exception
isr6:
  cli
  push byte 0
  push byte 6
  jmp isr_common_stub

;7 - No coprocessor exception
isr7:
  cli
  push byte 0
  push byte 7
  jmp isr_common_stub

;8 - Double fault (pushes an error code)
isr8:
  cli
  push byte 8
  jmp isr_common_stub

;9 - Coprocessor segment overrun
isr9:
  cli
  push byte 0
  push byte 9 
  jmp isr_common_stub

;10 - Bad TSS (pushes an error code)
isr10:
  cli
  push byte 10
  jmp isr_common_stub

;11 - Segment not present (pushes an error code)
isr11:
  cli
  push byte 11
  jmp isr_common_stub

;12 - Stack fault (pushes an error code)
isr12:
  cli
  push byte 12
  jmp isr_common_stub

;13 - General protection fault (pushes an error code)
isr13:
  cli
  push byte 13
  jmp isr_common_stub

;14 - Page fault (pushes an error code)
isr14:
  cli
  push byte 14
  jmp isr_common_stub

;15 - Unknown interrupt exception
isr15:
  cli
  push byte 0
  push byte 15
  jmp isr_common_stub

;16 - Coprocessor fault
isr16:
  cli
  push byte 0
  push byte 16
  jmp isr_common_stub

;17 - Alignment check exception
isr17:
  cli
  push byte 0
  push byte 17
  jmp isr_common_stub

;18 - Machine check exception
isr18:
  cli
  push byte 0
  push byte 18
  jmp isr_common_stub

;19 - Reserved
isr19:
  cli
  push byte 0
  push byte 19
  jmp isr_common_stub

;20 - Reserved
isr20:
  cli
  push byte 0
  push byte 20
  jmp isr_common_stub

;21 - Reserved
isr21:
  cli
  push byte 0
  push byte 21
  jmp isr_common_stub

;22 - Reserved
isr22:
  cli
  push byte 0
  push byte 22
  jmp isr_common_stub

;23 - Reserved
isr23:
  cli
  push byte 0
  push byte 23
  jmp isr_common_stub

;24 - Reserved
isr24:
  cli
  push byte 0
  push byte 24
  jmp isr_common_stub

;25 - Reserved
isr25:
  cli
  push byte 0
  push byte 25
  jmp isr_common_stub

;26 - Reserved
isr26:
  cli
  push byte 0
  push byte 26
  jmp isr_common_stub

;27 - Reserved
isr27:
  cli
  push byte 0
  push byte 27
  jmp isr_common_stub

;28 - Reserved
isr28:
  cli
  push byte 0
  push byte 28
  jmp isr_common_stub

;29 - Reserved
isr29:
  cli
  push byte 0
  push byte 29
  jmp isr_common_stub

;30 - Reserved
isr30:
  cli
  push byte 0
  push byte 30
  jmp isr_common_stub

;31 - Reserved
isr31:
  cli
  push byte 0
  push byte 31
  jmp isr_common_stub

;-------IRQs----------;

;32
irq0:
    cli                 ; disable interrupt
    push byte 0         ; push error code
    push byte 32        ; irq is remapped to this isr number
    jmp irq_common_stub ; jumpt to common irq handler

;33
irq1:
    cli
    push byte 0
    push byte 33
    jmp irq_common_stub

;34
irq2:
    cli
    push byte 0
    push byte 34
    jmp irq_common_stub

;35
irq3:
    cli
    push byte 0
    push byte 35
    jmp irq_common_stub

;36
irq4:
    cli
    push byte 0
    push byte 36
    jmp irq_common_stub

;37
irq5:
    cli
    push byte 0
    push byte 37
    jmp irq_common_stub

;38
irq6:
    cli
    push byte 0
    push byte 38
    jmp irq_common_stub

;39
irq7:
    cli
    push byte 0
    push byte 39
    jmp irq_common_stub

;40
irq8:
    cli
    push byte 0
    push byte 40
    jmp irq_common_stub

;41
irq9:
    cli
    push byte 0
    push byte 41
    jmp irq_common_stub

;42
irq10:
    cli
    push byte 0
    push byte 42
    jmp irq_common_stub

;43
irq11:
    cli
    push byte 0
    push byte 43
    jmp irq_common_stub

;44
irq12:
    cli
    push byte 0
    push byte 44
    jmp irq_common_stub

;45
irq13:
    cli
    push byte 0
    push byte 45
    jmp irq_common_stub

;46
irq14:
    cli
    push byte 0
    push byte 46
    jmp irq_common_stub

;47
irq15:
    cli
    push byte 0
    push byte 47
    jmp irq_common_stub
