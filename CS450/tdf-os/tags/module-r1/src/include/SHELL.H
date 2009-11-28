
// shell.h
// Header file for the shell of the MPX operating system
//
// tours de force: http://www.ducksarepeople.com/tdf 

#ifndef SHELL_H
#define SHELL_H

//Symbolic Constants here
#define BUFFER_SIZE 256
#define FUN_NAME_SIZE 9



int SYS_REQ_ERR;
int CLEAN_BUFFER_ERR;
int EXIT_PROMPT_LOOP;
int buffer_size;
char BUFFER[BUFFER_SIZE];
char ARGUEMENTS[BUFFER_SIZE-FUN_NAME_SIZE];
char PARSED_CMD[FUN_NAME_SIZE];
int ARG_LEN;
int err;
char EXIT_STRING[5];
int PARSER_ERROR;

//Functions here plzkthx
extern int shell ();
extern void welcome_message ();
extern void departing_message();
extern void display_prompt();

#endif
