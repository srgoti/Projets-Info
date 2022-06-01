#include <stdio.h>

int len = 201;

long long unsigned int power(int a, int b) {
	if (b == 1) return a;
	else return a * power(a, b - 1);
}

void shift_right(int tab[len], int n) {
	for (int i = len - 1; i >= n; i++) {
		tab[i] = tab[i - n];
	}
}

void multiply_aux(int tab[len], int b) {
	if (b < 10) {
		for (int i = 0; i < )
	}
	tab[0] = a % 100;
	tab[1] = (a / 10) % 10;
	tab[2] = a / 100;
}

void multiply(int tab[len], int a, int b) {
	tab[0] = a % 100;
	tab[1] = (a / 10) % 10;
	tab[2] = a / 100;
	multiply_aux(tab, b);
}

int main() {
	for (int a = 2; a <= 100; a++) {
		for (int b = 2; b <= 100; b++) {
			printf("%llu\n", power(a, b));
		}
	}
}