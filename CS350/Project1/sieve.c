/* Submitted By: Tim Bielawa
Email: tbielawa@csee.wvu.edu
Due Date: 2008/02/20
Assignment: 1, Problem 3 */

#include <stdio.h>
#include <math.h>

void sieveCheck( int *pl);
const int max = 10000;
int primeList[10000];

int main()
{
	sieveCheck( primeList);
	return 0;
}

/* Set array elements to 1 if they are not prime */
void sieveCheck( int *pl)
{
	int ticks = 0;
	pl[0] = 1;
	int i;
	int n = 2;
	while ( n < max )
	{
		i = 1;
		if( pl[(i*n)-1] == 1 ) // if this element has been toggled as not prime
		{
			n++;
			continue;
		}
		pl[(i*n)-1] = 0;
		printf("%d ", i*n);
		for( i = 2; (i*n)-1 < max; i++ )
		{
			pl[(i*n)-1] = 1;
			ticks++;
		}
		n++;
	}
	printf("\nCalculated primes up to %d in %d iterations", max, ticks);
}
