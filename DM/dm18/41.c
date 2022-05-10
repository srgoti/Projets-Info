#define _DEFAULT_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int counter = 0;
int tab[1000000][8] = {0};

int pow10(int n) {
	if (n == 0) return 1;
	else return 10 * pow10(n - 1);
}

bool is_prime(int n) {
	for (int i = 2; i < n; i++) {
		if (i * i <= n) {
			if (n % i == 0) return false;
		}
	}
	return true;
}

void print_array(int* array, int len) {
	int maxl = 0;
	for (int j = len - 1; j >= 0; j--) {
		if (array[j] != 0) {
			maxl = j + 1;
			break;
		}
	}
	for (int i = 0; i < maxl; i++) {
		if (array[i] == 10) {
			printf("%d", 0);
		} else {
			printf("%d", array[i]);
		}
	}
}

bool is_prime_tab(int* tab, int len) {
	int s = 0;
	for (int i = 0; i < len; i++) {
		s += tab[i] * pow10(len - 1 - i);
	}
	return is_prime(s);
}

bool est_permutation(int* tab, int len) {
	int* tab2 = malloc(len * sizeof(int));
	for (int i = 0; i < len; i++) {
		tab2[i] = -1;
	}
	bool code = true;
	for (int i = 0; i < len; i++) {
		int el = tab[i];
		if (el >= len + 1) {
			code = false;
		} else {
			if (tab2[el - 1] != -1) {
				code = false;
			}
			tab2[el - 1] = el;
		}
	}
	free(tab2);
	return code;
}

void append(int len, int array[1000000][8], int val[len]) {
	for (int i = 0; i < 1000000; i++) {
		bool edit = true;
		for (int j = 0; j < 8; j++) {
			if (array[i][j] != 0) edit = false;
		}
		if (edit) {
			for (int j = 0; j < len; j++) {
				array[i][j] = val[j];
			}
			break;
		}
	}
}

void set(int* array, int offset, int len) {
	bool works = false;
	for (int i = 1; i <= len; i++) {
		works = false;
		array[offset] = i;
		if (offset == len - 1) {
			if (est_permutation(array, len)) {
				if (is_prime_tab(array, len)) {
					append(len, tab, array);
					counter++;
				}
			}
		} else {
			set(array, offset + 1, len);
		}
	}
}

void rund9() {
	int array9[9] = {0};
	set(array9, 0, 9);
}

int main(int argc, char* argv[]) {
	for (int i = 1; i <= 7; i++) {
		int* array = malloc(i * sizeof(int));
		set(array, 0, i);
		free(array);
	}
	int i = 0;
	while(i < 1000000) {
		bool k = true;
		for (int j = 0; j < 8; j++) {
			if (tab[i][j] != 0) k = false;
		}
		i++;
		if(k) break;
	}
	print_array(tab[i - 1], 8);
	printf("\n");
}
