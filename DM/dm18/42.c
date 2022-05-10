#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

bool is_triangle(int n) {
	int k = 0;
	int i = 1;
	while (k < n) {
		i++;
		k += i;
	}
	return (k == n);
}

bool score(char* s) {
  int t = 0;
  int i = 1;
  int c;
  while (s[i + 1] != '\0') {
	c = s[i];
    t += c - 65;
	i++;
  }
  //printf("%d\n", t);
  return is_triangle(t);
}

void read() {
  FILE* f = fopen("words.txt", "r");
  char* wrd = malloc(100);
  int wcount = 1;
  int ccount = 0;
  char** all = malloc(6000 * sizeof(wrd));
  int c;
  while ((c = (char) fgetc(f)) != EOF) {
    if (c == ',') {
		wrd[ccount] = '\0';
      all[wcount - 1] = wrd;
      wrd = malloc(100);
      wcount++;
      ccount = 0;
    } else {
      wrd[ccount] = c;
      ccount++;
    }
  }
  int len = 0;
  for (int i = 0; i < 6000; i++) {
    if (all[i] == NULL) {
      len = i;
      break;
    }
  }
  int ttl = 0;
  for (int i = 0; i < len; i++) {
    ttl += score(all[i]) ? 1 : 0;
    //printf("%s, %s\n", all[i], score(all[i]) ? "TRUE" : "FALSE");
  }
  printf("%d\n", ttl);
  fclose(f);
}

int main() {
  //int c = 'A';
  //printf("%d\n", c);
  read();
}