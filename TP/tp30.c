#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>
#include <inttypes.h>

struct image {
	int larg;
	int haut;
	int maxc;
	uint16_t **pixels;
};

typedef struct image image;

/** Fabrique une image à partir du contenu d'un fichier supposé au
    format PGM ASCII */
image *charger_image(char *nom_fichier) {
	FILE* fo = fopen(nom_fichier, "r");
	char* bite = malloc(10);
	fscanf(fo, "%s\n", bite);
	image* n = malloc(sizeof(image));
	fscanf(fo, "%d %d\n", &n->larg, &n->haut);
	fscanf(fo, "%d\n", &n->maxc);
	n->pixels = (uint16_t **) malloc(n->haut * sizeof(uint16_t *));
	for (int i = 0; i < n->haut; i++) {
		uint16_t* line = (uint16_t *) malloc(n->larg * sizeof(uint16_t));
		for (int j = 0; j < n->larg; j++) {
			fscanf(fo, "%" SCNu16, &line[j]);
		}
		n->pixels[i] = line;
	}
	return n;
}

/** Renvoie le caractère caché dans les `8` premières cases d'un
    tableau supposé de longueur au moins `8` */
char caractere(uint16_t *tab) {
	int c = 0;
	for (int i = 0; i < 8; i++) {
		c += (tab[i] & 1) << (7 - i);
	}
	return c;
}

/** Écrit dans le flux le message caché dans l'image. On suppose que
    l'image, et le flux sont valides, et en particulier non `NULL`. On
    suppose également que le message est valide et donc, en
    particuler, que `img->larg >= 8`. */
int sauvegarder_message(image *img, char *nom_sortie) {
	FILE* fd = fopen(nom_sortie, "w");
	for (int i = 0; i < img->haut; i++) {
		char c = caractere(img->pixels[i]);
		if (c == '\0') break;
		fprintf(fd, "%c", c);
	}
	fprintf(fd, "\n");
	fclose(fd);
	return 0;
}

int* decompose_en_binaire(int c) {
	int* tab = malloc(8 * sizeof(int));
	for (int i = 7; i >= 0; i--) {
		if (c >= 1 << i) {
			c -= 1 << i;
			tab[7 - i] = 1;
		} else {
			tab[7 - i] = 0;
		}
	}
	return tab;
}

/** Insère le caractère dans les `8` premières cases du tableau. On
    suppose que le tableau est de taille suffisante. */
void inserer_caractere(char c, uint16_t *tab) {
	int* dec = decompose_en_binaire(c);
	for (int i = 0; i < 8; i++) {
		if ((dec[i] & 1) == 0) {
			tab[i] += 1;
		}
	}
}

/** Cache un message dans une image. On suppose que l'image est de
    hauteur et de largeur suffisante. */
int cacher(image *img, char *nom_entree) {
	FILE* fd = fopen(nom_entree, "r");
	int i = 0;
	int c;
	while ((c = fgetc(fd)) != EOF) {
		inserer_caractere(c, img->pixels[i]);
		i++;
	}
	fclose(fd);
	return 0;
}

/** Sauvegarde une image dans un fichier au format PGM ASCII. On
    suppose que l'image est valide. */
int sauvegarder_image(image *img, char *nom_fichier) {
	FILE* fd = fopen(nom_fichier, "w");
	fprintf(fd, "P2\n");
	fprintf(fd, "%d %d\n", img->larg, img->haut);
	fprintf(fd, "%d\n", img->maxc);
	for (int i = 0; i < img->haut; i++) {
		for (int j = 0; j < img->larg; j++) {
			fprintf(fd, "%d ", img->pixels[i][j]);
		}
		fprintf(fd, "\n");
	}
	fclose(fd);
	return 0;
}

int main(int argc, char* argv[]) {
//	charger_image("images/lycee_carnot.pgm");
//	uint16_t tab[9] = {80,81,81,89,89,90,89,80,85};
//	char c = caractere(tab);
//	printf("%c\n", c);
	sauvegarder_message(charger_image("hollywood-hacking.ppm"), "images/messages");
//	image* i = charger_image("images/lycee_carnot.pgm");
//	cacher(i, "salut.txt");
//	sauvegarder_image(i, "images/cache.pgm");
//	sauvegarder_message(charger_image("images/cache.pgm"), "images/messages");
}
