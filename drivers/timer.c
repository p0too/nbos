#include "timer.h"
#include "../cpu/isr.h"
#include "screen.h"
#include "ports.h"
#include "../kernel/util.h"
#include "../cpu/idt.h"

u32_t tick = 0;

void timer_callback(registers_t reg)
{
  tick++;
  print("\n");
  print("Tick: ");

  char str[256];
  int2ascii(tick, str);
  print(str);

  print("\n");
}

void init_timer(u32_t frequency)
{
  register_interrupt_handler(IRQ0, &timer_callback);

  u32_t divisor = 1193180 / frequency;

  u8_t lo = (u8_t)(divisor & 0xff);
  u8_t hi = (u8_t)((divisor >> 8) & 0xff);

  port_byte_out(0x43, 0x36);  // command byte

  port_byte_out(0x40, lo);
  port_byte_out(0x40, hi);
}
