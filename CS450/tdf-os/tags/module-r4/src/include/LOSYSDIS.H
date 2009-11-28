
// LOSYSDIS.H
// Responsible for dispatching and running all of the processes
// in the ready queue.
//
// tours de force http://ducksarepeople.com/tdf

#ifndef LOSYSDIS_H
#define LOSYSDIS_H

extern void interrupt dispatch();
extern void interrupt sys_call(void);
extern void dispatch_init();

#endif
