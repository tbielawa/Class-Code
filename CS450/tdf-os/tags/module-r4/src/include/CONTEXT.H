#ifndef CONTEXT_H
#define CONTEXT_H

#define SYS_STACK_SIZE 1024

// For getting args to sys_call off the stack
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

#endif
