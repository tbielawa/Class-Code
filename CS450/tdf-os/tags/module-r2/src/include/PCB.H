
// PCB.H
// Include file for stuff related to the Process Control Blocks and their
// related queues.
//
// tours de force: http://www.ducksarepeople.com/tdf


#ifndef PCB_H
#define PCB_H

// Define the number of queues
#define TDF_QUEUES 4

// Define the process/queue states
#define READY 0
#define BLOCKED 1
#define READYSUSPENDED 2
#define BLOCKEDSUSPENDED 3

// Define the process classes
#define APPLICATION 0
#define SYSTEM 1

typedef struct {
  char name[9];
  int pclass;
  int priority;
  int state;
  unsigned char pstack[1024];
  int memsize;
  unsigned char *loadaddr;
  unsigned char *execaddr;
} PCB;

struct PCBDLL {
  struct PCBDLL *prev;
  struct PCBDLL *next;
  PCB *contents;
};
typedef struct PCBDLL PCBDLL;

extern PCBDLL *PCBDLL_alloc ();
extern PCBDLL **PCBDLL_creation ( int );
extern int PCBDLL_print ( PCBDLL* );
extern PCB *PCB_alloc ();
extern PCB *PCB_setup ( char*, int, int, PCBDLL** );
extern PCB *PCB_find ( char*, PCBDLL** );
extern int PCB_insert ( PCBDLL*, PCB*, int );
extern int PCB_remove ( PCB*, PCBDLL** );
extern int PCB_free ( PCB* );
extern int PCB_print ( PCB* );

#endif
