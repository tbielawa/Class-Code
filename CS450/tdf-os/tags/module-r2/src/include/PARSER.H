
// parser.h
// Buffers, cleans, waxes, and sanatizes input
// read from the prompt. Cant trust users....
//
// tours de force: http://www.ducksarepeople.com/tdf

#ifndef PARSER_H
#define PARSER_H

// Symbolic References
#define BUFFER_SIZE 256
#define FNAME_SIZE 9

// ERROR RETURN CODES
// PARSER_[win/fail]_[condition]
#define PARSER_FAIL_WHITESPACE -200
#define PARSER_FAIL_LONGNAME -201


#define PARSER_WIN_SINGLETON 210
#define PARSER_WIN_HAS_ARGS 211

// Variable Declarations here plz


// Functions here plzkthx
int parse_buffer(char *buffer, char *func_name, char *args);




#endif
