#include <stdio.h>

int fibo() {
	int prev_prev = 1;
	int prev = 2;
	int f = 3;
	int s = 0;
	int i = 0;
	while (f <= 4000000) {
		prev_prev = prev;
		prev = f;
		f += prev_prev;
		if (f % 2 == 0 && f <= 4000000) {
			s += f;
		}
	}
	return s + 2;
}

int main() {
	printf("%d\n", fibo());
}