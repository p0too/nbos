#include "../drivers/screen.h"
#include "../cpu/idt.h"
#include "../drivers/timer.h"

void main()
{
  setup_idt();

  // important to enable interrupts
  __asm__ __volatile__ ("sti");

  // initialise timer interrupt
  init_timer(50);
}

