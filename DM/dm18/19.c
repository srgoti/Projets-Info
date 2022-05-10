#include <stdio.h>

int mo[12] = {31,28,31,30,31,30,31,31,30,31,30,31};

int main() {
	int dc = 0;
	int scount = 0;
	for (int y = 0; y <= 100; y++) {
		int ly = (y % 4 == 0 ? 1 : 0);
		for (int m = 0; m < 12; m++) {
			dc += mo[m];
			if(m == 2) {
				dc += ly;
			}
			if ((y >= 1 || m == 11) && (y < 100 || m < 11) && dc % 7 == 6) scount++;
		}
	}
	printf("%d\n", scount);
}