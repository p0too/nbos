## Interrupts

- Set up interrupt descriptor table
  - define idt entry structure (8 bytes)
  - there are 256 entries in the idt
    - 4 bytes for storing base address of interrupt handler/ interrupt service routine
    - 2 bytes for kernel segment selector
    - others
  - list and define interrupt handlers in asm for each interrupt 
    - first 32 are enough for now
    - interrupts are identified by interrupt number, so we store its handler at an index in idt which is same as the interrupt number.
    - address of these interrupt handlers must be entered in interrupt descriptor table.
    - all these interrupt handlers call a common assembly routine which then calls a C function
  - load the idt address and size in idt register using lidt instruction

- The flow
  - interrupt occurs with interrupt number x
  - cpu knows base address of idt
  - x becomes offset into idt
  - at index x in idt, an 8 byte structure has address of interrupt handler `isr-x` defined in interrupts.asm
  - isr-x disables interrupts, pushes error code, and interrupt number on stack, and then calls a common handler (defined in interrupts.asm)
  - common-handler saves cpu state and calls higher-level handler (defined in isr.c)
  - on returning from c handler, the common handler pops error code and isr number, enables interrupts, and returns.
