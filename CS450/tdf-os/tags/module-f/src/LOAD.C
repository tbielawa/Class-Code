
// LOAD.C
// Responsible for loading an MPX process and placing it in the SUSPENDED
// queue.
//
// tours de force: http://www.ducksarepeople.com/tdf 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dos.h>
#include "load.h"
#include "mpx_supt.h"
#include "pcb.h"
#include "tdf.h"

extern PCBDLL **PRIORITY_QUEUES;

int load (char* argstr){
  // The context and the PCB
  PCB *pcb;
  context *cp;

  // Parsed arguments
  char *tokenPtr;
  char *name;
  int priority;

  // Error codes
  int SYS_CHECK_ERR = 0;
  int SYS_LOAD_ERR = 0;
  int PCB_CREATE_ERR = 0;

  // Memory variables
  int len_p;
  int offset_p;
  int memory_size;
  unsigned char *load_address;
  unsigned char *execution_address;

  // Grab the args and place them in vars then drop to code below
  tokenPtr = strtok(argstr, " ");
  if (tokenPtr == NULL) {
    printf("No arguments supplied. Terminating.\n");
    return PCB_CREATE_ERR;
  }
  
  while (tokenPtr != NULL) {
    if (!strcmp(tokenPtr, "-n\0")){ // Name arg, pump again
      tokenPtr = strtok(NULL, " ");
      
      strcpy(name, tokenPtr);
    }
    else if (!strcmp(tokenPtr, "-p\0")){ // Prio arg, pump it
      tokenPtr = strtok(NULL, " ");
      priority = atoi(tokenPtr);
    }
    else {
      printf("Invalid argument supplied. Getting out of here.\n");
      return PCB_CREATE_ERR;
    }
    tokenPtr = strtok(NULL, " ");
  }


  // Check the arguments
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
  else if( PCB_find(name) != NULL ) { // process already exists
    printf("Process %s already exists!\n", name);
    return PCB_CREATE_ERR;
  }

  // Arguments valid, check the program file
  else {
    SYS_CHECK_ERR = sys_check_program("\0", name, &len_p, &offset_p);
    if( !SYS_CHECK_ERR == 0 ) {
      if ( SYS_CHECK_ERR == ERR_SUP_NAMLNG )
	printf("Invalid name argument.\n");
      else if ( SYS_CHECK_ERR == ERR_SUP_FILNFD )
	printf("File not found.\n");
      else if ( SYS_CHECK_ERR == ERR_SUP_FILINV )
	printf("Invalid file provided.\n");
      else
	printf("How did you get here? Please contact the author of this software.\n");
      return SYS_CHECK_ERR;
    }
    else {
      // Program checked, proceed with allocating and loading
      memory_size = len_p;
      load_address = sys_alloc_mem(memory_size);
      execution_address = load_address + offset_p;
	
      // We've gotten what we needed and now we can apply it to a PCB.
      pcb = PCB_setup(name, priority, APPLICATION);
      
      // Set the memory descriptors
      pcb->memsize = memory_size;
      pcb->loadaddr = load_address;
      pcb->execaddr = execution_address;
      
      // Set the context variables
      cp = (context *) pcb->pstack_top;
      cp->IP = FP_OFF(pcb->execaddr);
      cp->CS = FP_SEG(pcb->execaddr);
      cp->FLAGS = 0x200;
      cp->DS = _DS;
      cp->ES = _ES;
      
      // Load the process
      SYS_LOAD_ERR = sys_load_program(pcb->loadaddr, pcb->memsize, "\0", name);

      // Did that load right?
      if( !(SYS_LOAD_ERR == 0) ){
	printf("There was a problem loading your program.\n");
	return SYS_LOAD_ERR;
      }

      // Place it in appropriate queue
      PCB_insert(PRIORITY_QUEUES[READYSUSPENDED], pcb, READYSUSPENDED);
    }
  }

  return SYS_LOAD_ERR;
}
