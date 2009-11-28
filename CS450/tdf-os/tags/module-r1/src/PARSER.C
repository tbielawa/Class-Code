
// parser.c
// Feed this your input buffer, and it will attempt to
// discern the command name from the arguments to it.
//
// tours de force: http://www.ducksarepeople.com/tdf

#include <stdio.h>
#include <string.h>
//#include "shell.h" //Provides max_buffer and fun_name_size
#include "parser.h"

int parse_buffer(char buffer[BUFFER_SIZE], char function[FUN_NAME_SIZE], char args[BUFFER_SIZE-FUN_NAME_SIZE], int *args_len) {
  int i, j;
  int satisfied;
  int found_func_name;
  int found_remaining_args;
  
  //initialize
  i = 0; //distance into the buffer
  j = 0; //counting length of 'function' name
  found_func_name = 0;
  found_remaining_args = 0;
  satisfied = 0;

  //get the function name
  while(!satisfied && i < strlen(buffer)) {
    if(buffer[i] == ' ') {
      if(j == 0) { //haven't read any actual chars yet
	i++;
	continue;
      } else { //have read some chars. Means we are at end of first word, e.g. "dfdf "
	found_func_name = !found_func_name;
	satisfied = !satisfied;
      }
    } else { //found a character
      function[j] = buffer[i];
      i++; j++; 
    }
  }
  
  // get the rest of the arg string
  satisfied = !satisfied;
  while(!satisfied && i < BUFFER_SIZE) {
    if(buffer[i] == ' ') { //looking for first non white-space character
      i++;
    } else {
      found_remaining_args = !found_remaining_args;
      satisfied = !satisfied;
    }
  }
  
  strncpy(args, buffer+i, strlen(buffer)-strlen(function));
  *args_len = strlen(buffer)-strlen(function);
  //printf("Function name is: '%s'\n", function);
  //printf("And now args is: '%s'\n", args);
  //printf("Length of Args is: '%d' characters.\n", *args_len);

  return 0;
}
