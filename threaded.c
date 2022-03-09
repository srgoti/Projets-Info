#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <stdbool.h>

char* est_premier(int n) {
	for (int i = 2; i < n; i++) {
		if (n % i == 0) return "True";
	}
	return "False";
}

void *tr(void *vargp) {
	int n = *((int*) vargp);
	for (int i = n * 166666; i < (n * 1666666 + 1666666); i++) {
		printf("%d\t%d\t%s\n", n, i, est_premier(i));
	}
	return NULL;
}

int main() {
	printf("Begin\n");
	pthread_t thread[12];
	int returns[12];
	int ints[12];
	for (int i = 0; i < 12; i++) {
		ints[i] = i;
		pthread_create(&thread[i], NULL, tr, (void *) &ints[i]);
	}
	sleep(2);
	printf("End\n");
	for (int i = 0; i < 12; i++) {
		pthread_join(thread[i], NULL);
	}
	return 0;
}

