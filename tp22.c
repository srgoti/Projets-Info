#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>

struct noeud {
  int cle;
  struct noeud* gauche;
  struct noeud* droit;
  struct noeud* parent;
};

typedef struct noeud noeud;

noeud* feuille(int cle) {
	noeud* f = (noeud*) malloc(sizeof(noeud));;
	f->cle = cle;
	f->gauche = NULL;
	f->droit = NULL;
	f->parent = NULL;
	return f;
}

bool est_feuille(noeud* n) {
	return (n->gauche == NULL && n->droit == NULL);
}

noeud* enracine(int cle, noeud* gauche, noeud* droit) {
	noeud* r = (noeud*) malloc(sizeof(noeud));
	r->cle = cle;
	r->droit = droit;
	r->gauche = gauche;
	r->parent = NULL;
	if (r->gauche != NULL) {r->gauche->parent = r;};
	if (r->droit != NULL) {r->droit->parent = r;};
	return r;
}

noeud* parent(noeud* n) {
	return (n == NULL ? NULL : n->parent);
}

noeud* grandparent(noeud* n) {
	return parent(parent(n));
}

noeud* frere(noeud* n) {
	noeud* pa = parent(n);
	return (pa->droit->cle == n->cle ? pa->gauche : pa->droit);
}

noeud* oncle(noeud* n) {
	return frere(parent(n));
}

int taille_rec(noeud* n) {
	if (n == NULL) {
		return 1;
	} else {
		return (taille_rec(n->droit) + taille_rec(n->gauche));
	}
}

int profondeur_it(noeud* n) {
	int i = 0;
	while (n->parent != NULL) {
		n = n->parent;
		i++;
	}
	return i;
}

void libere_arbre(noeud* n) {
	if (n->gauche != NULL) {
		libere_arbre(n->gauche);
	}
	if (n->droit != NULL) {
		libere_arbre(n->droit);
	}
	free(n);
}

void affiche_infixe_rec(noeud* n) {
	if (n != NULL) {
		affiche_infixe_rec(n->gauche);
		printf("%d\n", n->cle);
		affiche_infixe_rec(n->droit);
	}
}

noeud* recherche(int cle, noeud* abr) {
	if (abr == NULL) {
		return NULL;
	} else if (cle == abr->cle) {
		return abr;
	} else if (cle > abr->cle) {
		recherche(cle, abr->gauche);
	} else {
		recherche(cle, abr->droit);
	}
}

noeud* recherche_it(int cle, noeud* abr) {
	while (cle != abr->cle && abr != NULL) {
		if (cle > abr->cle) {
			abr = abr->droit;
		} else {
			abr = abr->gauche;
		}
	}
	return abr;
}

noeud* minimum_it(noeud* abr) {
	if (abr == NULL) {
		return NULL;
	}
	while (abr != NULL) {
		abr = abr->gauche;
	}
	return parent(abr);
}

noeud* maximum_rec(noeud* abr) {
	if (abr->gauche != NULL) {
		return maximum_rec(abr->gauche);
	} else {
		return abr;
	}
}

noeud* insertion_it(int cle, noeud* abr) {
	
}

int main(void) {
	noeud* ex2 = enracine(15, enracine(5, feuille(3), enracine(12, enracine(10, enracine(6, NULL, feuille(7)), NULL), NULL)), enracine(16, NULL, enracine(20, feuille(18), feuille(23))));
	noeud* impl = enracine(5, enracine(3, feuille(2), feuille(5)), enracine(7, NULL, feuille(8)));
	printf("Profondeur : %d\n", profondeur_it(ex2->gauche->droit->gauche->gauche->droit));
}
