
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
#include "pcb.h"
#include "date.h"
#include "display.h"
#include "help.h"
#include "history.h"
#include "load.h"
#include "loadr3.h"
#include "losysdis.h"
#include "mpx_supt.h"
#include "parser.h"
#include "pcbmake.h"
#include "pcbman.h"
#include "pcbshow.h"
#include "shell.h"
#include "tdf.h"
#include "version.h"

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
char *PROMPT = "tdf:$";

void shell() {
  int err = 0;
  extern PCBDLL **PRIORITY_QUEUES;

  buffer_size = BUFFER_SIZE;
  EXIT_PROMPT_LOOP = 0;
  strcpy(EXIT_STRING, "exit\0");

  welcome_message();

  // Debugging check
  // givemeready();

  while (!EXIT_PROMPT_LOOP) {
    display_prompt(); // `tdf:$ ' currently
    buffer_size = BUFFER_SIZE;
    SYS_REQ_ERR = sys_req(READ, TERMINAL, BUFFER, &buffer_size);
    err = append_history(BUFFER);
    PARSER_ERROR = parse_buffer(BUFFER, PARSED_CMD, ARGUMENTS);
    // The most trivial case
    if (!strcmp(BUFFER,"\n\0")) { //Just a New Line
      continue;
    }

    switch (PARSER_ERROR) {
    case PARSER_FAIL_WHITESPACE:
      continue;
      break;
    case PARSER_FAIL_LONGNAME:
      printf("Invalid command name entered. Must be less than 9 characters.\n");
      continue;
      break;
    case PARSER_WIN_SINGLETON: //This is linked to PARSER_WIN_HAS_ARGS which follows
    case PARSER_WIN_HAS_ARGS:
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
    } /* else if (!strcmp(PARSED_CMD, "dispatch")) {
	 dispatch ( );
	 } */ else if (!strcmp(PARSED_CMD, "display") || !strcmp(PARSED_CMD, "ls")) {
      display(ARGUMENTS);
      continue;
    } else if (!strcmp(PARSED_CMD, "load")) {
      load( ARGUMENTS );
    } /* else if (!strcmp(PARSED_CMD, "loadr3")) {
	 loadr3 ( );
	 } */ else if (!strcmp(PARSED_CMD, "history")) {
      history(ARGUMENTS);
    }
   /* else if (!strcmp(PARSED_CMD, "pblock")) {
       pblock(ARGUMENTS);
    } else if (!strcmp(PARSED_CMD, "pcreate")) {
       pcreate(ARGUMENTS); 
    } */ else if (!strcmp(PARSED_CMD, "kill")) {
      pdelete(ARGUMENTS);
    } else if (!strcmp(PARSED_CMD, "presume")) {
      presume(ARGUMENTS);
    } else if (!strcmp(PARSED_CMD, "psetprio")) {
      psetprio(ARGUMENTS);
    } else if (!strcmp(PARSED_CMD, "pshow")) {
      pshow(ARGUMENTS);
    } else if (!strcmp(PARSED_CMD, "pshowall")) {
      pshowall();
    } else if (!strcmp(PARSED_CMD, "pshowblk")) {
      pshowblk();
    } else if (!strcmp(PARSED_CMD, "pshowrd")) {
      pshowrd();
    } else if (!strcmp(PARSED_CMD, "psuspend")) {
      psuspend(ARGUMENTS);
    } 
    /* else if (!strcmp(PARSED_CMD, "punblock")) {
       punblock(ARGUMENTS);
       } */ else if (!strcmp(PARSED_CMD, "version")) {
      version(ARGUMENTS);
    } else if (!strcmp(PARSED_CMD, "help")) {
      help(ARGUMENTS);
    } else if (!strcmp(PARSED_CMD, "prompt")) {
      change_prompt(ARGUMENTS);
    } else {
      //printf("Command not found.\n");
      continue;
    }
  }
  departing_message();

  // Clean up our queues
  PCBDLL_freeall( );

  return;
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
  printf( "%s ", PROMPT );
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

void change_prompt (char *argstr) {
  strcpy( PROMPT, argstr );
}
