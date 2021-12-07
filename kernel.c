void main()
{
  // the screen is 80x25 characters
  // want to write to second line
  // so 0xb8000 + 80 which is 0xb8000 + 0x50 = 0xb8050
  int row = 1;
  int col = 0;
  char* video_memory = (char*) (0xb8000 + 2 * (row * 80 + col));
  char* msg = "hello from the kernel..";
  while(*msg != '\0') {
    *video_memory = *msg;  // character to print
    *(video_memory+1) = 0x02; // attributes; bg:black, fg:green
    msg++;
    video_memory += 2;
  }
}

