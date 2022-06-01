#include <stdbool.h>
#include <stdio.h>

void echange(int* tab, int i, int j) {
	int temp = tab[i];
	tab[i] = tab[j];
	tab[j] = temp;
}

int indice_min(int N, int tab[N], int i) {
	int indice = i;
	int min = tab[i];
	for (int j = i; j < N; j++) {
		if (min <= tab[j]) {
			min = tab[j];
			indice = j;
		}
	}
	return indice;
}

void tri_selection(int N, int tab[N]) {
	for (int i = 0; i < N; i++) {
		echange(tab, i, indice_min(N, tab, i));
	}
}

bool passage(int* tab, int N) {
	bool okok = false;
	for (int i = 0; i < N - 1; i++) {
		if (tab[i] > tab[i + 1]) {
			echange(tab, i, i + 1);
			okok = true;
		}
	}
	return okok;
}

void tri_bulle(int N, int* tab) {
	while (passage(tab, N)) {}
}

int main() {
	int tab[8] = {2,8,2,4,7,9,0,4};
	for (int i = 0; i < 8; i++) {
		printf("%d\n", tab[i]);
	}
	printf("BUBBLESORT\n");
	tri_bulle (8, tab);
	for (int i = 0; i < 8; i++) {
		printf("%d\n", tab[i]);
	}
	return 0;
}

void insere(int N, int tab[N], int i) {
	for (int i = 0; i < N; i++) {
		
	}
	{}
}