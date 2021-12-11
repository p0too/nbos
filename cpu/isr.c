#include "isr.h"
#include "../drivers/screen.h"
#include "../kernel/util.h"

void isr_handler(registers_t reg)
{
  print("An interrupt occured: ");

  char str[3];
  int2ascii(reg.int_no, str);
  print(str);
}
