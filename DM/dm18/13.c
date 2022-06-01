#include <stdio.h>
#include <stdbool.h>
#define N 100

long long int power10(int n) {
	long long int l = 1;
	for (int i = 0; i < n; i++) {
		l *= 10;
	}
	return l;
}

int nth(long long int nbr, int index) {
	return (nbr / power10(index)) % 10;
}

int main() {
	int tab[N][50] = {0};
	long long int tab2[N] = {0};
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < 50; j++) {
			scanf("%1d", &tab[i][j]);
		}
		long long int t = 0;
		for (int j = 0; j < 13; j++) {
			t += tab[i][j] * power10(13 - j - 1);
		}
		tab2[i] = t;
	}
	long long int t = 0;
	for (int i = 0; i < N; i++) {
		t += tab2[i];
	}
	bool not0 = false;
	int ctr = 0;
	for (int i = 0; i < 16; i++) {
		int k = nth(t, 15 - i);
		if (k != 0) {
			not0 = true;
		}
		if (not0) {
			ctr++;
			if (ctr < 11) {
				printf("%d", k);
			}
		}
	}
	printf("\n");
}