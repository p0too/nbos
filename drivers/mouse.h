#ifndef MOUSE_H
#define MOUSE_H

#include "../cpu/types.h"

u8_t mouse_buffer[3];
u8_t mb_offset;   // index into mouse_buffer
static s8_t x, y;

void init_mouse();

#endif
