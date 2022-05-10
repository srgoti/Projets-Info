#include <stdio.h>

int res(int n) {
	int s = 0;
	for (int a = 1; a <= 118; a++) {
		for (int b = 1; b <= 118; b++) {
			for (int c = 1; c <= 118; c++) {
				if (a * a + b * b + c * c == n) {
					s++;
				}
			}
		}
	}
	return s;
}

int main() {
	int max = 0;
	int r = 0;
	for (int i = 3; i <= 1000; i++) {
		int k = res(i);
		if (k > max) {
			max = k;
			r = i;
		}
	}
	printf("%d\n", r);
}