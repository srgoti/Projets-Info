#include <stdio.h>
#include <stdbool.h>
int total = 0;

int values[8] = {1,2,5,10,20,50,100,200};
int tab[8] = {0,0,0,0,0,0,0,0};

bool check(int tab[8]) {
	int s = 0;
	for (int i = 0; i < 8; i++) {
		s += tab[i] * values[7 - i];
	}
	if (s == 200) {
		return true;
	}
	return false;
}

void possibilities(int tab[8], int index) {
	for (int i = 0; i < values[7 - index]; i++) {
		tab[index] = i;
		if (index != 7) {
			possibilities(tab, index + 1);
		} else {
			if (check(tab)) {
				total++;
			}
		}
	}
}

int main() {
	possibilities(tab, 0);
	printf("%d\n", total);
}