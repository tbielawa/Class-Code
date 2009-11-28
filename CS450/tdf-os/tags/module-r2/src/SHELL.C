
// shell.c
// Program to display the shell and accept user input. Commands are
// re-routed to external functions.
//
// tours de force: http://www.ducksarepeople.com/tdf
//
// Comment this next define out to shut the debugging notices off
//#define DEBUG


#include <stdio.h>
#include <string.h>
#include "date.h"
#include "display.h"
#include "help.h"
#include "history.h"
#include "mpx_supt.h"
#include "parser.h"
#include "pcb.h"
#include "pcbmake.h"
#include "pcbman.h"
#include "pcbshow.h"
#include "shell.h"
#include "tdf.h"
#include "version.h"

int shell() {
  int err = 0;
  
  // Makin ur queues PCBDLL_CREATION
  PCBDLL **PRIORITY_QUEUES;
  PRIORITY_QUEUES = PCBDLL_creation( TDF_QUEUES );

  buffer_size = BUFFER_SIZE;
  EXIT_PROMPT_LOOP = 0;
  strcpy(EXIT_STRING, "exit\0");

  welcome_message();

  while (!EXIT_PROMPT_LOOP) {
    display_prompt(); // `tdf:$ ' currently
    
    SYS_REQ_ERR = sys_req(READ, TERMINAL, BUFFER, &buffer_size);
    err = append_history(BUFFER);
    PARSER_ERROR = parse_buffer(BUFFER, PARSED_CMD, ARGUMENTS);
#ifdef DEBUG
    printf("SYS_REQ_ERR: %d\n", SYS_REQ_ERR);
    printf("PARSER_ERROR: %d\n", PARSER_ERROR);
    printf("APPEND_HISTORY: %d\n", err);
#endif
    // The most trivial case
    if (!strcmp(BUFFER,"\n\0")) { //Just a New Line
      continue;
    }

    switch (PARSER_ERROR) {
    case PARSER_FAIL_WHITESPACE:
#ifdef DEBUG
      printf("Thanks for the whitespace jerk\n");
      printf("No command entered\n");
#endif
      continue;
      break;
    case PARSER_FAIL_LONGNAME:
      printf("Invalid command name entered. Must be less than 9 characters.\n");
      continue;
      break;
    case PARSER_WIN_SINGLETON: //This is linked to PARSER_WIN_HAS_ARGS which follows
#ifdef DEBUG
      printf("Going to run the command: \"%s\" with NULL argument string.\n", PARSED_CMD);
#endif
    case PARSER_WIN_HAS_ARGS:
#ifdef DEBUG
      printf("Going to run the command: \"%s\"\n", PARSED_CMD);
      printf("With the following argument string:\n");
      printf("\t\"%s\"\n", ARGUMENTS);
#endif
      if (!strcmp(PARSED_CMD,EXIT_STRING)) { //Equal to EXIT_STRING
	if(exit_confirmation() == SHELL_EXIT_CONFIRM) {
	  EXIT_PROMPT_LOOP = !EXIT_PROMPT_LOOP;
	  break;
	} else {
	  continue;
	}
      }
      break;
    default:
      printf("I have no idea how you got here. File a bug report!\n");
      printf("Parser exited wth status of: %d\n", PARSER_ERROR);
      continue;
      break;
    }

    if (!strcmp(PARSED_CMD, "date")) {
      date(ARGUMENTS);
    } else if (!strcmp(PARSED_CMD, "display")) {
      display(ARGUMENTS);
      continue;
    } else if (!strcmp(PARSED_CMD, "history")) {
      history(ARGUMENTS);
    } else if (!strcmp(PARSED_CMD, "pblock")) {
      pblock(ARGUMENTS, PRIORITY_QUEUES);
    } else if (!strcmp(PARSED_CMD, "pcreate")) {
      pcreate(ARGUMENTS, PRIORITY_QUEUES);
    } else if (!strcmp(PARSED_CMD, "pdelete")) {
      pdelete(ARGUMENTS, PRIORITY_QUEUES);
    } else if (!strcmp(PARSED_CMD, "presume")) {
      presume(ARGUMENTS, PRIORITY_QUEUES);
    } else if (!strcmp(PARSED_CMD, "psetprio")) {
      psetprio(ARGUMENTS, PRIORITY_QUEUES);
    } else if (!strcmp(PARSED_CMD, "pshow")) {
      pshow(ARGUMENTS, PRIORITY_QUEUES);
    } else if (!strcmp(PARSED_CMD, "pshowall")) {
      pshowall(PRIORITY_QUEUES);
    } else if (!strcmp(PARSED_CMD, "pshowblk")) {
      pshowblk(PRIORITY_QUEUES);
    } else if (!strcmp(PARSED_CMD, "pshowrd")) {
      pshowrd(PRIORITY_QUEUES);
    } else if (!strcmp(PARSED_CMD, "psuspend")) {
      psuspend(ARGUMENTS, PRIORITY_QUEUES);
    } else if (!strcmp(PARSED_CMD, "punblock")) {
      punblock(ARGUMENTS, PRIORITY_QUEUES);
    } else if (!strcmp(PARSED_CMD, "version")) {
      version(ARGUMENTS);
    } else if (!strcmp(PARSED_CMD, "help")) {
      help(ARGUMENTS);
    } else {
      //printf("Command not found.\n");
      continue;
    }
  }
  departing_message();
  return err;
}

// Note to update make script to modify the TDF_OS_VERSION 
// symbolic constant at buld time. Tsupreme has compiler 
// options to define variables at build time...
void welcome_message() {
  printf("Welcome to the Tours de Force System\n");
  version("");
  printf("\n\n");
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

// Exit confirmation
// Returns 
int exit_confirmation() {
  char EXBUF[10];
  int exit_status;
  int length = 10;
  printf("\nQuit?\n");
  printf("(N/y): ");
  exit_status = sys_req(READ, TERMINAL, EXBUF, &length);
#ifdef DEBUG
  printf("Exit status returned: %d\n", exit_status);
  printf("Entered choice was: \"%s\"\n", EXBUF);
#endif
  if (exit_status == 2) {
    if (!strcmp(EXBUF,"Y\n\0") || !strcmp(EXBUF,"y\n\0")) {
      return SHELL_EXIT_CONFIRM;
    } else {
      return SHELL_EXIT_DENY;
    }
  } else {
    return SHELL_EXIT_DENY;
  }
}
