#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

bool is_palindromic(int n) {
	int k = n;
	int len = 1;
	while (k / 10 > 0) {
		k/=10;
		len++;
	}
	int* tab = malloc(len * sizeof(int));
	int* tab2 = malloc(len * sizeof(int));
	int pow = 1;
	for (int i = 0; i < len; i++) {
		tab[len - i - 1] = (n / pow) % (10 * pow);
		tab2[i] = (n / pow) % (10 * pow);
		pow *= 10;
	}
	bool f = true;
	for (int i = 0; i < len; i++) {
		if (tab[i] != tab2[i]) f = false;
	}
	free(tab);
	free(tab2);
	return f;
}

int checknbrs() {
	int maxi = 0;
	for (int i = 1; i < 1000; i++) {
		for (int j = 1; j < 1000; j++) {
			int t = i * j;
			printf("Checking %d*%d\n", i, j);
			if (is_palindromic(t)) maxi = (maxi > t ? maxi : t);
		}
	}
	return maxi;
}

int main() {
	printf("%d\n", checknbrs());
}