#include <stdio.h>
#include <inttypes.h>
#include <stdint.h>

int main() {
	int array[5] = {5,8,5,6,3};

	unsigned long int x = (unsigned long int) &array[0];
	int *ptr = (int*) (uintptr_t) -(~(-(~(-(~(-(~x)))))));
	int val = (int) *ptr;

	printf("%d\n", val);
}

