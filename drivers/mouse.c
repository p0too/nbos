#include "mouse.h"
#include "ports.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"
#include "screen.h"
#include "../cpu/types.h"
#include "../kernel/util.h"


static void mouse_callback(registers_t reg)
{
  /* both keyboard and mouse data shows up on port 0x60 */

  /* to check if there is data at all at port 0x60, check bit number 0 of port 0x64*/
  u8_t status = port_byte_in(0x64);
  if(status & 0x01) {    /* data is available to be read, on port 0x60 */
    /* to confirm if data came from mouse, check bit number 5 of byte read from port 0x64 */
    if(!(status & 0x20)) {
      print("ERROR: mouse_callback: failed check\n");
      return;
    }
  
    mouse_buffer[mb_offset]= port_byte_in(0x60);  // read port data
    mb_offset = (mb_offset + 1) % 3;

    if(mb_offset == 0) {
      if(mouse_buffer[1] != 0 || mouse_buffer[2] != 0) {
        unsigned char *vidmem = (unsigned char*) 0xb8000;
        u32_t offset;
        u8_t attribute_byte = 0x6f;
        u8_t symbol = '0';
        static u8_t i = 0;

        offset = 2*(80*y+x);
        vidmem[offset] = vidmem[offset] & 0xff;
        vidmem[offset+1] = ((vidmem[offset+1] & 0x0f) << 4) | ((vidmem[offset+1] & 0xf0) >> 4);

        x += mouse_buffer[1];
        if(x < 0) x = 0;
        if(x >= MAX_COLS) x = 79;

        y -= mouse_buffer[2];
        if(y<0) y = 0;
        if(y >= MAX_ROWS) y = 24;

        offset = 2*(80*y+x);
        vidmem[offset] = vidmem[offset] & 0xff;
        vidmem[offset+1] = ((vidmem[offset+1] & 0x0f) << 4) | ((vidmem[offset+1] & 0xf0) >> 4);
      }
    }
  }
}

void init_mouse()
{
  register_interrupt_handler(IRQ12, mouse_callback);

  mb_offset = 2;   // idk why it's 2; doesn't work with 0 or 1
  x = 40;
  y = 12;

  u32_t offset = 2*(80*y+x);
  unsigned char *vidmem = (unsigned char*) 0xb8000;
  vidmem[offset] = vidmem[offset] & 0xff;
  vidmem[offset+1] = ((vidmem[offset+1] & 0x0f) << 4) | ((vidmem[offset+1] & 0xf0) >> 4);

  u8_t COMMAND_PORT = 0x64;
  u8_t DATA_PORT = 0x60;
  
  port_byte_out(COMMAND_PORT, 0xA8); 
  port_byte_out(COMMAND_PORT, 0x20);

  u8_t status = port_byte_in(DATA_PORT) | 2;

  port_byte_out(COMMAND_PORT, DATA_PORT); 
  port_byte_out(DATA_PORT, status);

  // start sending packets
  port_byte_out(COMMAND_PORT, 0xd4); 
  port_byte_out(DATA_PORT, 0xf4);
  port_byte_in(DATA_PORT);
}

