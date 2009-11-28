
// parser.c
// Feed this your input buffer, and it will attempt to
// discern the command name from the arguments to it.
//
// tours de force: http://www.ducksarepeople.com/tdf
//
/***********************************************
 * It turns out that parsing an input buffer 
 * brings up a lot of unique edge cases which 
 * must all be covered. Adding to the maddness
 * is the buffered input stream.
 * 
 * [1] - Find beginning of first word
 * [2] - Find end of first word
 * [3] - Find beginning of next word or end of line
 * [4] - Find end of second word
 * [5] - Find end of line
 * 
 * With all sorts of optionals and edge cases inbetween
 **********************************************/

// Comment this next line out for less stupidly verbose debugging
//#define DEBUG

#include <stdio.h>
#include <string.h>
#include "parser.h"

int parse_buffer(char *buffer, char *function, char *args) {
  int scanned_length = strlen(buffer);
  int max_step = scanned_length -1;
  int i = 0;
  int fname_len = 0;
  int fname_start = 0;
  char fname[FNAME_SIZE];
  char arg[BUFFER_SIZE-FNAME_SIZE];
  int arg_len = 0;
  int arg_start = 0;
  int arg_end = 0;
  int notAllWS = 1;
  memset(fname, '\0', sizeof(fname));
  memset(function, '\0', sizeof(fname));
  memset(arg, '\0', sizeof(arg));
  memset(args, '\0', sizeof(arg));
  
  // I don't want to deal with new lines and \0's ever again... 
  // this a step in the right direction
  if (scanned_length == BUFFER_SIZE-1 && buffer[BUFFER_SIZE-1] != '\n') {
    scanned_length++;
  }

  /*************** Step 1 ***************/
  //          Find the beginning
#ifdef DEBUG
  printf("+--------------------------------+\n");
  printf(" Entering stage 1 buffer parsing\n");

  printf("+--------------------------------+\n");
#endif


  // Iterate over whole string checking for non-whitespace
  while (*(buffer+i)) {
    if (isgraph(*(buffer+i)) && !isspace(*(buffer+i))) {
      break; //this is a good thing
    } else {
	i++;
    }
  }
  
  if (i <= max_step) { // Caught at least one non-ws
    notAllWS = !notAllWS;
    fname_start = i;
    fname_len = 1;
  } else { //Got to the acceptable end
#ifdef DEBUG
    printf("+--------------------------------+\n");
    printf(" It's all white space yo\n");
    printf("+--------------------------------+\n");
#endif DEBUG

    return PARSER_FAIL_WHITESPACE;
  }
 

#ifdef DEBUG
  printf("+--------------------------------+\n");
  printf("Entering stage 2 buffer parsing\n");
  printf("Read: %d characters thus far\n", i);
  printf("Last read character: '%d'/'%c'\n", *(buffer+i), *(buffer+i));
  printf("+--------------------------------+\n");
#endif
  /************** Step 2 ******************/
  //          Find the end

  // Loop until the end of this word
  while (*(buffer+(++i))) { //never enters loop if = \0
    if (isspace(*(buffer+i))) {
      break;
    } else {
      ++fname_len;
    }
  }

#ifdef DEBUG
  printf("+--------------------------------+\n");
  printf("Read: %d characters thus far\n", i);
  printf("Last character: '%d'/'%c'\n", *(buffer+i), *(buffer+i));
  printf("Should be newline or NULL or space.\n");
  printf("+--------------------------------+\n");
#endif DEBUG
  
  //One word, or did we just hit more ws?
  if (*(buffer+i)) {
    if (fname_len > FNAME_SIZE) {
#ifdef DEBUG
      printf("+--------------------------------+\n");
      printf(" Command name too long: %d chars\n", fname_len);
      printf("+--------------------------------+\n");
#endif DEBUG

      return PARSER_FAIL_LONGNAME;
    } else {
      // Set the first word
      strncpy(fname, (buffer+fname_start), fname_len);
      strncpy(function, (buffer+fname_start), fname_len);
#ifdef DEBUG
      printf("I think this is the command: '%s'\n", fname);
#endif
    }
  }

  /***************** Step 3 *****************/
  //      Find beginning of next word

#ifdef DEBUG
  printf("+--------------------------------+\n");
  printf("Going to begin attempting to find next word.\n");
  printf("+--------------------------------+\n");
#endif DEBUG


  /****************** Step 4 ****************/
  //        Find Beginning of next Part

  // Iterate over remaining string checking for non-whitespace
  while (*(buffer+(++i))) {
    if (isgraph(*(buffer+i)) && !isspace(*(buffer+i))) {
      arg_start = i;
      arg_len = 1;
#ifdef DEBUG
      printf("+--------------------------------+\n");
      printf("Read %d more characters, found: %c\n", i, *(buffer+i));
      printf("Reached beginning of next word.\n");
      printf("+--------------------------------+\n");
#endif DEBUG
      i++;
      break; //this is a good thing
    }
  }

  /****************** Step 5 *******************/
  //        Find end of Everything Else

  while(i < max_step) {
    if (isgraph(*(buffer+i)) && !isspace(*(buffer+i))) {
#ifdef DEBUG
      printf("Argument string length: %d\n", arg_len);
      printf(">%c\n", *(buffer+i));
#endif
      arg_len = i - arg_start + 1;
      arg_end = i;
    }
    i++;
  }

  // We've broken out of the observation loops
  // We have everything we needs
  strncpy(arg, (buffer+arg_start), arg_len);
  strncpy(args, (buffer+arg_start), arg_len);
#ifdef DEBUG
  printf("Found an arg string of length: %d\n", arg_len);
  printf("|Args| start at: %d; end at: %d\n", arg_start, arg_end);
  printf("|Args| reads: '%s'\n", arg);
#endif
  
#ifdef DEBUG
  printf("+--------------------------------+\n");
  printf("Last character seen: %c\n", *(buffer+arg_end));
  printf("Args ended at %d and strlen was %d\n", arg_end, i);
#endif DEBUG

  if (arg_len > 0) {
    return PARSER_WIN_HAS_ARGS;
  } else {
    return PARSER_WIN_SINGLETON;
  }
}
