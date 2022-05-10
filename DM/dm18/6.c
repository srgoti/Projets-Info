#include <stdio.h>

int sum_of_squares(int n) {
	int s = 0;
	for (int i = 0; i <= n; i++) {
		s += i * i;
	}
	return s;
}

int square_of_sum(int n) {
	int s = 0;
	for (int i = 0; i <= n; i++) {
		s += i;
	}
	return (s * s);
}

int diff(int n) {
	return -(sum_of_squares(n) - square_of_sum(n));
}

int main() {
	printf("%d\n", diff(100));
}