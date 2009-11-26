/*************************************************************************** 
 * File: iplib.c                                                           *
 *                                                                         *
 * Desc: general routines for reading and writing ppm files.               *
 * Modified from: Crane R, "A simplified approach to image processing",1997*
 ***************************************************************************/

#include <stdio.h>
#include <stdlib.h>

/* file types*/
#define PBM 4
#define PGM 5
#define PPM 6

typedef unsigned char *image_ptr;


image_ptr read_pnm(char *filename, int *rows, int *cols, int *type);
int getnum(FILE * fp);
void write_pnm(image_ptr ptr, char *filename, int rows, int cols,
               int type);


int ROWS, COLS, TYPE;

/***************************************************************************
 * Func: read_pnm                                                          *
 *                                                                         *
 * Desc: reads a portable bitmap file                                      *
 *                                                                         *
 * Params: filename - name of image file to read                           *
 *         rows - number of rows in the image                              *
 *         cols - number of columns in the image                           *
 *         type - file type                                                *
 *                                                                         *
 * Returns: pointer to the image just read into memory                     *
 ***************************************************************************/

image_ptr read_pnm(char *filename, int *rows, int *cols, int *type)
{
    int i;                      /* index variable */
    int row_size;               /* size of image row in bytes */
    int maxval;                 /* maximum value of pixel */
    FILE *fp;                   /* input file pointer */
    int firstchar, secchar;     /* first 2 characters in the input file */
    image_ptr ptr;              /* pointer to image buffer */
    unsigned long offset;       /* offset into image buffer */
    unsigned long total_size;   /* size of image in bytes */
    unsigned long total_bytes;  /* number of total bytes written to file */
    float scale;                /* number of bytes per pixel */


    /* open input file */
    if ((fp = fopen(filename, "rb")) == NULL) {
        printf("Unable to open %s for reading\n", filename);
        exit(1);
    }

    firstchar = getc(fp);
    secchar = getc(fp);

    if (firstchar != 'P') {
        printf("Sorry... This is not a PPM file!\n");
        exit(1);
    }


    *cols = getnum(fp);
    *rows = getnum(fp);

    *type = secchar - '0';

    ROWS = *rows;
    COLS = *cols;
    TYPE = *type;

    switch (secchar) {
        case '4':              /* PBM */
            scale = 0.125;
            maxval = 1;
            break;
        case '5':              /* PGM */
            scale = 1.0;
            maxval = getnum(fp);
            break;
        case '6':              /* PPM */
            scale = 3.0;
            maxval = getnum(fp);
            break;
        default:               /* Error */
            printf
                ("read_pnm: This is not a Portable bitmap RAWBITS file\n");
            exit(1);
            break;
    }

    row_size = (*cols) * scale;
    total_size = (unsigned long) (*rows) * row_size;

    ptr = (image_ptr) malloc(total_size);

    if (ptr == NULL) {
        printf("Unable to malloc %lu bytes\n", total_size);
        exit(1);
    }

    total_bytes = 0;
    offset = 0;
    for (i = 0; i < (*rows); i++) {
        total_bytes += fread(ptr + offset, 1, row_size, fp);
        offset += row_size;
    }

    if (total_size != total_bytes) {
        printf
            ("Failed miserably trying to read %ld bytes\nRead %ld bytes\n",
             total_size, total_bytes);
        exit(1);
    }

    fclose(fp);
    return ptr;
}

/***************************************************************************
 * Func: getnum                                                            *
 *                                                                         *
 * Desc: reads an ASCII number from a portable bitmap file header          *
 *                                                                         *
 * Param: fp - pointer to file being read                                  *
 *                                                                         *
 * Returns: the number read                                                *
 ***************************************************************************/

int getnum(FILE * fp)
{
    char c;                     /* character read in from file */
    int i;                      /* number accumulated and returned */

    do {
        c = getc(fp);
    }
    while ((c == ' ') || (c == '\t') || (c == '\n') || (c == '\r')); /* read until you reach whitespace */

    if ((c < '0') || (c > '9'))
        if (c == '#') {         /* chew off comments */
            while (c == '#') {
                while (c != '\n') /* read to the end of the line */
                    c = getc(fp);
                c = getc(fp);   /* start reading the next line */
            }
        } else {
            printf("Garbage in ASCII fields\n");
            exit(1);
        }
    i = 0;
    do {
        i = i * 10 + (c - '0'); /* convert ASCII to int */
        c = getc(fp);
    }
    while ((c >= '0') && (c <= '9'));

    return i;
}

/***************************************************************************
 * Func: write_pnm                                                         *
 *                                                                         *
 * Desc: writes out a portable bitmap file                                 *
 *                                                                         *
 * Params: ptr - pointer to image in memory                                *
 *         filename _ name of file to write image to                       *
 *         rows - number of rows in the image                              *
 *         cols - number of columns in the image                           *
 *         magic_number - number that defines what type of file it is      *
 *                                                                         *
 * Returns: nothing                                                        *
 ***************************************************************************/

void
write_pnm(image_ptr ptr, char *filename, int rows,
          int cols, int magic_number)
{
    FILE *fp;                   /* file pointer for output file */
    long offset;                /* current offset into image buffer */
    long total_bytes;           /* number of bytes written to output file */
    long total_size;            /* size of image buffer */
    int row_size;               /* size of row in bytes */
    int i;                      /* index variable */
    float scale;                /* number of bytes per image pixel */

    switch (magic_number) {
        case 4:                /* PBM */
            scale = 0.125;
            break;
        case 5:                /* PGM */
            scale = 1.0;
            break;
        case 6:                /* PPM */
            scale = 3.0;
            break;
        default:               /* Error */
            printf
                ("write_pnm: This is not a Portable bitmap RAWBITS file\n");
            exit(1);
            break;
    }

    /* open new output file */
    if ((fp = fopen(filename, "wb")) == NULL) {
        printf("Unable to open %s for output\n", filename);
        exit(1);
    }

    /* print out the portable bitmap header */
    fprintf(fp, "P%d\n%d %d\n", magic_number, cols, rows);
    if (magic_number != 4)
        fprintf(fp, "255\n");

    row_size = cols * scale;
    total_size = (long) row_size *rows;

    offset = 0;
    total_bytes = 0;
    for (i = 0; i < rows; i++) {
        total_bytes += fwrite(ptr + offset, 1, row_size, fp);
        offset += row_size;
    }

    if (total_bytes != total_size)
        printf("Tried to write %ld bytes...Only wrote %ld\n",
               total_size, total_bytes);

    fclose(fp);
}
