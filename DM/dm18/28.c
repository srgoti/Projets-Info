#include <stdio.h>
#define N 1001

int main() {
	int max = N * N;
	int ctr = 1 % 4;;
	int gap = 0;
	int s = 0;
	int cur = 1;
	while (cur <= max) {
		s += cur;
		if (ctr == 1) {
			gap += 2;
		}
		cur += gap;
		ctr = (ctr + 1) % 4;
	}
	printf("%d\n", s);
}