#include <stdio.h>
#include <stdbool.h>

void create_empty() {
	FILE* fd = fopen("Salut.c", "w");
	fprintf(fd, "");
	fclose(fd);
}

void create_file() {
	FILE* fd = fopen("Salut.c", "w");
	fprintf(fd, "Première ligne\nDeuxième ligne");
	fclose(fd);
}

void create_file() {
	FILE* fi = fopen("Salut.c", "w");
	FILE* fo = fopen("Salut.c", "w");
	while (true) {
		int c = getch(fd);
		

int main() {
}
