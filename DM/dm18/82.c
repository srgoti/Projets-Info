#include <stdio.h>
#include <stdlib.h>

int sum(int len, int** tab) {
	for (int i = len - 2; i >= 0; i--) {
		int* svd = malloc(len * sizeof(int));
		for (int j = 0; j < len; j++) {
			svd[j] = tab[j][i];
			int top = 0;
			int bot = 0;
			if (j != len - 1) {
				int top1 = tab[j + 1][i + 1] + tab[j + 1][i];
				int top2 = tab[j + 1][i + 1] + tab[j][i + 1];
				top = (top1 < top2 ? top1 : top2);
			}
			if (j != 0) {
				int bot1 = tab[j - 1][i + 1] + tab[j - 1][i];
				int bot2 = tab[j - 1][i + 1] + tab[j][i + 1];
				bot = (bot1 < bot2 ? bot1 : bot2);
			}
			int min = tab[j][i + 1];
			if (bot != 0) {
				min = (min < bot ? min : bot);
			}
			if (top != 0) {
				min = (min < top ? min : top);
			}
			svd[j] += min;
		}
		for (int j = 0; j < len; j++) {
			tab[j][i] = svd[j];
		}
	}
	int mini = -1;
	for (int j = 0; j < len; j++) {
		if (tab[j][0] < mini || mini == -1)
			mini = tab[j][0];
	}
	return mini;
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
	int res = sum(n, t);
	printf("%d\n", res);
}