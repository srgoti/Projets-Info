#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int est_premier(int n, int list[], int found) {
	for (int i = 2; i < n; i++) {
		if (n % i == 0)
			return 0;
	}
	return 1;
}

int main() {
	int list[2048000];
	int found = 0;
	for (int i = 1; i <= 2048000; i++) {
		fflush(stdout);
		printf("\rChecking for number : %d", i);
		if (est_premier(i, list, found) == 1) {
			list[found] = i;
			found++;
		}
	}
	int sum = 0;
	for (int i = 0; i < found; i++) {
		sum += i % 1000000;
	}
	printf("\n%d\n", sum);
	return 0;
}
