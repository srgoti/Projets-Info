#include <stdio.h>

int fact(int n) {
	if (n == 1) return 1;
	else if (n == 0) return 1;
	else return n * fact(n - 1);
}

long long int decompose(int n) {
	int a[7] = {0};
	a[0] = (n / 1000000) % 10;
	a[1] = (n / 100000) % 10;
	a[2] = (n / 10000) % 10;
	a[3] = (n / 1000) % 10;
	a[4] = (n / 100) % 10;
	a[5] = (n / 10) % 10;
	a[6] = (n / 1) % 10;
	long long int s = 0;
	int b = 0;
	for (int i = 0; i < 7; i++) {
		if (a[i] != 0) {
			b = i;
			break;
		}
	}
	for (int i = b; i < 7; i++) {
		//printf("%d\n", a[i]);
		s += fact(a[i]);
	}
	return s;
}

int main() {
	int s = 0;
	for (long long int i = 3; i < 10000000; i++) {
		//printf("%lld %lld\n", i, decompose(i));
		if (i == decompose(i)) s += i;
	}
	printf("%d\n", s);
}