
// PCBSHOW.C
// This file contains the commands needed to describe Process
// Control Blocks.
//
// *****THE FOLLOWING IS DEFINED IN PCB.H*****
// Be advised, you are given access to PRIORITY_QUEUES[0-4]
// READY 0
// BLOCKED 1
// READYSUSPENDED 2
// BLOCKEDSUSPENDED 3
//
// Process classes:
// APPLICATION 0
// SYSTEM 1
//
// tours de force: http://www.ducksarepeople.com/tdf

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mpx_supt.h"
#include "pcb.h"

extern PCBDLL **PRIORITY_QUEUES;

int pshow(char *name){
  PCB *temp;
  int PCB_SHOW_ERR = 0;

  if( (strlen(name) > 8) ){
    printf("Invalid Process Control Block identifier.\n");
    return PCB_SHOW_ERR;
  }

  temp = PCB_find(name);
  if( temp == NULL ){
    printf("Could not find the specified Process Control Block.\n");
    return PCB_SHOW_ERR;
  }
  else{
    PCB_print(temp);
  }

  return PCB_SHOW_ERR;
}

int pshowall(){
  int PCB_SHOWALL_ERR = 0;
  
  printf("READY QUEUE\n");
  PCB_SHOWALL_ERR = PCBDLL_print(PRIORITY_QUEUES[READY]);
  printf("\nBLOCKED QUEUE\n");
  PCB_SHOWALL_ERR = PCBDLL_print(PRIORITY_QUEUES[BLOCKED]);
  printf("\nREADY-SUSPENDED QUEUE\n");
  PCB_SHOWALL_ERR = PCBDLL_print(PRIORITY_QUEUES[READYSUSPENDED]);
  printf("\nBLOCKED-SUSPENDED QUEUE\n");
  PCB_SHOWALL_ERR = PCBDLL_print(PRIORITY_QUEUES[BLOCKEDSUSPENDED]);

  return PCB_SHOWALL_ERR;
}

int pshowrd(){
  int PCB_SHOWREADY_ERR = 0;

  printf("READY QUEUE\n");
  PCB_SHOWREADY_ERR = PCBDLL_print(PRIORITY_QUEUES[READY]);
  printf("\nREADY-SUSPENDED QUEUE\n");
  PCB_SHOWREADY_ERR = PCBDLL_print(PRIORITY_QUEUES[READYSUSPENDED]);

  return PCB_SHOWREADY_ERR;
}

int pshowblk(){
  int PCB_SHOWBLOCKED_ERR = 0;
 
  printf("BLOCKED QUEUE\n");
  PCB_SHOWBLOCKED_ERR = PCBDLL_print(PRIORITY_QUEUES[BLOCKED]);
  printf("\nBLOCKED-SUSPENDED QUEUE\n");
  PCB_SHOWBLOCKED_ERR = PCBDLL_print(PRIORITY_QUEUES[BLOCKEDSUSPENDED]);
    
  return PCB_SHOWBLOCKED_ERR;
}

int pshowrng(){
  int PCB_SHOWRNG_ERR = 0;
  
  printf("RUNNING QUEUE\n");
  PCB_SHOWRNG_ERR = PCBDLL_print(PRIORITY_QUEUES[RUNNING]);

  return PCB_SHOWRNG_ERR;
}
