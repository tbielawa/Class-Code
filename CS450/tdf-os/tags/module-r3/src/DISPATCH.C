#include <stdio.h>
#include <dos.h>
#include "mpx_supt.h"
#include "dispatch.h"
#include "pcb.h"
#include "context.h"

unsigned short ss_save;
unsigned short sp_save;

void dispatch_init(){
  // Initialize the interrupt vector for SYS_CALL
  INT_ERR = sys_set_vec(sys_call);

  if ( INT_ERR == 0 )
    printf("Successfully loaded sys_call.\n");
  else
    printf("Problem loading sys_call.\n");

  ss_save = NULL;
  sp_save = NULL;
}

void interrupt dispatch(){
  //Pull in those external things
  unsigned short new_ss;
  unsigned short new_sp;
  PCB* cop;
  //  extern char* sys_stack; <-- Don't need you?
  int err;

  // Bmiller says, printf's in interrupts are bad.
  // printf("Entering dispatch.\n");

  //If sp_save is null
  //Save current SS and SP
  if( sp_save == NULL ){
    ss_save = _SS;
    sp_save = _SP;
  }

  if( givemeready() != NULL ){ //Found it
    cop = givemeready();
    //Remove from ready queue, set state to RUNNING
    err = pready_to_running();
    //Set _SS and _SP to the cop’s stack (context switch)
    new_ss = FP_SEG(cop->pstack_top);
    new_sp = FP_OFF(cop->pstack_top);
    _SS = new_ss;
    _SP = new_sp;
  }
  else {
  //Set COP to NULL
  cop = NULL;
  //Restore SS and SP
  _SS = ss_save;
  _SP = sp_save;
  //Set sp_save & ss_save = null;
  ss_save = NULL;
  sp_save = NULL;
  }//end
}
