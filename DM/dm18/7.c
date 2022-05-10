#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdbool.h>

bool est_premier(int n, int list[], int found) {
	for (int i = 1; i < found; i++) {
		int check = list[i];
		if (check * check <= n) {
			if (n % check == 0)
				return false;
		}
	}
	return true;
}

int main() {
	int* list = malloc(10002 * sizeof(int));
	int found = 0;
	int i = 1;
	while (found <= 100001) {
		//fflush(stdout);
		printf("\rChecking for number : %d\n", i);
		if (est_premier(i, list, found)) {
			list[found] = i;
			found++;
		}
		i++;
	}
	printf("%d\n", list[found - 1]);
	free(list);
	return 0;
}
