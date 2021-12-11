#include "isr.h"
#include "../drivers/screen.h"
#include "../kernel/util.h"
#include "../drivers/ports.h"

 /* array of fn pointers; points to interrupt handlers */
isr_t interrupt_handlers[256];

void isr_handler(registers_t reg)
{
  print("An interrupt occured: ");
  char str[3];
  int2ascii(reg.int_no, str);
  print(str);
}

void irq_handler(registers_t reg)
{
  /* After every interrupt we need to send an EOI to the PICs
   * or they will not send another interrupt again */
  if (reg.int_no >= 40) 
    port_byte_out(0xA0, 0x20); /* slave */

  port_byte_out(0x20, 0x20); /* master */

  if(interrupt_handlers[reg.int_no] != 0) {
    isr_t handler = interrupt_handlers[reg.int_no];
    handler(reg);
  }
}

void register_interrupt_handler(u8_t n, isr_t handler)
{
  interrupt_handlers[n] = handler;
}
