#include <stdio.h>

int d(int n) {
	int s = 0;
	for (int i = 1; i < n; i++) {
		if (n % i == 0) s += i;
	}
	return s;
}

int main() {
	int t = 0;
	for (int i = 1; i <= 10000; i++) {
		printf("%d\n", i);
		if (d(d(i)) == i) t += i;
	}
	printf("%d\n", t);
}