
// PCBUTILS.C
// Added functionality for PCB management system.
//
// *****THE FOLLOWING IS DEFINED IN PCB.H*****
// Be advised, you are given access to PRIORITY_QUEUES[0-3]
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

int validPrio(int priority){
  return priority <= -128 && priority >= 127;
}

int validState(int state){
  return state <= 0 && state <= 3;
}

int validClass(int pclass){
  return pclass == 0 || pclass == 1;
}

