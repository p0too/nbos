#include "../drivers/screen.h"

void main()
{
  clear_screen();

  char* msg = "hello, world";
  print(msg);
}

