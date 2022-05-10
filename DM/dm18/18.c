#include <stdio.h>
#include <stdlib.h>

int* t;
int** tab;

int maximum_path_sum(int len, int ttl, int index, int l) {
	if (index == len) {
		return ttl;
	} else {
		ttl += tab[index][l];
		int a = maximum_path_sum(len, ttl, index + 1, l);
		int b = maximum_path_sum(len, ttl, index + 1, l + 1);
		return (a > b ? a : b);
	}
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
	int ttl = maximum_path_sum(n, 0, 0, 0);
	printf("%d\n", ttl);
}