/* Submitted By: Tim Bielawa
Email: tbielawa@csee.wvu.edu
Due Date: 2008/02/20
Assignment: 1, Problem 2a,c */

#include <stdio.h>
#include <math.h>

/* Prototype the function */
void primeCheck( int floor, int ceiling);
int calcFloor, ceiling;

int main( void )
{
	printf("This is going to test all the integers between 1 and 10,000\n");
	printf("to see which are prime numbers or not and then print them out.\n");
	printf("Floor of calculations: ");
	scanf("%d", &calcFloor);
	printf("Ceiling of calculations: ");
	scanf("%d", &ceiling);
	primeCheck( calcFloor, ceiling);
	return 0;
}

void primeCheck( int floor, int ceiling)
{
        const int minCheck = (floor == 1 ? 2 : floor); // Start checking at minCheck
	const int maxCheck = ceiling; // End checking at maxCheck
	int i, k; // i, k, iterators.
	int prime = 1; // Prime checking flag. Assume i is prime
	int ticks = 0;
	for ( i = minCheck; i < maxCheck; i++)
	{
		for( k = 2; k <= sqrt(i); k++, ticks++)
		{
			if( i%k == 0 )
			{
				prime = 0;
				break;
			}
		}
		
		if ( prime == 1 ) // primeCheck was never untoggled
		{
			printf("%d ", i);
		}
		prime = 1; // Ensure the flag is toggled back
	}
	printf("Calculated primes up to %d in %d iterations.\n", i, ticks);
}
