#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int score(char* s, int l) {
  int t = 0;
  int i = 1;
  int c;
  while (s[i + 1] != '\0') {
    c = s[i];
    //printf("%d\n", c);
    t += c - 65;
    i++;
  }
  //printf("%d %d\n", t, l + 1);
  return t * (l + 1);
}

void read() {
  FILE* f = fopen("names.txt", "r");
  char* wrd = malloc(100);
  int wcount = 1;
  int ccount = 0;
  char** all = malloc(6000 * sizeof(wrd));
  int c;
  while ((c = (char) fgetc(f)) != EOF) {
    if (c == ',') {
      all[wcount - 1] = wrd;
      wrd = malloc(100);
      wcount++;
      //printf("%d\n", sizeof(wrd) * wcount);
      //realloc(all, wcount * sizeof(wrd));
      //printf("Here2 %d %d %c\n", wcount - 1, ccount, c);
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
    ttl += score(all[i], i);
    printf("%s %d\n", all[i], score(all[i], i));
  }
  printf("%d\n", ttl);
  fclose(f);
}

int main() {
  //int c = 'A';
  //printf("%d\n", c);
  read();
}