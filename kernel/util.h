#ifndef UTIL_H
#define UTIL_H

void memory_copy(char* source, char* dest, int no_bytes);
void int2ascii(int n, char str[]);
void reverse(char s[]);
int strlen(char s[]);

/* to populate keyboard buffer */
void append_char_to_string(char n, char s[], int s_size);

/* implement backspace functionality */
int backspace(char buffer[]);

#endif
