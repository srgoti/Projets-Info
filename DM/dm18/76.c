#include <stdio.h>

int total = 0;

int place(int ttl, int len, int prev) {
	//printf("%d %d %d\n", ttl, len, prev);
	if (ttl == 0) return 1;
	if (len == 0 || ttl < 0) return 0;
	int t = 0;
	for (int i = prev; i >= 1; i--) {
		t += place(ttl - i, len - 1, i);
	}
	return t;
}

int main() {
	for (int i = 99; i >= 1; i--) {
		printf("%d\n", i);
		total += place(100, 100, i);
	}
	printf("%d\n", total);
}