#include <stdio.h>
#include <stdlib.h>

int* t;
int** tab;

int maximum_path_sum(int len) {
	for (int curline = len - 2; curline >= 0; curline--) {
		for (int i = 0; i < curline + 1; i++) {
			tab[curline][i] += (tab[curline + 1][i] > tab[curline + 1][i + 1] ? tab[curline + 1][i] : tab[curline + 1][i + 1]);
		}
	}
	return tab[0][0];
}

int main() {
	int n;
	scanf("%d", &n);
	t = malloc(n * sizeof(int));
	tab = malloc(n * sizeof(t));
	for (int i = 0; i < n; i++) {
		int* t2 = malloc(n * sizeof(int));
		tab[i] = t2;
		for (int j = 0; j < i + 1; j++) {
			scanf("%d", &tab[i][j]);
		}
	}
	int ttl = maximum_path_sum(n);
	printf("%d\n", ttl);
}