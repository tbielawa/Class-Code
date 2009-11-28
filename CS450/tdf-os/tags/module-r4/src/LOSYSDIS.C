
// LOSYSDIS.C
// Responsible for dispatching and running all of the processes
// in the ready queue.
//
// tours de force http://ducksarepeople.com/tdf

#include <stdio.h>
#include <dos.h>
#include "mpx_supt.h"
#include "losysdis.h"
#include "pcb.h"
#include "context.h"

extern PCBDLL** PRIORITY_QUEUES;
unsigned short ss_save;
unsigned short sp_save;
unsigned short new_ss;
unsigned short new_sp;
extern context *context_p;
extern params *params_p;
PCB* l_cop;
int INT_ERR;
int l_err;
unsigned short tmp_stack[1025];

void dispatch_init(){
  // Initialize the interrupt vector for SYS_CALL
  INT_ERR = sys_set_vec(sys_call);

  if ( INT_ERR == 0 )
    printf("Successfully loaded sys_call.\n");
  else
    printf("Problem loading sys_call.\n");

  l_cop = NULL;

  ss_save = NULL;
  sp_save = NULL;
}

void interrupt dispatch(){
  //If sp_save is null
  //Save current SS and SP
  if( sp_save == NULL ){
    ss_save = _SS;
    sp_save = _SP;
  }

  if( givemeready() != NULL ){ //Found it
    l_cop = givemeready();
    //Remove from ready queue, set state to RUNNING
    l_err = pready_to_running();
    //Set _SS and _SP to the cop’s stack (context switch)
    new_ss = FP_SEG(l_cop->pstack_top);
    new_sp = FP_OFF(l_cop->pstack_top);
    _SS = new_ss;
    _SP = new_sp;
  }
  else {
    //Set COP to NULL
    l_cop = NULL;
    //Restore SS and SP
    _SS = ss_save;
    _SP = sp_save;
    //Set sp_save & ss_save = null;
    ss_save = NULL;
    sp_save = NULL;
  }
  //end
}

void interrupt sys_call() {
  // MPX_SUPT.H defines numerous OP_CODEs, including:
  /*
   * IDLE    0; READ    1; WRITE   2
   * CLEAR   3; GOTOXY  4; EXIT    5
   */

  new_ss = FP_OFF(&tmp_stack);
  new_sp = FP_OFF(&tmp_stack);
  l_cop->pstack_top = MK_FP(_SS, _SP);
  params_p = (params*)(l_cop->pstack_top + sizeof(context));

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

