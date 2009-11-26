/*
 * Image Subsampling
 * CS 350 Assignment 2
 * Use pthreads to resize images
 * Due: 2008/04/27
 * Author: Tim Bielawa
 * Email: tbielawa@csee.wvu.edu
*/

#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <semaphore.h>
#include "iplib2New.c"

void *resize(void *args);										 /* Threadded function */
image_ptr read_pnm(char *filename, int *rows, int *cols, int *type);	 /* Prototype for reading in image */
int getnum(FILE * fp);										/* prototype for reading ints from image header */
void write_pnm(image_ptr ptr, char *filename, int rows, int cols, int type);	/* Prototype for writing out new processed image */

/* Each thread gets a struct with the values it needs to know so it can do its computations */
struct imgArgs {
	int initColumn; /* Which column to start counting from */
	int *scale;	 /* Image scale factor */
	int *rows, *columns; /* rows and columns of ORIGINAL image */
	int *nonlin; /* address to the non-linear arrangement of the image read in */
	int tid; /* thread id, used for debugging */
	unsigned char *newImage; /* address to output image */
};

int main ( int argc, char *argv[] )
{
	printf("\nImage Manipulation Program for CS350\n\n");
	printf("        NOW WITH MORE THREADS!!!!\n\n");

	if (argc != 4) {
		printf("Wrong inputs: Run as: %s inFile outFile scaleFactor \n\n\n", argv[0]);
		printf("bye bye....");
		return 0;
	}
	
	image_ptr imagePtr; /* Image Read In */
	int rows, cols, type, s = atoi(argv[3]);
	imagePtr = read_pnm(argv[1], &rows, &cols, &type);
	
	/* Something about having an array representation of this image data
	 * rather than a linear representation seems much more intuitive */
	int nonlin[rows][cols];
	int i, j;
	for ( i = 0; i < rows; i++ ) {
		for ( j=0; j <= cols; j++) {
			nonlin[i][j] = imagePtr[i*cols + j];
		}
	}

	/* Allocate space for the image we're going to write OUT */
	unsigned char outputImage[rows / s][cols / s];
	
	/* Welcome to McDonalds.. bla bla bla */
	printf("Input File: %s\n", argv[1]);
	printf("Output File: %s\n", argv[2]);
	printf("Scale Factor: %d\n", s);
	printf("Input image has: \n %d rows\n %d cols\n", rows, cols);
	printf("Resulting image will have: \n %d rows\n %d cols\n", rows / s, cols / s);
	printf("Process will run using %d threads \n\n", rows / s);

	pthread_t threads[rows/s]; /* Map of all the threads */
	int rc, workingRows = 0;
	struct imgArgs threadStructs[rows/s]; 
	
	printf("Initializing threads...\n");
	for ( workingRows = 0; workingRows < rows/s; workingRows++) {
		threadStructs[workingRows].initColumn = workingRows*s;
		threadStructs[workingRows].scale = &s;
		threadStructs[workingRows].rows = &rows;
		threadStructs[workingRows].columns = &cols;
		threadStructs[workingRows].nonlin = &nonlin;
		threadStructs[workingRows].tid = workingRows;
		threadStructs[workingRows].newImage = &outputImage;
		
		rc = pthread_create(&threads[workingRows], NULL, resize, (void *) &threadStructs[workingRows]);
		
		if (rc) {
			printf("ERROR; return code from pthread_create() is %d\n", rc);
			exit(-1);
		}

	}
	
	printf("Calculations complete! Writing to file...\n");
	
	/* Hard work's done, write it to file */
	write_pnm((image_ptr) outputImage, argv[2], rows / s, cols / s, type);
	printf("Wrote: %s to file!\n", argv[2]);
	
	pthread_exit(NULL);
}

void *resize(void *args) {
	struct imgArgs *imgData;
	imgData = (struct imgArgs *) args;
	
	int workingRow = 0,  workingCol = 0, sum = 0, average = 0;

	/* must add (||row length|| * iterations) to initColumn to get a loopable effect
	 * workingRow == row iterations
	 * imgData->cols == row length */
	int offset;
	int newX = 0, newY = 0;
	for ( workingRow = 0 ; workingRow < *imgData->rows; workingRow++) {
		sum = 0;
		average = 0;
		offset = workingRow * (*imgData->columns);
		for ( workingCol = 0 ; workingCol < *imgData->scale; workingCol++) {
			sum += imgData->nonlin[offset + imgData->initColumn + workingCol];
		}
		average = sum/((*imgData->scale)); 
		newX = (imgData->initColumn + workingCol)/(*imgData->scale);
		newY = workingRow/(*imgData->scale);
		
		/* To save the average we calcualted for the new image we need to translate it's 2d x,y coordinate into a 1d coordinate.
		 * Basically, find the length of the rows for the shrunken image, multiply that by how many we've traversed thus far (newY),
		 * then add in how many units over horizonally we've calcualted for that row (newX).... */
		imgData->newImage[((*imgData->columns)/(*imgData->scale))*newY + newX] = average;
	}
	
	pthread_exit(NULL);
}
