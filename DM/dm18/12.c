#include <stdio.h>
#include <stdlib.h>

long number_of_processors;

int number_of_factors(int n) {
	int t = 0;
	for (int i = 1; i <= n; i++) {
		if (i * i <= n && n % i == 0) t++;
	}
	return 2 * t;
}

int th() {
	int i = 1;
	int triangle = 1;
	int div;
	while ((div = number_of_factors(triangle)) <= 500) {
		i++;
		triangle += i;
	}
	return i;
}

int main() {
	int max = th();
	printf("%d\n", max);
}