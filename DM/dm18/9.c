#include <stdio.h>
#include <stdbool.h>

bool cor(int a, int b, int c) {
	return (a + b + c == 1000);
}

bool py(int a, int b, int c) {
	return (a * a + b * b == c * c);
}

int main() {
	int tri[3] = {0, 0, 0};
	for (int c = 0; c < 1000; c++) {
		for (int b = 0; b < c; b++) {
			for (int a = 0; a < b; a++) {
				if (cor(a, b, c) && py(a, b, c)) {
					tri[0] = a;
					tri[1] = b;
					tri[2] = c;
				}
			}
		}
	}
	printf("%d\n", tri[0] * tri[1] * tri[2]);
}
