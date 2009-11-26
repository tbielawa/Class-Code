/*
 * Image Subsampling
 * CS 350 Assignment 3
 * Due: 2008/04/30
 * Author: Tim Bielawa
 * Email: tbielawa@csee.wvu.edu
 * Description: Runs from command line, requires 4 arguments (inputImage, 
 *  outputImage, reductionFactor, threadsAtOnce) Reads into memory 
 *  inputImage. Spawns at most threadsAtOnce 'server' threads that reduce
 *  the image down by a factor of reductionFactor. Takes the result from 
 *  those calculations and writes it to outputImage
*/

#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <semaphore.h>
#include "iplib2New.c"

void *resize(void *args);	/* Threadded function */
image_ptr read_pnm(char *filename, int *rows, int *cols, int *type);	/* Prototype for reading in image */
int getnum(FILE * fp);		/* prototype for reading ints from image header */
void write_pnm(image_ptr ptr, char *filename, int rows, int cols, int type);	/* Prototype for writing out new processed image */

/* Each thread gets a struct with the values it needs to know so it can do its computations */
struct imgArgs {
    int initColumn;		/* Which column to start counting from */
    int *scale;			/* Image scale factor */
    int *rows, *columns;	/* rows and columns of ORIGINAL image */
    int *nonlin;		/* address to the non-linear arrangement of the image read in */
    int tid;			/* thread id, used for debugging */
    unsigned char *newImage;	/* address to output image */
};

int main(int argc, char *argv[])
{
    printf("\n");
    printf("%15c########################################\n", ' ');
    printf("%15c# Image Manipulation Program for CS350 #\n", ' ');
    printf("%15c#        NOW WITH MORE THREADS!!!!     #\n", ' ');
    printf("%15c########################################\n\n", ' ');

    if (argc != 5) {
	printf
	    ("Wrong inputs: Run as: %s inFile outFile scaleFactor threads\n\n",
	     argv[0]);
	printf("bye bye....\n");
	return 0;
    }

    image_ptr imagePtr;		/* Image Read In */
    int rows, cols, type, s = atoi(argv[3]);
    imagePtr = read_pnm(argv[1], &rows, &cols, &type);
    int requestedThreads = atoi(argv[4]);

    /* Something about having an array representation of this image data
     * rather than a linear representation seems much more intuitive */
    int nonlin[rows][cols];
    int i, j;
    for (i = 0; i < rows; i++) {
	for (j = 0; j <= cols; j++) {
	    nonlin[i][j] = imagePtr[i * cols + j];
	}
    }

    /* Allocate space for the image we're going to write OUT */
    unsigned char outputImage[rows / s][cols / s];

    /* Welcome to McDonalds.. bla bla bla */
    printf("Input File: %s\n", argv[1]);
    printf("Output File: %s\n", argv[2]);
    printf("Scale Factor: %d\n", s);
    printf("Input image has: \n %d rows\n %d cols\n", rows, cols);
    printf("Resulting image will have: \n %d rows\n %d cols\n", rows / s,
	   cols / s);
    printf
	("Process will try to run using %d thread server(s) at a time\n\n",
	 requestedThreads);

    pthread_t threads[cols / s];	/* Map of all the threads */
    int rc, workingCols = 0, threadsCreated = 0, remainingChunks =
	rows / s, threadJoining;
    long int status;		/* passed to pthread_join as an address so we can check on their finishing status */

    struct imgArgs threadStructs[cols / s];

    /* here's the process..... 
     * make batches of threads up to requestedThreads
     * keep doing that and making sure they all finish executing (join each) UNTIL...
     * remaining chunks <= requestedThreads
     * move to the "catch all run" of thread building.
     * this last thread initialization will create <= requestedThreads.
     * we only ever had alive UP TO 'requestedThreads' at once because we can only run with 
     * 'requestedThreads' server threads (read from argv[4])
     * ....
     * along the way we keep track of how many have been created to date with 'threadsCreated'
     * each batch uses workingRows to keep track of how many its made in that batch
     * workingCols shall never exceed requestedThreads but MAY be equal to requestedThreads
     */

    printf("Initializing threads...\n");
    int startPoint;
    while (remainingChunks > requestedThreads) {	/* "until remainingChunks <= requested Threads" */
	for (workingCols = 0; workingCols < requestedThreads;
	     workingCols++) {
	    threadStructs[threadsCreated].initColumn = threadsCreated * s;
	    threadStructs[threadsCreated].scale = &s;
	    threadStructs[threadsCreated].rows = &rows;
	    threadStructs[threadsCreated].columns = &cols;
	    threadStructs[threadsCreated].nonlin = &nonlin;
	    threadStructs[threadsCreated].tid = threadsCreated;
	    threadStructs[threadsCreated].newImage = &outputImage;

	    rc = pthread_create(&threads[threadsCreated], NULL, resize,
				(void *) &threadStructs[threadsCreated]);

	    if (rc) {
		printf("ERROR; return code from pthread_create() is %d\n",
		       rc);
		exit(-1);
	    }
	    remainingChunks--;
	    threadsCreated++;
	}			/* End batch thread creation process */

	/* Join the last spawned threads and wait for them all to finish processing before continuing */
	threadJoining = threadsCreated - requestedThreads;	/* Join from where we last started spawning threads */
	for (; threadJoining < threadsCreated; threadJoining++) {
	    rc = pthread_join(threads[threadJoining], &status);
	    if (rc) {
		printf("error joining thread %d\n", threadJoining);
		exit(-1);
	    }

	}			/* End thread joining process */
    }				/* End while: remainingChunks > requestedThreads */


    /* Details at this point: either you requested <= the number of threads required to process the image
     * or we've calculated all the thread batches up to the point where we have (remainingChunks <= requestedThreads)
     */
    for (; threadsCreated < cols / s; threadsCreated++) {
	threadStructs[threadsCreated].initColumn = threadsCreated * s;
	threadStructs[threadsCreated].scale = &s;
	threadStructs[threadsCreated].rows = &rows;
	threadStructs[threadsCreated].columns = &cols;
	threadStructs[threadsCreated].nonlin = &nonlin;
	threadStructs[threadsCreated].tid = threadsCreated;
	threadStructs[threadsCreated].newImage = &outputImage;
	rc = pthread_create(&threads[threadsCreated], NULL, resize,
			    (void *) &threadStructs[threadsCreated]);

	if (rc) {
	    printf("ERROR; return code from pthread_create() is %d\n", rc);
	    exit(-1);
	}
    }

    /* Join the last spawned threads and wait for them all to finish processing before continuing */
    threadJoining = threadsCreated - remainingChunks;	/* Join from where we last started spawning threads */
    for (; threadJoining < threadsCreated; threadJoining++) {
	rc = pthread_join(threads[threadJoining], &status);
	if (rc) {
	    printf("error joining thread %d\n", threadJoining);
	    exit(-1);
	}
    }

    printf("Calculations complete! Writing to file...\n");
    /* Hard work's done, write it to file */
    write_pnm((image_ptr) outputImage, argv[2], rows / s, cols / s, type);
    printf("Wrote: %s to file!\n", argv[2]);

    pthread_exit(NULL);
}

void *resize(void *args)
{
    struct imgArgs *imgData;
    imgData = (struct imgArgs *) args;

    int workingRow = 0, workingCol = 0, sum = 0, average = 0;

    /* must add (||row length|| * iterations) to initColumn to get a loopable effect
     * workingRow == row iterations
     * imgData->cols == row length */
    int offset;
    int newX = 0, newY = 0;
    for (workingRow = 0; workingRow < *imgData->rows; workingRow++) {
	sum = 0;
	average = 0;
	offset = workingRow * (*imgData->columns);
	for (workingCol = 0; workingCol < *imgData->scale; workingCol++) {
	    sum +=
		imgData->nonlin[offset + imgData->initColumn + workingCol];
	}
	average = sum / ((*imgData->scale));

	/* the following two line of code brought to you by integer division */
	/* /me applauds integer division */
	newX = (imgData->initColumn + workingCol) / (*imgData->scale);
	newY = workingRow / (*imgData->scale);
	printf("Mean at(%d, %d) is: %d\n", newX, newY, average);
	/* To save the average we calcualted for the new image we need to translate it's 2d x,y coordinate into a 1d coordinate.
	 * Basically, find the length of the rows for the shrunken image, multiply that by how many we've traversed thus far (newY),
	 * then add in how many units over horizonally we've calcualted for that row (newX).... */
	imgData->newImage[((*imgData->columns) / (*imgData->scale)) *
			  newY + newX] = average;
    }

    pthread_exit(NULL);
}
