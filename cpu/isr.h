#ifndef ISR_H
#define ISR_H

#include "types.h"

/* read the stack and assign labels i.e. we don't need to intitialise the
 * struct */
typedef struct registers
{
  u32_t ds;   /* data segment selector */
  u32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;   /* pushed by pusha in isr_common_stub */
  u32_t int_no, err_code;   /* pushed by isr in interrupts.asm */
  u32_t eip, cs, eflags, useresp, ss;   /* pushed by processor automatically */
} registers_t;


/* this function is called by isr_common_stub in interrupts.asm  */
void isr_handler(registers_t reg);

/* IRQ handler */
void irq_handler(registers_t reg);

/* enables registration of callbacks for interrupts or IRQs. */
typedef void (*isr_t)(registers_t);
void register_interrupt_handler(u8_t n, isr_t handler);

#endif
