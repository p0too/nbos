#include "idt.h"
#include "../drivers/ports.h"

/* kernel calls this function to set up idt */
void setup_idt()
{
  populate_idt();   // set 8-byte struct for each of 32 interrupts i.e. make entries in array idt
  set_idt_register(); // let cpu know idt address and size
}


void set_idt_entry(u8_t n, u32_t handler_address)
{
  idt[n].base_lo = (u16_t) (handler_address & 0xffff);  // lower 16-bits of handler function address
  idt[n].selector = KERNEL_CS; // kernel segment selector; KERNEL_CS = 0x08 i.e. second entry in gdt
  idt[n].always0 = 0;
  idt[n].flags = 0x8e;
  idt[n].base_hi = (u16_t) ((handler_address >> 16) & 0xffff);  // higher 16-bits of handler function address
}


void set_idt_register()
{
  /*
  u16_t limit;
  u32_t base;
  */
  idt_ptr.limit = IDT_ENTRIES * sizeof(idt_entry_t) - 1;
  idt_ptr.base = (u32_t) &idt;

  __asm__ __volatile__("lidt (%0)": : "r" (&idt_ptr));
}


void populate_idt()
{
  set_idt_entry(0 ,(u32_t) isr0);
  set_idt_entry(1 ,(u32_t) isr1);
  set_idt_entry(2 ,(u32_t) isr2);
  set_idt_entry(3 ,(u32_t) isr3);
  set_idt_entry(4 ,(u32_t) isr4);
  set_idt_entry(5 ,(u32_t) isr5);
  set_idt_entry(6 ,(u32_t) isr6);
  set_idt_entry(7 ,(u32_t) isr7);
  set_idt_entry(8 ,(u32_t) isr8);
  set_idt_entry(9 ,(u32_t) isr9);
  set_idt_entry(10 ,(u32_t) isr10);
  set_idt_entry(11 ,(u32_t) isr11);
  set_idt_entry(12 ,(u32_t) isr12);
  set_idt_entry(13 ,(u32_t) isr13);
  set_idt_entry(14 ,(u32_t) isr14);
  set_idt_entry(15 ,(u32_t) isr15);
  set_idt_entry(16 ,(u32_t) isr16);
  set_idt_entry(17 ,(u32_t) isr17);
  set_idt_entry(18 ,(u32_t) isr18);
  set_idt_entry(19 ,(u32_t) isr19);
  set_idt_entry(20 ,(u32_t) isr20);
  set_idt_entry(21 ,(u32_t) isr21);
  set_idt_entry(22 ,(u32_t) isr22);
  set_idt_entry(23 ,(u32_t) isr23);
  set_idt_entry(24 ,(u32_t) isr24);
  set_idt_entry(25 ,(u32_t) isr25);
  set_idt_entry(26 ,(u32_t) isr26);
  set_idt_entry(27 ,(u32_t) isr27);
  set_idt_entry(28 ,(u32_t) isr28);
  set_idt_entry(29 ,(u32_t) isr29);
  set_idt_entry(30 ,(u32_t) isr30);
  set_idt_entry(31 ,(u32_t) isr31);

  /* on booting, default interrupt mappings are IRQ 0..7 -> INT 0x8..0xF and
   * IRQ 8..15 -> INT 0x70..0x77. This causes conflict with cpu exceptions and
   * fault signals.
   * So, Remap the PICs so that IRQs 0..15 correspond to ISRs 32..47 
   */
  port_byte_out(0x20, 0x11);
  port_byte_out(0xA0, 0x11);

  port_byte_out(0x21, 0x20);
  port_byte_out(0xA1, 0x28);

  port_byte_out(0x21, 0x04);
  port_byte_out(0xA1, 0x02);

  port_byte_out(0x21, 0x01);
  port_byte_out(0xA1, 0x01);

  port_byte_out(0x21, 0x0);
  port_byte_out(0xA1, 0x0);

  /* IRQ */
  set_idt_entry(IRQ0, (u32_t) irq0);
  set_idt_entry(IRQ1, (u32_t) irq1);
  set_idt_entry(IRQ2, (u32_t) irq2);
  set_idt_entry(IRQ3, (u32_t) irq3);
  set_idt_entry(IRQ4, (u32_t) irq4);
  set_idt_entry(IRQ5, (u32_t) irq5);
  set_idt_entry(IRQ6, (u32_t) irq6);
  set_idt_entry(IRQ7, (u32_t) irq7);
  set_idt_entry(IRQ8, (u32_t) irq8);
  set_idt_entry(IRQ9, (u32_t) irq9);
  set_idt_entry(IRQ10, (u32_t) irq10);
  set_idt_entry(IRQ11, (u32_t) irq11);
  set_idt_entry(IRQ12, (u32_t) irq12);
  set_idt_entry(IRQ13, (u32_t) irq13);
  set_idt_entry(IRQ14, (u32_t) irq14);
  set_idt_entry(IRQ15, (u32_t) irq15);

}

