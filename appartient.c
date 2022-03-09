#include <stdio.h>
#include <stdbool.h>

bool appartient(int elt, int n, int tab[n]) {
	for (int i = 0; i < n; i++) {
		if (tab[i] == elt) return true;
	}
	return false;
}

int main() {
}