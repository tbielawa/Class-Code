
// VERSION.C
// Outputs the version informtion of tdf-os. This will eventually be merged
// into SHELL.C, but for now I'm going to keep it separate.
//
// tours de force: http://www.ducksarepeople.com/tdf 

#include <stdio.h>
#include "tdf.h"
#include "version.h"

int version ( char *args, int *len )
{

  int err; // Error number
  int allvers; // Boolean value for whether or not to output complete history
  FILE *vers; // Input file
  char versout[VBS]; // Version output buffer

  // Need to parse *args to get values of allvers, etc.
  // Find the real value of allvers (whether or not to output all versions)
  allvers = 0;

  // Open the version file for reading.
  // IMPORTANT: THIS WILL NEED TO BE ADJUSTED TO WORK IN DOS.
  vers = fopen( "C:\\SRC\\ETC\\VERSION", "r" );

  // If the file failed to open, set the error code
  if (vers == NULL)
    {
      err = 1;
    }
  else
    {
      fgets( versout, VBS, vers );
      printf( "%s", versout );
      // If requested, output the complete version history
      if ( allvers )
	{
	  while ( !feof( vers ) )
	    {
	      fgets( versout, VBS, vers );
	      printf( "%s", versout );
	    }
	}
      err = 0;
      fclose(vers);
    }
  // Fin
  return err;

}

