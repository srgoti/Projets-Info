#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <unistd.h>
#include <string.h>

int u0 = 42;
int prefixe_index = 0;
int offset = 0;

typedef struct cell cell;
struct cell {
	cell* next;
	int val;
};

typedef struct itree itree;
struct itree {
	itree* fg;
	itree* fd;
	int val;
	itree* parent;
};

/* Begin question 1 */
int u (int n) {
	if (n == 0) {
		return u0;
	} else {
		return ((15091 * (u (n - 1))) % 64007);
	}
}
/* End question 1 */

itree* a (int n, itree* parent) {
	itree* t = malloc(sizeof(itree));
	t->parent = parent;
	t->val = prefixe_index;
	prefixe_index++;
	if (n == 0) {
		t->fg = NULL;
		t->fd = NULL;
	} else {
		t->fg = a(u(2 * n) % n, t);
		t->fd = a(u(2 * n + 1) % n, t);
	}
	return t;
}


itree* A (int n) {
	prefixe_index = 0;
	return a(n, NULL);
}

/* Begin question 2 */
int nb_feuilles (itree* arbre) {
	if (arbre->fg == NULL && arbre->fd == NULL) {
		return 1;
	} else {
		int current = 0;
		if (arbre->fg != NULL) {
			current += nb_feuilles (arbre->fg);
		}
		if (arbre->fd != NULL) {
			current += nb_feuilles (arbre->fd);
		}
		return current;
	}
}

int nb_noeuds (itree* arbre) {
	if (arbre != NULL) {
		return 1 + nb_noeuds(arbre->fg) + nb_noeuds(arbre->fd);
	}
}
/* End question 2 */

/* Begin question 3 */
int m_from_l (itree* arbre, int val) {
	while (arbre->val != val) {
		if (arbre->fd != NULL && val >= arbre->fd->val) {
			arbre = arbre->fd;
		} else {
			arbre = arbre->fg;
		}
	}
	while (arbre->fd != NULL) {
		arbre = arbre->fd;
	}
	return arbre->val;
}
/* End question 3 */

/* Begin question 4 */
int distance (itree* arbre, int mi, int li) {
	while (arbre->val != mi) {
		if (arbre->fd != NULL && mi >= arbre->fd->val) {
			arbre = arbre->fd;
		} else {
			arbre = arbre->fg;
		}
	}
	int d = 0;
	while (arbre->val != li) {
		if (li < arbre->val || li > m_from_l(arbre, arbre->val)) {
			assert(arbre->parent != NULL);
			arbre = arbre->parent;
		} else if (arbre->fd != NULL && li >= arbre->fd->val) {
			assert(arbre->fd != NULL);
			arbre = arbre->fd;
		} else {
			assert(arbre->fg != NULL);
			arbre = arbre->fg;
		}
		d++;
	}
	return d - 1;
}
/* End question 4 */

/* Begin question 5 */
void feuilles(itree* arbre, int* tab) {
	if (arbre->fg == NULL && arbre->fd == NULL) {
		tab[offset] = arbre->val;
		offset++;
	}
	if (arbre->fg != NULL) {
		feuilles (arbre->fg, tab);
	}
	if (arbre->fd != NULL) {
		feuilles (arbre->fd, tab);
	}
}

int* liste_feuilles(itree* arbre) {
	offset = 0;
	int* tab = malloc(nb_feuilles(arbre) * sizeof(int));
	feuilles(arbre, tab);
	return tab;
}

int nbr_carte(int mi, int p) {
	return mi / p + 1;
}

int* chemin_inverse(itree* arbre, int mi, int p) {
	int profondeur = 0;
	while (arbre->val != mi) {
		profondeur++;
		if (arbre->fd != NULL && mi >= arbre->fd->val) {
			arbre = arbre->fd;
		} else {
			arbre = arbre->fg;
		}
	}
	profondeur++;
	int* tab = malloc(sizeof(int) * (profondeur + 1));
	tab[0] = profondeur;
	while (arbre != NULL) {
		tab[profondeur] = nbr_carte(arbre->val, p);
		profondeur--;
		arbre = arbre->parent;
	}
	return tab;
}

float* cartes_count(itree* arbre, int p) {
	int* tab = liste_feuilles(arbre);
	int max = 0;
	int current = 0;
	float median = 0;
	int total = 0;
	for (int i = 0; i < nb_feuilles(arbre); i++) {
		int* ci = chemin_inverse(arbre, tab[i], p);
		int saved = 0;
		int len = 0;
		for (int j = 1; j <= ci[0]; j++) {
			if (ci[j] != saved) {
				saved = ci[j];
				len++;
			}
		}
		max = (len > max ? len : max);
		median += (float) len / (float) nb_feuilles(arbre);
	}
	float* tab2 = malloc(2 * sizeof(float));
	tab2[0] = median;
	tab2[1] = (float) max;
	return tab2;
}
/* End question 5 */

/* Begin question 6 */
int profondeur_noeud (itree* arbre, int li) {
	int profondeur = 0;
	while (arbre->val != li) {
		profondeur++;
		if (arbre->fd != NULL && li >= arbre->fd->val) {
			arbre = arbre->fd;
		} else {
			arbre = arbre->fg;
		}
	}
	return profondeur;
}
/* End question 6 */

void q1(int n) {
	printf("u (%d) \033[32m=>\033[0m %d\n", n, u(n));
}

void exo1() {
	printf("\033[32mExercice 1\033[0m\n");
	q1(10);
	q1(100);
	q1(1000);
}

void q2(int n) {
	printf("A (%d) \033[32m=>\033[0m noeuds = %d, feuilles = %d\n", n, nb_noeuds(A(n)), nb_feuilles(A(n)));
}

void exo2() {
	printf("\033[32mExercice 2\033[0m\n");
	q2(10);
	q2(100);
	q2(1000);
}

void q3(int n, int li) {
	printf("A (%d), li = %d \033[32m=>\033[0m mi = %d\n", n, li, m_from_l(A(10), 3));
}

void exo3() {
	printf("\033[32mExercice 3\033[0m\n");
	q3(10, 3);
	q3(100, 9);
	q3(1000, 30);
}

void q4(int n, int li, int lj) {
	printf("A (%d), li = %d, lj = %d \033[32m=>\033[0m d = %d\n", n, li, lj, distance(A(10), 3, 9));
}

void exo4() {
	printf("\033[32mExercice 4\033[0m\n");
	q4(10, 3, 9);
	q4(100, 5, 30);
	q4(1000, 30, 90);
}

void q5(int n, int p) {
	float* tab = cartes_count(A(n), p);
	printf("A (%d), p = %d \033[32m=>\033[0m CMax = %d, CMoy = %lf\n", n, p, (int) tab[1], tab[0]);
}

void exo5() {
	printf("\033[32mExercice 5\033[0m\n");
	q5(10, 3);
	q5(100, 6);
	q5(1000, 9);
}

int main(int argc, char* argv[]) {
	exo1();
	exo2();
	exo3();
	exo4();
	exo5();
}
