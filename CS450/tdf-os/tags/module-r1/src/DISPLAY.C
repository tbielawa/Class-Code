// display.c
// 
// Program to list all of the .MPX files in the current directory or
// in a directory specified by the user
//
// tours de force: http://www.ducksarepeople.com/tdf

#include <stdio.h>
#include "mpx_supt.h"
#include "display.h"

#define DISPLAY_BUFFER_SIZE 20

int display (char folder[])
{
  char buff[DISPLAY_BUFFER_SIZE];
  long file_size;
  int  SYS_OPEN_ERR = 0;
  int  SYS_GET_ERR = 0;

  SYS_OPEN_ERR = sys_open_dir(folder);

  printf("%s", folder);

  printf("Filename             Size");

  while(SYS_GET_ERR != -113)
    {
      SYS_GET_ERR = sys_get_entry(buff, DISPLAY_BUFFER_SIZE, &file_size);

      printf("%-20s %-10d\n", buff, file_size);

      printf("....%d....",SYS_GET_ERR);
    }

  sys_close_dir;

  return 0;
}
