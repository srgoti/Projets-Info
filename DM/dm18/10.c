#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>

int est_premier(int n, int list[], int found) {
	for (int i = 1; i < found; i++) {
		int check = list[i];
		if (check * check <= n) {
			if (n % check == 0)
				return 0;
		}
	}
	return 1;
}

int main() {
	int* list = malloc(2000000 * sizeof(int));
	int found = 0;
	int sum = 0;
	for (int i = 1; i < 2000000; i++) {
		fflush(stdout);
		printf("\rChecking for number : %d", i);
		if (est_premier(i, list, found) == 1) {
			list[found] = i;
			found++;
			sum += i;
		}
	}
	printf("\n%d\n", sum);
	return 0;
}
