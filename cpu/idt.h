#ifndef IDT_H
#define IDT_H

#include "types.h"

#define KERNEL_CS 0x08

struct idt_entry_struct
{
  u16_t base_lo;  // lower 16-bits of handler function address
  u16_t selector; // kernel segment selector
  u8_t always0;
  u8_t flags;
  u16_t base_hi;  // higher 16-bits of handler function address
} __attribute__((packed));
typedef struct idt_entry_struct idt_entry_t;


/* A pointer to the array of interrupt of handlers for `lidt` */
struct idt_ptr_struct
{
  u16_t limit;
  u32_t base;
} __attribute__((packed));
typedef struct idt_ptr_struct idt_ptr_t;


/* there are 256 possible interrupt numbers, all must be defined. If there is no
 * entry (even a NULL entry is fine), the processor will panic. The first 32
 * interrupts are CPU-dedicated and must be mapped and non-null.
 */
#define IDT_ENTRIES 256
idt_entry_t idt[IDT_ENTRIES];
idt_ptr_t idt_ptr;


void set_idt_entry(u8_t n, u32_t handler_address);  // idt[n] = handler_address
void set_idt_register();  // lidt idt_ptr;

/* make entries into array or populate idt with isr base address, flags etc*/
void populate_idt();

/* calls load_all_isr_in_idt. Once table is populated, calls
 * set_idt_register
 */
void setup_idt();


// the first 32 interrupts must be mapped and non-null
extern void isr0();
extern void isr1();
extern void isr2();
extern void isr3();
extern void isr4();
extern void isr5();
extern void isr6();
extern void isr7();
extern void isr8();
extern void isr9();
extern void isr10();
extern void isr11();
extern void isr12();
extern void isr13();
extern void isr14();
extern void isr15();
extern void isr16();
extern void isr17();
extern void isr18();
extern void isr19();
extern void isr20();
extern void isr21();
extern void isr22();
extern void isr23();
extern void isr24();
extern void isr25();
extern void isr26();
extern void isr27();
extern void isr28();
extern void isr29();
extern void isr30();
extern void isr31();

#endif
