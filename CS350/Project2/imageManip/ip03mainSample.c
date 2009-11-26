/*************************************************************************** 
 * File: iplib2main.c                                                      
 * 
 *                                                                         
 * Desc: Sample use of the function calls defined in iplib2.c
 *       opens an image file, computes some values using the pixel
 *       values, and  writes a small subimage block to an image file.
 ***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "iplib2New.c"

#define rr 200
#define cc 100

// typedef unsigned char *image_ptr;


image_ptr read_pnm(char *filename, int *rows, int *cols, int *type);
int getnum(FILE * fp);
void write_pnm(image_ptr ptr, char *filename, int rows, int cols,
               int type);

int ROWS, COLS, TYPE;


int main(int argc, char **argv)
{
    image_ptr imagePtr, imagePtr2;
    unsigned char image2[rr][cc]; /* space for output image */
    image_ptr imageNegPtr;


    int rows, cols, type;
    int i = 0, j = 0, value = 0, count = 0;
    int tp;
    double ave = 0;
    char aveStr[10], *aveStrEnd;

    /* check inputs */
    if (argc != 4) {
        printf("wrong inputs: use %s infile out1 out2 \n", argv[0]);
        return 0;
    }

/*    first read-in the image */
    printf("reading input image ... \n");

    imagePtr = read_pnm(argv[1], &rows, &cols, &type);

    printf("image read successfully \n");
    printf("rows=%d, cols=%d, type=%d \n", rows, cols, type);
    /* printf("rows=%d, cols=%d, type=%d \n", ROWS, COLS, TYPE); */

    /* print out some greylevel pixel values */
    value = 0;
    for (i = 0; i < 10; i++) {
        value = value + imagePtr[i];
        ave = (double) value / (i + 1);
        /*   aveStr = lltostr((long long) value, aveStrEnd); */
        sprintf(aveStr, "%f", ave);
        printf("i=%d, pixel value=%d, sum=%d, ave=%s\n", i, imagePtr[i],
               value, aveStr);
    }

    /*
       /* now  write a small image subblock  to a file - to argv[2] 
       /* simply use the first rr x cc pixel block  in the input image 
     */

    tp = 5;                     /* type==5 */

    count = 0;
    for (i = 0; i < rr; i++)
        for (j = 0; j < cc; j++) {
            image2[i][j] = imagePtr[i * cols + j];
        }

    /* image2 now contains our rr x cc sub-image block */
    imagePtr2 = (image_ptr) image2;

    //...
    // you can do calculations on the image pixels here
    //...

    printf("\n Now writing to image file ... \n");
    printf("rows=%d, cols=%d, type=%d \n", rr, cc, tp);

    write_pnm(imagePtr2, argv[2], rr, cc, tp);


    /* image negatives  */

    imageNegPtr =
        (image_ptr) malloc(rows * cols * (sizeof(unsigned char)));

    // ... codes for image negative here 



    printf("\n Now writing negative image file ... \n");
    printf("rows=%d, cols=%d, type=%d \n", rows, cols, type);

    write_pnm(imageNegPtr, argv[3], rows, cols, type);



    return 0;
}
