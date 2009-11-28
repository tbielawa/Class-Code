// tours de force: http://www.ducksarepeople.com/tdf 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "load.h"
#include "mpx_supt.h"

extern PCBDLL **PRIORITY_QUEUES;

void load (char *filename, int priority){
  PCB *pcb;
  int SYS_CHECK_ERR = 0;
  int SYS_LOAD_ERR = 0;
  int PCB_CREATE_ERR = 0;
  int pclass = 0;
  int state = 0;
  int len_p;
  int offset_p;
  int memory_size;
  unsigned char load_address;
  unsigned char execution_address;
  
  
  if( name == NULL ) { // No name argument
    printf("No name supplied.\n");
    return PCB_CREATE_ERR;
  }
  else if( strlen(name) > 8 ) { // Name too long
    printf("Specified process name too long.\n");
    return PCB_CREATE_ERR;
  }
  else if ( !(priority >= -128 && priority <= 127) ) {
    printf("Invalid priority.\n");
    return PCB_CREATE_ERR;
  }
  else {
    SYS_CHECK_ERR = sys_check_program("\0", filename, *len_p, *offset_p);
    if( !SYS_CHECK_ERR == 0 ) {
      printf("Program either doesn't exist or is invalid.\n");
      return SYS_CHECK_ERR;
    }
    else {
      memory_size = len_p;
      load_address = (unsigned char*)sys_alloc_mem(memory_size);
      execution_address = load_address + (unsigned char*)offset_p

      // We've gotten what we needed and now we can apply it to a PCB.
      pcb = PCB_setup(filename, priority, pclass);

      // Place it in appropriate queue
      PCB_CREATE_ERR = PCB_insert(PRIORITY_QUEUES[state], temp, state);

      pcb->loadaddr = load_address;
      pcb->execaddr = execution_address

      context cp* = (context *) pcb->stack_top;
      
      
    }
  }
}
