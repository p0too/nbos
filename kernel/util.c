#include "util.h"
#include "../drivers/screen.h"

void memory_copy(char* source, char* dest, int no_bytes)
{
  int i;
  for(i=0; i<no_bytes; i++) {
    *(dest + i) = *(source + i);
  }
}

void int2ascii(int n, char str[])
{
  int i, sign;
  if((sign = n) < 0) n = -n;
  i = 0;
  do {
    str[i++] = n % 10 + '0';
  } while ((n/=10) > 0);

  if(sign < 0) str[i++] = '-';
  str[i] = '\0';
  reverse(str);
}

void reverse(char s[])
{
    int c, i, j;
    for (i = 0, j = strlen(s)-1; i < j; i++, j--) {
        c = s[i];
        s[i] = s[j];
        s[j] = c;
    }
}

int strlen(char s[]) {
    int i = 0;
    while (s[i] != '\0') ++i;
    return i;
}

void append_char_to_string(char n, char s[], int s_size)
{
  int len = strlen(s);
  if(len < s_size - 2) {
    s[len] = n;
    s[len+1] = '\0';
  } else {    /* check buffer overflow */
    print("\ninfo: resetting keyboard buffer.. \n");
    len = 0;
    s[len] = n;
    s[len+1] = '\0';
  }
}

int backspace(char buffer[])
{
  int len = strlen(buffer);
  if(len > 0) {
    buffer[len-1] = '\0';
    return 1;
  } else {
    return 0;
  }
}
