
// SYS_CALL.C
// Responsible for preparing the system to call dispatch()
// 
// tours de force: http://www.ducksarepeople.com/tdf 

#include <dos.h>
#include "sys_call.h"
#include "mpx_supt.h"
#include "dispatch.h"
#include "PCB.H"
#include "context.h"

// Used for context switching, interrupt handling, etc
void interrupt sys_call() {
  // MPX_SUPT.H defines numerous OP_CODEs, including:
  /*
   * IDLE    0; READ    1; WRITE   2
   * CLEAR   3; GOTOXY  4; EXIT    5
   */
  extern context *context_p;
  extern params *params_p;

  // GRAB SOME PARAMS
  int sstmp = _SS;
  int sptmp = _SP;
  params_p = (params*)((int)MK_FP(sstmp,sptmp) + sizeof(context));

  switch(params_p->op_code) {
  case IDLE: 
    prunning_to_ready();
    break;
  case READ:
    break;
  case WRITE:
    break;
  case CLEAR:
    break;
  case GOTOXY:
    break;
  case EXIT: 
    prunning_exit();
    break;
  default:
    //omg wtf bbq fail
    //return ERR_SUP_INVHAN
    break;
  }

  dispatch();
}
