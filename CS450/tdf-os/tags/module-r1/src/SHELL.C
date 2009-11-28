\
// shell.c
// Program to display the shell and accept user input. Commands are
// re-routed to external functions.
//
// tours de force: http://www.ducksarepeople.com/tdf

#include <stdio.h>
#include <string.h>
#include "mpx_supt.h"
#include "shell.h"
#include "tdf.h"
#include "parser.h"
#include "version.h"
#include "display.h"
#include "history.h"
#include "date.h"

int shell ( )
{

  int err = 0;
  buffer_size = BUFFER_SIZE;
  EXIT_PROMPT_LOOP = 0;
  strcpy(EXIT_STRING, "exit\n\0");

  // Vars for Command Handling
  //BUFFER = "";
  //PARSED_CMD = "";
  //ARGUEMENTS = "";
  //ARG_LEN = 0;

  welcome_message();
  while ( !EXIT_PROMPT_LOOP )
    {
      display_prompt(); // `tdf:$ ' currently

      SYS_REQ_ERR = sys_req( READ, TERMINAL, BUFFER, &buffer_size );

      if (strcmp(BUFFER,"\n\0")) {
	err = append_history(BUFFER, &buffer_size);
        PARSER_ERROR = parse_buffer(BUFFER, PARSED_CMD, ARGUEMENTS, &ARG_LEN);
      }

      if (!strcmp(PARSED_CMD,EXIT_STRING)) {
	printf("Exiting...");
	EXIT_PROMPT_LOOP = !EXIT_PROMPT_LOOP;
      }

      else if (!strcmp(PARSED_CMD,"version\n\0")) {
	err = version(ARGUEMENTS, &ARG_LEN);
      }

      else if (!strcmp(PARSED_CMD,"date\n\0")) {
	err = date(ARGUEMENTS);
      }

      else if (!strcmp(PARSED_CMD,"help\n\0")) {
	printf("version\ndate\ndisplay\nexit\nhistory\nhelp\n");
      }
      
      else if (!strcmp(PARSED_CMD,"display\n\0")) {
	printf("No files to display.\n");
      }

      else if (!strcmp(PARSED_CMD,"history\n\0")) {
	err = history(ARGUEMENTS, &ARG_LEN);
      }

      else {
	printf("%s: command not found.\n", PARSED_CMD);
      }
     
      strcpy(BUFFER, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0");
      strcpy(PARSED_CMD, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0");
      strcpy(ARGUEMENTS, " \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0");

      //Currently has no mappings for output values

    }
  departing_message();
  // Fin
  return err;
}

// Note to update make script to modify the TDF_OS_VERSION 
// symbolic constant at buld time. Tsupreme has compiler 
// options to define variables at buld time...
void welcome_message() {
  printf("Welcome to the Tours de Force System. Version 0.1.0\n\n", TDF_OS_VERSION);
}

// Add option to toggle displaying history on logout?
void departing_message() {
  printf("Thanks for hanging out with the TDF team!\n");
}

// In the future this should take a string argument to
// receive prompt value
void display_prompt() {
  printf("tdf:$ ");
}
