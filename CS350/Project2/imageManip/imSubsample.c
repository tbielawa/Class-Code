/*
 * Image Subsampling
 * CS 350 Assignment 2
 * Due: 2008/03/20
 * Author: Tim Bielawa
 * Email: tbielawa@csee.wvu.edu
*/
#include <stdio.h>
#include <stdlib.h>
#include "iplib2New.c"

 /* Need space for the read in image */
 /* need space for the output image */
 /* Space for each sub chunklet of original image? */

image_ptr read_pnm(char *filename, int *rows, int *cols, int *type); /* Prototype for reading in image */
int getnum(FILE * fp);          /* prototype for reading ints from image header */
void write_pnm(image_ptr ptr, char *filename, int rows, int cols, int type); /* Prototype for writing out new processed image */
int ROWS, COLS, TYPE;           /* used internally */

int main(int argc, char *argv[])
{
    printf("\n\nImage Manipulation Program for CS350\n\n");

    if (argc != 4) {
        printf("Wrong inputs: Run as: %s inFile outFile scaleFactor \n",
               argv[0]);
        return 0;
    }

    image_ptr imagePtr;
	int rows, cols, type, s = atoi ( argv[3] );
	imagePtr = read_pnm ( argv[1], &rows, &cols, &type );
    unsigned char outputImage[rows/s][cols/s];
		
    printf("Input File: %s\n", argv[1]);
    printf("Output File: %s\n", argv[2]);
    printf("Scale Factor: %d\n", s);
		
	printf("Input image has: \n %d rows\n %d cols\n", rows, cols);
	printf("Resulting image will have: \n %d rows\n %d cols\n", rows/s, cols/s);

	int j, sp, sp1, i, k, l;
	unsigned char sum;
		
	sp = 0; l = 0;
	for ( j = 0; j < rows/s; j++, sp += s )
		{
			sp1 = sp;
			for ( i = 0; i < rows/s; i++ )
				{
					l = 0;
					while ( l < s ) {
						sum = 0; k = 0;
						while ( k < s )
						{
							sum += imagePtr[ sp1 + k ];
							printf("(%d, %d) %d; %d; \n", i, j, imagePtr[ sp1 + k ], sum);
							k++;
						}

						l++;
						outputImage[i][j] = outputImage[i][j] + sum/s;
						sp1 += rows;
					}
				}
		}

	write_pnm ( (image_ptr) outputImage, argv[2], rows/s, cols/s, type);
	printf("Wrote: %s to file.\n", argv[2]);
		

    return 0;
}
