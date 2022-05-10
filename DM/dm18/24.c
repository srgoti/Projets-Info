#define _DEFAULT_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int counter = 0;

bool est_permutation(int* tab, int len) {
	int* tab2 = malloc(10 * sizeof(int));
	for (int i = 0; i < 10; i++) {
		tab2[i] = -1;
	}
	bool code = true;
	for (int i = 0; i < len; i++) {
		int el = tab[i];
		if (el >= 11) {
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

void print_array(int* array, int len) {
	for (int i = 0; i < len; i++) {
		if (array[i] == 10) {
			printf("%d", 0);
		} else {
			printf("%d", array[i]);
		}
	}
}

void set(int* array, int offset, int len) {
	bool works = false;
	for (int i = 1; i <= 10; i++) {
		works = false;
		array[offset] = i;
		if (offset == len - 1) {
			if (est_permutation(array, len)) {
				counter++;
				printf("%d\n", counter);
				if (counter == 1000000) {
					print_array(array, len);
					printf("\n");
					exit(0);
				}
			}
		} else {
			set(array, offset + 1, len);
		}
	}
}

void rund9() {
	int array9[10] = {0};
	set(array9, 0, 10);
}

int main(int argc, char* argv[]) {
	rund9();
}
