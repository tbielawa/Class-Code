
// parser.h
// Buffers, cleans, waxes, and sanatizes input
// read from the prompt. Cant trust users....
//
// tours de force: http://www.ducksarepeople.com/tdf

#ifndef PARSER_H
#define PARSER_H

// Symbolic References
#define BUFFER_SIZE 256
#define FUN_NAME_SIZE 9

// Variable Declarations here plz


// Functions here plzkthx
int parse_buffer(char *buffer, char *func_name, char *args, int *arg_len);




#endif
