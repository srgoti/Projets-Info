#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool abundant(int n) {
	int t = 0;
	for (int i = 1; i < n; i++) {
		if (n % i == 0) t += i;
	}
	return (n < t);
}

int main() {
	int* abu = malloc((28124 * sizeof(int)));
	int c = 0;
	for (int i = 1; i <= 28123; i++) {
		if (abundant(i)) {
				abu[c] = i;
		}
	}
	c++;
	realloc(abu, c * sizeof(int));
	int tt = 0;
	for (int i = 1; i <= 28123; i++) {
		bool go = true;
		for (int j = 0; j < c; j++) {
			for (int k = 0; k < c; k++) {
				if (i == abu[k] + abu[j]) go = false;
			}
		}
		if (go)
		tt += i;
	}
	printf("%d\n", tt);
}