#ifndef HELP_H
#define HELP_H

typedef struct {
  char *name;
  char *description;
  char *usage;
  
  // or possibly
  //char name[8];
  //char description[400];
  //char usage[400];
} HELP_OBJ;

extern int help(char *);

#endif
