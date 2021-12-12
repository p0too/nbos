#include "../drivers/screen.h"
#include "../cpu/idt.h"
#include "../drivers/timer.h"
#include "../drivers/keyboard.h"

void main()
{
  setup_idt();

  // important to enable interrupts
  __asm__ __volatile__ ("sti");

  // initialise timer interrupt
  //init_timer(50);

  // keyboard interrupt
  init_keyboard();
}

