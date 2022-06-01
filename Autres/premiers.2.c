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
	int* list = malloc(2345678 * sizeof(int));
	int found = 0;
	for (int i = 1; i <= 2345678; i++) {
		fflush(stdout);
		printf("\rChecking for number : %d", i);
		if (est_premier(i, list, found) == 1) {
			list[found] = i;
			found++;
		}
	}
	for (int i = 0; i < found; i++) {
		printf("%d\n", list[i]);
	}
	free(list);
	return 0;
}
