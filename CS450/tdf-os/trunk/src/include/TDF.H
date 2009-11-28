
// tdf.h
// Header file for initializing the MPX operating system
//
// tours de force: http://www.ducksarepeople.com/tdf 

#ifndef TDF_H
#define TDF_H

#include "PCB.H"

// Constant Defitions go here mmkayyy
#define TDF_OS_VERSION "0.0.1"

// Symbolic Constants here
#define BUFFER_SIZE 256
#define FNAME_SIZE 9

// Exit Behavior of the exit_confirmation (SHELL.C) function 
#define SHELL_EXIT_CONFIRM 16
#define SHELL_EXIT_DENY 32

#define SYS_STACK_SIZE 4096
typedef unsigned char byte;

typedef struct {
  int op_code;
  int device_id;
  byte *buff_addr;
  int *count_addr;
} params;

typedef struct {
  unsigned int BP, DI, SI, DS, ES;
  unsigned int DX, CX, BX, AX;
  unsigned int IP, CS, FLAGS;
} context;

extern PCBDLL **PRIORITY_QUEUES;
extern params *params_p;
extern context *context_p;
extern char sys_stack[SYS_STACK_SIZE];

// Functions Go Down Here
// use 'extern' before the return type
//extern void shell();
//extern int clean_buffer(char*, int*);

#endif

