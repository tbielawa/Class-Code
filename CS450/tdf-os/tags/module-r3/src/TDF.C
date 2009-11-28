
// tdf.c
// Program to initialize the MPX operating system
//
// tours de force: http://www.ducksarepeople.com/tdf

#include <stdio.h>
#include "mpx_supt.h"
#include "losysdis.h"

int main ( int argc, char *argv[] )
{

  // Call sys_init with the created modules
  int SYS_INIT_ERR;
  int SHELL_ERR;
  int DATE_ERR;
  date_rec* tdf_date;
  
  // Initialize system date
  DATE_ERR = sys_set_date(tdf_date);
  
  SYS_INIT_ERR = sys_init (MODULE_R3);
  
  // Setting up registers for dispatch...
  dispatch_init();
  
  // Call the shell
  SHELL_ERR = shell();
  
  // Fin
  return 0;
}
