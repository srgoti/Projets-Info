#include <stdio.h>

float phi(int n) {
	int t = 0;
	for (int i = 1; i < n; i++) {
		if (n % i == 0) t++;
	}
	return (float) t;
}

int main() {
	float max_v = 0;
	int max_i = 0;
	for (int i = 2; i <= 10; i++) {
		float d = i / phi(i);
		if (d > max_v) {
			max_v = d;
			max_i = i;
		}
	}
	printf("%f\n", 6 / phi(6));
	printf("%d, %f\n", max_i, max_v);
}