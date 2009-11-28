
// PCBMAKE.C
// This file contains the commands necessary to create and destroy
// Process Control Blocks.
//
// *****THE FOLLOWING IS DEFINED IN PCB.H*****
// Be advised, you are given access to PRIORITY_QUEUES[0-4]
// READY 0
// BLOCKED 1
// READYSUSPENDED 2
// BLOCKEDSUSPENDED 3 
// RUNNING 4
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

int pcreate(char *name){
  PCB *temp;
  int PCB_CREATE_ERR = 0;
  int SYS_REQ_ERR;
  int buffer_size = 256;
  int priority, pclass, state;

  // stack wtf
  // int memsize;
  //lol. wtf's a stack? --shaggy
  // unsigned char *load;
  // unsigned char *exec;
  char PCBBUFF[256];

  if( name == NULL ) { // No name argument
    printf("No name supplied.\n");
    return PCB_CREATE_ERR;
  }
  else if( strlen(name) > 8 ) { // Name too long
    printf("Specified process name too long.\n");
    return PCB_CREATE_ERR;
  }
  else {
    printf("Making Process Control Block: %s\n", name);

    // Get and check priority
    printf("Enter priority (-128 - 127): ");
    SYS_REQ_ERR = sys_req(READ, TERMINAL, PCBBUFF, &buffer_size);
    if( PCBBUFF[0] == "-" ) // Make sure the dash becomes negative
       priority = -atoi(PCBBUFF);
    else
      priority = atoi(PCBBUFF);
    if( !(priority >= -128 && priority <= 127) ){
      printf("Invalid priority.\n");
      return PCB_CREATE_ERR;
    }

    // Get and check state
    printf("Enter state (0 - 3): ");
    SYS_REQ_ERR = sys_req(READ, TERMINAL, PCBBUFF, &buffer_size);
    state = atoi(PCBBUFF);
    if( !(state >= 0 || state <= 3) ){
      printf("Invalid state.\n");
      return PCB_CREATE_ERR;
    }

    // Get and check class
    printf("Enter class (0 App or 1 Sys): ");
    SYS_REQ_ERR = sys_req(READ, TERMINAL, PCBBUFF, &buffer_size);
    pclass = atoi(PCBBUFF);
    if( !(pclass == 0 || pclass == 1) ){
      printf("Invalid class.\n");
      return PCB_CREATE_ERR;
    }

    // We've gotten what we needed and now we can apply it to a PCB.
    temp = PCB_setup(name, priority, pclass);

    // Place it in appropriate queue
    PCB_CREATE_ERR = PCB_insert(PRIORITY_QUEUES[state], temp, state);

  }

  return PCB_CREATE_ERR;
}

int pdelete(char *name){

  int PCB_DELETE_ERR = 0;
  PCB* temp;
  
  if( strlen(name) > 8 ){ // Too long, fuck it
    printf("Invalid Process Control Block identifier.\n");
    return PCB_DELETE_ERR;
  }
  
  temp = PCB_find(name);
  
  if( temp == NULL ){
    PCB_DELETE_ERR = 1;
    printf("PCB does not exist.\n");
    return PCB_DELETE_ERR;
  }
  else {
    if( temp->pclass == 1 ){
      PCB_DELETE_ERR = 1;
      printf("Unable to delete SYSTEM process.\n");
      return PCB_DELETE_ERR;
    }
    else {
      PCB_DELETE_ERR = PCB_remove(temp);
      PCB_DELETE_ERR = PCB_free(temp);
    }
    
    if( PCB_DELETE_ERR == 1 )
      printf("Unable to delete %s.\n", name);
    else
      printf("Successfuly deleted PCB %s.\n", name);
    return PCB_DELETE_ERR;
  }
}
