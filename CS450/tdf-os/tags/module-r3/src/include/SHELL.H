
// shell.h
// Header file for the shell of the MPX operating system
//
// tours de force: http://www.ducksarepeople.com/tdf 

#ifndef SHELL_H
#define SHELL_H

// Symbolic Constants here
#define BUFFER_SIZE 256
#define FNAME_SIZE 9

// Exit Behavior of the exit_confirmation (SHELL.C) function
#define SHELL_EXIT_CONFIRM 16
#define SHELL_EXIT_DENY 32

int SYS_REQ_ERR;
int CLEAN_BUFFER_ERR;
int EXIT_PROMPT_LOOP;
int buffer_size;
char BUFFER[BUFFER_SIZE];
char ARGUMENTS[BUFFER_SIZE-FNAME_SIZE];
char PARSED_CMD[FNAME_SIZE];
int err;
char EXIT_STRING[5];
int PARSER_ERROR;
int EXIT_CONFIRM;

// Functions here plzkthx
extern int shell ();
extern void welcome_message ();
extern void departing_message();
extern void display_prompt();
extern int exit_confirmation();

PCBDLL **PRIORITY_QUEUES;
params *params_p;
context *context_p;
char sys_stack[SYS_STACK_SIZE];

#endif
