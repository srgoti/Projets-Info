#include <stdio.h>
#include <stdlib.h>

void sum_bottomright(int len, int** tab) {
	for (int i = 2 * (len - 1) - 1; i >= len - 1; i--) {
		for (int j = 0; j <= 2 * (len - 1) - i; j++) {
			//if (j != 0 && j != 2 * (len - 1) - i)
			//printf("%d %d %d\n", i - len + 1, j, tab[len - 1 - j][len - j + i]);
			int h = len - 1 - j;
			int l = 1 - len + i + j;
			if (h == len - 1) tab[h][l] += tab[h][l + 1];
			else if (l == len - 1) tab[h][l] += tab[h + 1][l];
			else tab[h][l] += (tab[h][l + 1] < tab[h + 1][l] ? tab[h][l + 1] : tab[h + 1][l]);
			//printf("%d %d %d\n", h, l, tab[h][l]);
		}
	}
}

void sum_topleft(int len, int** tab) {
	for (int i = len - 2; i >= 0; i--) {
		for (int k = 0; k <= i; k++) {
			tab[i - k][k] += (tab[i - k][k + 1] < tab[i - k + 1][k] ? tab[i - k][k + 1] : tab[i - k + 1][k]);			
		}
	}
}

int main() {
	int n;
	scanf("%d", &n);
	int* t_l = malloc(n * sizeof(int));
	int** t = malloc(n * sizeof(t_l));
	free(t_l);
	for (int i = 0; i < n; i++) {
		int* t_l = malloc(n * sizeof(int));
		t[i] = t_l;
		for (int j = 0; j < n; j++) {
			if (j == n - 1)
				scanf("%d,", &t[i][j]);
			else
				scanf("%d,", &t[i][j]);
		}
	}
	sum_bottomright(n, t);
	sum_topleft(n, t);
	printf("%d\n", t[0][0]);
}