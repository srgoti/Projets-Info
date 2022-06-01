#include <stdio.h>
#include <stdbool.h>

void multiplyby(int tab[500], int n) {
	int k = 0;
	for (int i = 0; i < 500; i++) {
		tab[i] *= n;
		int k2 = 0;
		while (k != 0) {
			tab[i]++;
			if (tab[i] > 9) {
				tab[i] -= 10;
				k2++;
			}
			k--;
		}
		k = k2;
		while (tab[i] > 9) {
			tab[i] -= 10;
			k++;
		}
	}
}

void fact(int n, int tab[500]) {
	for (int i = n; i >= 1; i--) {
		multiplyby(tab, i);
	}
}

int main() {
	int tab[500] = {0};
	tab[0] = 1;
	fact(100, tab);
	bool go = false;
	int t = 0;
	for (int i = 499; i >= 0; i--) {
		if (tab[i] != 0) go = true;
		if (go) t += tab[i];
	}
	printf("%d\n", t);
}