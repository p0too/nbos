#include "../drivers/screen.h"

void main()
{
  clear_screen();

  int i;
  /* fill rows of the screen */
  for(i=0; i<MAX_ROWS-1; i++) {
    print_char(i+'0', 0, i, GREEN_ON_BLACK);
    print_char('\n', 1, i, GREEN_ON_BLACK);
  }

  char* msg = "hello, world";
  print(msg);

  print("\nsuccessfully scrolled..");
}

