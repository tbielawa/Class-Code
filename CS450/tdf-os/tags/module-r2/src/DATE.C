
// DATE.C
// File to report/update the system date in tdf.
//
// tours de force: http://www.ducksarepeople.com/tdf


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "mpx_supt.h"

int date(char* argstr)
{
  date_rec* date_p;
  int err = 0, d, m, y;
  char *tokenPtr;
  char *months[12] = {"January","February","March","April","May","June","July", "August","September","October","November","December"};
  char *day = sys_alloc_mem(2);
  char *month = sys_alloc_mem(2);
  char *year = sys_alloc_mem(4);

  tokenPtr = strtok(argstr," "); // tokenize those args

  if(tokenPtr == NULL){
    sys_get_date(date_p);
    printf("%s %d %d\n", months[date_p->month], date_p->day, date_p->year);
    return err;
  }
  
  while (tokenPtr != NULL) {    
    if(!strcmp(tokenPtr, "-s\0")){
      tokenPtr = strtok(NULL, " "); // next token plz
      
      if(strlen(tokenPtr) != 8){ // if it ain't 8, we know they fucked up
	printf("Invalid date string.\n");
	break;
      }

      // grab those strings
      strncpy(year, tokenPtr, 4);
      strncpy(month, tokenPtr + 4, 2);
      strncpy(day, tokenPtr + 6, 2);

      // leading zeros? eh, let's make em ints anyway...
      m = atoi(month)-1;
      d = atoi(day);
      y = atoi(year);

      // are they even valid?
      if(validDate(d,m,y)){
	date_p->day = d;
	date_p->month = m;
	date_p->year = y;
	err = sys_set_date(date_p);
	printf("Changing system date to %s %d %d\n", months[m], d, y);
	}
      else{
	printf("Invalid date string.\n");
	break;
      }
    }
    
    if(!strcmp(tokenPtr, "-h\0")){
      printf("Usage of date:\n\tdate -s yyyymmdd\tChange the system date to the date specified.\n");
    }
    
    tokenPtr = strtok(NULL, " ");
  }
  return err;
}

int validDate(int day, int month, int year){
  int daysIn[12] = {31,28,31,30,31,30,31,31,30,31,30,31};
  int yeah = 0;
  if((month <= 12) && (month > 0) && (day < daysIn[month]) && (year > 0))
    yeah = 1;
  return yeah;
}
