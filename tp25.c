#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void sum (int argc, char* argv[]) {
	int s = 0;
	for (int i = 0; i < argc; i++) {
		s += atoi(argv[i]);
	}
	printf("%d\n", s);
}

void min_arg(int argc, char* argv[]) {
	if (argc != 1) {
		int offset = ((strcmp(argv[1], "--lex") == 0 || strcmp(argv[1], "--len") == 0) ? 1 : 0);
		if (argc != offset + 1) {
			int min = strlen(argv[1 + offset]);
			char* min_string = malloc(sizeof(argv[1 + offset]));
			strcpy(min_string, argv[1 + offset]);
			for (int i = 2 + offset; i < argc; i++) {
				if (offset == 1) {
					if (strcmp(argv[i], "--lex") == 0) {
						if (strcmp(argv[i], min_string) < 0) {
							realloc(min_string, sizeof(argv[i]));
							strcpy(min_string, argv[i]);
						}
					} else {
						if (strlen(argv[i]) < min) {
							realloc(min_string, sizeof(argv[i]));
							strcpy(min_string, argv[i]);
							min = strlen(argv[i]);
						}
					}
				} else {
					if (strlen(argv[i]) < min) {
						realloc(min_string, sizeof(argv[i]));
						strcpy(min_string, argv[i]);
						min = strlen(argv[i]);
					}
				}
			}
			printf("%s\n", min_string);
		}
	}
}

int main(int argc, char* argv[]) {
/*	for (int i = 0; i < argc; i++) {
		printf("[%d] %s\n", i, argv[i]);
	}*/
	min_arg(argc, argv);
}
