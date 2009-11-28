
// shell.h
// Header file for the shell of the MPX operating system
//
// tours de force: http://www.ducksarepeople.com/tdf 

#ifndef SHELL_H
#define SHELL_H

// Functions here plzkthx
extern void shell ();
extern void welcome_message ();
extern void departing_message();
extern void display_prompt();
extern int exit_confirmation();
extern void change_prompt( char* );

#endif
