## Speed run of osdev by Nick Blundell


### Enter 32-bit protected mode

- Need GDT to make switch from 16-bit real mode to 32-bit protected mode.
- BIOS functions (0x10 to print, 0x13 to read disk etc) are not available in 32-bit mode. So, need to write those.
- How to switch from 16-bit to 32-bit?
  - Define GDT
    - To keep it simple, use the flat model
    - i.e. define just two segment descriptors: code and data, that overlap but cover the full 4GB of addressable memory
    - so, not really taking advantages of protected mode i.e. one segment is not protected from another cause of overlapping, and also, no use of paging for virtual memory.
  - Define GDT descriptor (6 bytes)
    - size of gdt (2 bytes)
    - address of gdt (4 bytes)
  - Disable Interrupts
  - LGDT (load gdt descriptor in GDTR)
  - Set first bit of CR0 register
  - Make far jump (to flush cpu instruction pipeline)
  - We're in Protected Mode now
  - Initialise segment registers, and stack
  - Do fun things in 32-bit protected mode (start with printing to the screen directly via the video memory)
