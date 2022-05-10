#include <stdio.h>
#include <stdbool.h>
#define N 3

int tab[N + 1][N + 1] = {{-1}};

int routes(int pos_x, int pos_y) {
	bool r = (pos_x != N);
	bool d = (pos_y != N);
	if (!r && !d) {
		return 0;
	}
	if (tab[pos_y][pos_x] != -1) {
		return tab[pos_y][pos_x];
	}
	int ttl = 0;
	if (!r) {
		ttl = 1;
	} else if (!d) {
		ttl = 1;
	} else {
		ttl += routes(pos_x + 1, pos_y);
		ttl += routes(pos_x, pos_y + 1);
	}
	tab[pos_y][pos_x] = ttl;
	return tab[pos_y][pos_x];
}

int main() {
	for (int i = 0; i < N + 1; i++) {
		for (int j = 0; j < N + 1; j++) {
			tab[i][j] = -1;
		}
	}
	int t = routes(0, 0);
	printf("%d\n", t);
}