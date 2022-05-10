#include <stdio.h>
#include <stdbool.h>

int total = 0;

bool is_prime(int n) {
	for (int i = 2; i < n; i++) {
		if (i * i <= n && n % i == 0) return false;
	}
	return true;
}

int place(int ttl, int len, int prev) {
	//printf("%d %d %d\n", ttl, len, prev);
	if (ttl == 0) return 1;
	if (len == 0 || ttl < 0) return 0;
	int t = 0;
	for (int i = prev; i >= 1; i--) {
		if (is_prime(i))
			t += place(ttl - i, len - 1, i);
	}
	return t;
}

int main() {
	int maxl = 2;
	while (total <= 5000) {
		total = 0;
		for (int i = maxl - 1; i >= 1; i--) {
			if (is_prime(i))
				total += place(maxl, maxl, i);
		}
		maxl++;
		printf("%d %d\n", maxl, total);
	}
	//printf("%d\n", maxl);
}