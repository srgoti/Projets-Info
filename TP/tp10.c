#include <stdio.h>

void bonjour(void) {
	printf("Hello world !\n");
}

void prenom(void) {
	printf("Valentin Foulon\n");
}

void somme_de_deux(void) {
	int a,b;
	scanf("%d", &a);
	scanf("%d", &b);
	printf("%d\n", a + b);
}

void table_multiplication(void) {
	int a,b;
	scanf("%d", &a);
	scanf("%d", &b);
	for (int i = 0; i <= a; i++) {
		printf("%d fois %d = %d\n", i, b, b * i);
	}
}

void factorielle (void) {
	int n;
	scanf("%d", &n);
	int acc = 1;
	for (int i = 1; i <= n; i++) {
		acc *= i;
	}
	printf("%d\n", acc);
}

void bonjour_a_nouveau(void) {
	printf("Bonjour !\n");
}

void bonjour_n_fois(void) {
	int n;
	scanf("%d", &n);
	for (int i = 0; i < n; i++) {
		printf("Bonjour !\n");
	}
}

void sum_1(void) {
	int max;
	scanf("%d", &max);
	int acc = 0;
	for (int i = 0; i <= max; i++) {
		acc += i * i * i;
	}
	printf("%d\n", acc);
}

int main(void) {
	sum_1();
	return 0;
}
