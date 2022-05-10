#include <stdio.h>
#include <stdlib.h>

int main() {
	int* tab = malloc(1000 * sizeof(int));
	for (int i = 0; i < 1000; i++) {
		scanf("%1d", &tab[i]);
	}
	long int max = 0;
	for (int i = 0; i < 1000 - 13; i++) {
		int s = 1;
		for (int j = 0; j < 13; j++) {
			printf("%d ", tab[i + j]);
			s *= tab[i + j];
		}
		printf("=> %d\n", s);
		max = (max > s ? max : s);
	}
	printf("%ld\n", max);
}