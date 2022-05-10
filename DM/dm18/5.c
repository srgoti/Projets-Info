#include <stdio.h>
#include <stdbool.h>

bool is_div(int n) {
	for (int i = 11; i <= 20; i++) {
		if (n % i != 0) return false;
	}
	return true;
}

int main() {
	int i = 1;
	while (!is_div(i)) {
		printf("Checking %d\n", i);
		i++;
	}
	printf("%d\n", i);
}