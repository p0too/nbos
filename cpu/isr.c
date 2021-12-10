#include "isr.h"
#include "../drivers/screen.h"

void isr_handler()
{
  print("An interrupt occured.\n");
}
