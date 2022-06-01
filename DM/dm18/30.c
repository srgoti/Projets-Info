#include <stdio.h>

int power(int a, int b) {
	if (b == 1) return a;
	else return a * power(a, b - 1);
}

int decompose(int n) {
	int a1 = (n / 10000) % 10;
	int a2 = (n / 1000) % 10;
	int a3 = (n / 100) % 10;
	int a4 = (n / 10) % 10;
	int a5 = (n / 1) % 10;
	int b = 5;
	int s = power(a1, b) + power(a2, b) + power(a3, b) + power(a4, b) + power(a5, b);
	return s;
}

int main() {
	for (int i = 2; i < 100000; i++) {
		if (decompose(i) == i) printf("%d\n", i);
	}
}