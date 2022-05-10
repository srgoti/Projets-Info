#include <stdio.h>

int binom(int n, int k) {
	if (k > n / 2) k = n - k;
	float pro = 1;
	for (int i = n; i > n - k; i--) {
		pro *= (float) i / (n - i + 1);
	}
	return (int) pro;
}

int main() {
	int s = 0;
	for (int i = 1; i < 100; i++) {
		for (int j = 1; j < i; j++) {
			if (binom(i, j) > 1000000 || binom(i, j) < 0) {
				s += 1;
			}
		}
	}
	printf("%d\n", s);
}