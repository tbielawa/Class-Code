
// PCB.C
// This source file contains the structure definitions for the Process Control
// Blocks (PCB), the queues containing the PCBs, and various procedures to
// access these PCBs in their various queues to edit them.
//
// tours de force: http://www.ducksarepeople.com/tdf 

#include <stdio.h>
#include <stdlib.h>
#include "pcb.h"
#include "context.h"
#include "mpx_supt.h"

extern PCBDLL **PRIORITY_QUEUES;

PCBDLL *PCBDLL_alloc ()
{
  // Allocate the PCBDLL
  PCBDLL *ret;
  ret = (PCBDLL *)sys_alloc_mem(sizeof(PCBDLL));

  // We have a dummy header node, so let's set everything to null
  ret->prev = NULL;
  ret->next = NULL;
  ret->contents = NULL;

  // Return a pointer to the PCBDLL
  return ret;
}

PCBDLL **PCBDLL_creation ( int queues )
{
  // Initialize an array of PCBDLLs for each of the queues
  PCBDLL **ret;
  int i = 0;

  // Allocate the PCBDLL
  ret = sys_alloc_mem(sizeof(PCBDLL*) * queues);
  
  // Set each of the elements in the array to PCBDLLs
  for ( i = 0; i < queues; i++ )
    {
      ret[i] = PCBDLL_alloc();
    }

  // Return the array of PCBDLLs
  return ret;
}

int PCBDLL_print ( PCBDLL *printq )
{
  // Initialize the error code
  int err = 0;

  // Initialize an iterating PCBDLL node
  PCBDLL *iter = printq;

  printf("   Name   | Class |  State  | Priority \n");
  printf("=======================================\n");
  while ( iter->next != NULL )
    {
      // Go to the next element
      iter = iter->next;

      // Output the name
      printf(" %*s  ", 8, (iter->contents)->name);

      // Output the class
      if ((iter->contents)->pclass == APPLICATION)
	printf("  APP   ");
      else if ((iter->contents)->pclass == SYSTEM)
	printf("  SYS   ");

      // Output the state
      if ((iter->contents)->state == READY)
	printf("  READY   ");
      else if ((iter->contents)->state == BLOCKED)
	printf(" BLOCKED  ");
      else if ((iter->contents)->state == READYSUSPENDED)
	printf(" RDYSUSP  ");
      else if ((iter->contents)->state == BLOCKEDSUSPENDED)
	printf(" BLKSUSP  ");
      else if ((iter->contents)->state == RUNNING) //in theory we'd never see this
	printf(" RUNNING  ");

      // Output the priority
      printf("   %*d   ", 4, (iter->contents)->priority);

      // Go to the next line
      printf("\n");
    }

  // Return the error code
  return err;
}

int PCBDLL_free ( PCBDLL *node )
{
  int err = 0;

  // Free the memory at that PCBDLL node
  err = sys_free_mem( node );

  return err;
}

PCB *PCB_alloc ()
{
  // Allocate the PCB
  PCB *ret; 
  ret = (PCB *)sys_alloc_mem(sizeof(PCB));

  // Set pstack_top to the appropriate value
  ret->pstack_top = ret->pstack + SYS_STACK_SIZE - sizeof(context);

  // ... and return it.
  return ret;
}

PCB *PCB_setup ( char *pname, int ppriority, int pclass )
{
  // Initialize the return value PCB first
  PCB *ret;

  // First let's do some sanity checks...
  if ( PCB_find(pname) != NULL )
    {
      return NULL;
    }
  else if ( ppriority < -127 || ppriority > 128 )
    {
      return NULL;
    }
  else if (pclass != 1 && pclass != 0)
    {
      return NULL;
    }

  // Create the PCB using the PCB_alloc function
  ret = PCB_alloc();

  // Set the values of the PCB
  strcpy(ret->name, pname);
  ret->priority = ppriority;
  ret->pclass = pclass;
  ret->state = READY;

  // set the memory descriptors and stack to default values (todo)

  // Return a pointer to the PCB
  return ret;
}

PCB *PCB_find ( char *find )
{
  // Declare iterative integer, exit flag
  int i = 0;
  int lbreak = 0;
  
  // Declare PCB to iterate and return
  PCBDLL *iter = NULL;

  // Loop through the different queues...
  for ( i = 0; i < TDF_QUEUES && lbreak != 1; i++ )
    {
      iter = PRIORITY_QUEUES[i];
      // Loop through the individual queues until you find the right name
      while ( iter->next != NULL && lbreak != 1 )
	{
	  iter = iter->next;
	  if ( !strcmp(((iter->contents)->name), find ))
	    {
	      lbreak = 1;
	    }
	}
    }

  // If lbreak is not 1, then it wasn't found. Return NULL.
  if ( lbreak != 1 )
    {
      return NULL;
    }

  return iter->contents;
}

// Used for inserting new PCBs into the global queue
int PCB_insert ( PCBDLL *queue, PCB *proc, int newstate )
{
  // Initialize the error code and exit flag.
  int err = 0;
  int lbreak = 0;
  // Initialize two PCBDLL nodes: the new process and an iterator
  PCBDLL *newproc;
  PCBDLL *iter = queue;

  // First check to see if the PCB to insert is NULL, we don't want that
  if ( proc == NULL )
    {
      err = 1;
      return err;
    }

  // Create the new PCBDLL structure for the new process
  newproc = (PCBDLL *)sys_alloc_mem(sizeof(PCBDLL));
  newproc->contents = proc;

  // Find where to insert the PCB
  while ( iter->next != NULL && lbreak != 1 )
    {
      if ( ((iter->next)->contents)->priority >= proc->priority )
	{
	  iter = iter->next;
	}
      else
	{
	  lbreak = 1;
	}
    }

  // Update the pointers accordingly
  newproc->next = iter->next;
  newproc->prev = iter;
  if ( iter->next != NULL )
    {
      (iter->next)->prev = newproc;
    }
  iter->next = newproc;

  // Update the state of the process
  proc->state = newstate;
  
  // Return the error code.
  return err;
}

int PCB_remove ( PCB *proc )
{
  // Initialize the error code, iterator, and exit flag
  int err = 0;
  int i = 0;
  int lbreak = 0;

  // Initialize the PCBDLL iterator node
  PCBDLL *iter = NULL;

  // First check to make sure the process isn't NULL. If it is, we don't
  // want to even deal with it.
  if ( proc == NULL )
    {
      err = 1;
      return err;
    }

  // Loop through the different queues to find the PCB
  for ( i = 0; i < TDF_QUEUES && lbreak != 1; i++ )
    {
      iter = PRIORITY_QUEUES[i];
      // Loop through the individual queues until you find the right name
      while ( iter->next != NULL && lbreak != 1 )
	{
	  iter = iter->next;
	  if ( iter->contents == proc )
	    {
	      lbreak = 1;
	    }
	}
    }

  // Adjust the pointers around the PCB accordingly IF the process was found
  // (e.g. lbreak was set to 1)
  if ( lbreak == 1 )
    {
      (iter->prev)->next = iter->next;
      if (iter->next != NULL)
	{
	  (iter->next)->prev = iter->prev;
	}
      // Deallocate the PCBDLL node
      err = PCBDLL_free( iter );
    }
  // Otherwise, we didn't find the PCB and must return error code.
  else
    {
      err = 1;
    }

  // Return the error code.
  return err;
}

int PCB_free ( PCB *proc )
{
  // Initialize the error code
  int err = 0;

  // De-allocate the PCB memory
  err = sys_free_mem(proc);

  // Return the error code
  return err;
}

int PCB_print ( PCB *proc )
{
  // Initialize the error code
  int err = 0;

  // If the parameter is null, let's just quit
  if ( proc == NULL )
    {
      err = 1;
      return err;
    }

  // Print out the process name
  printf("Process Name: %s\n", proc->name);
  
  // Print out the class
  if (proc->pclass == APPLICATION)
    printf("Class: Application\n");
  else if (proc->pclass == SYSTEM)
    printf("Class: System\n");
  
  // Print out the state
  if (proc->state == READY)
    printf("State: Ready\n");
  else if (proc->state == BLOCKED)
    printf("State: Blocked\n");
  else if (proc->state == READYSUSPENDED)
    printf("State: Ready-Suspended\n");
  else if (proc->state == BLOCKEDSUSPENDED)
    printf("State: Blocked-Suspended\n");
  else if (proc->state == RUNNING)
    printf("State: Running\n");

  // Print out the priority
  printf("Priority: %d\n", proc->priority);

  // Return the error code
  return err;
}

PCB* givemeready(){
  if ( PRIORITY_QUEUES[READY]->next == NULL )
    return NULL;
  else {
    // No printy plx
    // printf("%s\n", (PRIORITY_QUEUES[READY]->next->contents)->name);
    return PRIORITY_QUEUES[READY]->next->contents;
  }
}

PCB* givemerunning(){
  if ( PRIORITY_QUEUES[RUNNING]->next == NULL )
    return NULL;
  else
    return PRIORITY_QUEUES[RUNNING]->next->contents;
}

int PCBDLL_freeall ()
{
  int i;
  int err = 0;
  PCB *killproc = NULL;

  // Loop through each of the queues
  for ( i = 0; i < TDF_QUEUES; i++ )
    {
      // While there's still stuff in each of the queues
      while ( PRIORITY_QUEUES[i]->next != NULL )
	{
	  // Find the process
	  killproc = PRIORITY_QUEUES[i]->next->contents;
	  // Remove it from the queue
	  err = PCB_remove (killproc);
	  // Deallocate the process
	  PCB_free (killproc);
	}
      // Deallocate the queue
      err = PCBDLL_free( PRIORITY_QUEUES[i] );
    }

  return err;
}
