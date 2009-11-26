/* String Manipulation by Tim Bielawa
 * Email: tbielawa@csee.wvu.edu
 * CS 350 Assignment 2
 * File: analysis.c
 * Due Date: 2008/4/03
 */

#include <stdio.h>
#include <ctype.h>

#define MAXWLEN 30		/* Max Word Length */
#define MAXWCNT 1000		/* Max Words to Read in */

int asciiTable[128];		/* Keep track of each character */
FILE *infile, *outfile;
int j = 0;
char wordList[MAXWCNT][MAXWLEN];
int wordStats[MAXWCNT][2];

void printAlphabetVsOccur(void);
void makeWordStats();
void printLengthVsOccur(void);
void printWordVsOccur(void);
void printWordVsOccurByWord(void);
void printWordVsOccurByOccur(void);

int main(int argc, char *argv[])
{
    if (argc < 2) {
	printf("Not enough arguments.\n Run as: %s infile [outfile]\n",
	       argv[0]);
	return 0;		/* Fail at this point, not enough arguments */
    }

    printf("\n\n\n%20cString Data Collection Program\n", ' ');

    if ((infile = fopen(argv[1], "r")) == NULL) {
	printf
	    ("The file '%s' was unreadable. Check your input and try again.\n",
	     argv[1]);
	return 0;		/* Bad input file, stop executing */
    }

    int i;			/* Represents word length/character position, word */
    char tempChar;

    while (!feof(infile)) {
	tempChar = getc(infile);
	i = 0;

	if (tempChar == ' ') /* Ignore consecutive spaces */
	    continue;

	while (tempChar != ' ' && !feof(infile)) {
	    wordList[j][i] = tempChar;
	    asciiTable[tolower(tempChar)]++;	/* Increment the count of that letter */
	    i++;
	    tempChar = getc(infile);
	}
	
	j++;
    }

    printAlphabetVsOccur();
    makeWordStats();
}

void printAlphabetVsOccur()
{
    printf("%15c+-----------------------------------------+\n", ' ');
    printf("%15c| Char | Occurrances | Char | Occurrances |\n", ' ');
    printf("%15c+-----------------------------------------+\n", ' ');
    /* Only print the lowercase ascii alphabet */
    int i;

    for (i = 97; i < 97 + 13; i++)
	printf("%15c| %3c  | %11d | %3c  | %11d |\n", ' ', i,
	       asciiTable[i], i + 13, asciiTable[i + 13]);
    printf("%15c+-----------------------------------------+\n", ' ');
    printf("%15cWord Count: %d\n", ' ', j);
}

void makeWordStats() {
  int k = 0, i = 0, length = 0;

  while (wordList[0][i] != '\0') { /* Effectivly sets the counting variable to */
    wordStats[0][0]++; /* The size of the first read in word */
    i++;
  }
  wordStats[0][1] = 1; /* Occurances of first word = 1 */
  
  for ( k = 1; k < j; k++) {
    
}


void printLengthVsOccur(void);
void printWordVsOccur(void);
void printWordVsOccurByWord(void);
void printWordVsOccurByOccur(void);
