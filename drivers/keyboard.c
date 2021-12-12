#include "keyboard.h"
#include "ports.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"
#include "screen.h"
#include "../cpu/types.h"
#include "../kernel/util.h"


#define SC_MAX 57
#define KEY_BUFFER_MAX_SIZE 16

#define BACKSPACE 0x0e

static char key_buffer[KEY_BUFFER_MAX_SIZE];

const char scancode_to_char[] = { '?', '?', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
  '-', '=', '?', '?', 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I',
  'O', 'P', '[', ']', '?', '?', 'A', 'S', 'D', 'F', 'G', 'H',
  'J', 'K', 'L', ';', '\'', '`', '?', '\\', 'Z', 'X', 'C', 'V',
  'B', 'N', 'M', ',', '.', '/', '?', '?', '?', ' '
};


static void keyboard_callback(registers_t reg)
{
  u8_t scancode = port_byte_in(0x60);

  /* don't consider key-up events */
  if(scancode > SC_MAX)
    return;

  /* handle Backspace */
  if(scancode == BACKSPACE) {
    if(backspace(key_buffer)) {
      print_backspace();
    }
  } else {
    char letter = scancode_to_char[(int) scancode];
    append_char_to_string(letter, key_buffer, KEY_BUFFER_MAX_SIZE);

    char str[2] = {letter, '\0'};
    print(str);
  }
}

void init_keyboard()
{
  register_interrupt_handler(IRQ1, keyboard_callback);
}

