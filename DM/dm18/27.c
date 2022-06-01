#include <stdio.h>
#include <stdbool.h>

int formula(int a, int b, int n) {
	return n * n + a * n + b;
}

bool is_prime(int n) {
	int i = 1;
	while(i * i <= n) {
		if (n % i == 0) return false;
	}
	return true;
}

int main() {
	int m[2] = {-1000, -1000};
	int mv = 0;
	for (int a = -999; a < 1000; a++) {
		for (int b = -999; b < 1000; b++) {
			int n = 0;
			while (is_prime(formula(a, b, n))) {
				n++;
			}
			printf("%d %d %d\n", a, b, n);
			if (n > mv) {
				mv = n;
				m[0] = a;
				m[1] = b;
			}
		}
	}
	printf("Result :\n");
	printf("%d %d %d\n", m[0], m[1], mv);
}