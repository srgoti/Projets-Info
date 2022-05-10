#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool check(int** tab, int i, int j, int k) {
	int l = k * k;
	int line = -1;
	bool noone = true;
	for (int c = 0; c < l; c++) {
		if (c % k == 0) {
			line++;
		}
		if (tab[i + line][j + c % k] == 1) {
			noone = false;
		}
	}
	return noone;
}

int main() {
	int l;
	int c;
	scanf("%d %d", &l, &c);
	int* tab_l = malloc(c * sizeof(int));
	int** tab_c = malloc(l * sizeof(tab_l));
	free(tab_l);
	int maxlen = 0;
	for (int i = 0; i < l; i++) {
		int* tab_l = malloc(c * sizeof(int));
		for (int j = 0; j < c; j++) {
			scanf("%d", &tab_l[j]);
		}
		tab_c[i] = tab_l;
	}
	for (int i = 0; i < l; i++) {
		for (int j = 0; j < c; j++) {
			for (int k = 0; k < (l - i < c - j ? l - i : c - j); k++) {
				if (check(tab_c, i, j, k)) {
					maxlen = (k > maxlen ? k : maxlen);
				}
			}
		}
	}
	printf("%d\n", maxlen);
}
