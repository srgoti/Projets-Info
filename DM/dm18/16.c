#include <stdio.h>
#include <stdbool.h>

void multiplyby2(int tab[1000]) {
	bool k = false;
	for (int i = 0; i < 1000; i++) {
		tab[i] *= 2;
		if (k) {
			tab[i]++;
			if (tab[i] == 10) {
				tab[i] = 0;
			} else {
				k = false;
			}
		}
		if (tab[i] >= 10) {
			tab[i] -= 10;
			k = true;
		}
	}
}

int main() {
	int values[1000] = {0};
	values[0] = 1;
	for (int i = 0; i < 1000; i++) {
		multiplyby2(values);
	}
	long long int t = 0;
	for (int i = 0; i < 1000; i++) {
		t += values[i];
	}
	printf("%lld\n", t);
}