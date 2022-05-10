#include <stdio.h>
#define N 20
#define L 4

int horiz_max_pro(int tab[N][N]) {
	int max_s = 0;
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N - (L - 1); j++) {
			int s = 1;
			for (int k = 0; k < L; k++) {
				s *= tab[i][j + k];
			}
			max_s = (s > max_s ? s : max_s);
		}
	}
	return max_s;
}

int vert_max_pro(int tab[N][N]) {
	int max_s = 0;
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N - (L - 1); j++) {
			int s = 1;
			for (int k = 0; k < L; k++) {
				s *= tab[j + k][i];
			}
			max_s = (s > max_s ? s : max_s);
		}
	}
	return max_s;
}

int diag_1_max_pro(int tab[N][N]) {
	int max_s = 0;
	for (int i = 0; i < N - 3; i++) {
		for (int j = 0; j < N - 3; j++) {
			int s = 1;
			for (int k = 0; k < 3; k++) {
				s *= tab[i + k][j + k];
			}
			max_s = (s > max_s ? s : max_s);
		}
	}
	return max_s;
}

int diag_2_max_pro(int tab[N][N]) {
	int max_s = 0;
	for (int i = 0; i < N - 3; i++) {
		for (int j = N - 1; j >= 3; j--) {
			int s = 1;
			for (int k = 0; k < 3; k++) {
				s *= tab[i + k][j - k];
			}
			max_s = (s > max_s ? s : max_s);
		}
	}
	return max_s;
}

int main() {
	int tab[N][N] = {0};
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			scanf("%d", &tab[i][j]);
		}
	}
	int m1 = horiz_max_pro(tab);
	int m2 = vert_max_pro(tab);
	int m3 = diag_1_max_pro(tab);
	int m4 = diag_2_max_pro(tab);
	int max1 = (m1 > m2 ? m1 : m2);
	int max2 = (m3 > m4 ? m3 : m4);
	printf("%d\n", (max1 > max2 ? max1 : max2));
}