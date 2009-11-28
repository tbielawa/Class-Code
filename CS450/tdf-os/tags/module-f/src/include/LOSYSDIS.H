
// LOSYSDIS.H
// Responsible for dispatching and running all of the processes
// in the ready queue.
//
// tours de force http://ducksarepeople.com/tdf

#include "PCB.H"

#ifndef LOSYSDIS_H
#define LOSYSDIS_H

struct IOD {
  char *name;
  PCB *pcb;
  int type;
  char *transfer_buffer;
  int *count;
  struct IOD *next;
};
typedef struct IOD IOD;

typedef struct {
  int event_flag;
  int count;
  IOD *head;
  IOD *tail;
} IOCB;

extern void interrupt dispatch();
extern void interrupt sys_call(void);
extern void dispatch_init();
extern void IO_scheduler( void );

#endif
