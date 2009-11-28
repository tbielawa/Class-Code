
// HISTORY.C
// Prints out the command history to the user, as well as appends the user's
// previous commands to the history.
//
// tours de force: http://www.ducksarepeople.com/tdf 

#include <stdio.h>
#include "tdf.h"
#include "history.h"

int history ( char *args )
{
  int err = 0;
  FILE *hist;
  char histout[HBS];

  hist = fopen( "C:\\ETC\\HISTORY", "r" );

  if (hist == NULL)
    {
      err = 1;
    }
  else
    {
      while ( !feof( hist ) )
	{
	  fgets (histout, HBS, hist );
	  printf( "%s", histout );
	}
      fclose(hist);
    }
  
  return err;
}

int append_history ( char *args )
{
  int err = 0;
  FILE *hist;

  hist = fopen( "C:\\ETC\\HISTORY", "a" );
  if (hist == NULL)
    {
      err = 1;
    }
  else
    {
      fprintf ( hist, "%s", args );
      fclose(hist);
    }

  return err;
}
