#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

struct complexe {
double re;
double im;
};

struct personne {
	int age;
	double taille;
	double poids;
	char sexe;
	bool blond;
};

struct int_array {
int* data;
int len;
};
typedef struct int_array int_array;

typedef struct personne personne;

struct personne evolution(personne p) {
	personne new_person = p;
	new_person.age++;
	return new_person;
}

double imc (personne p) {
	double _imc = p.poids / (p.taille * p.taille);
	return _imc;
}

personne nouveau(int age, double taille, double poids) {
	personne _new = {.age = age, .taille = taille, .poids = poids};
	return _new;
}

void regime(personne* p) {
	p->poids *= 0.95;
}

void anniversaire(personne* p) {
	(*p).age++;
}

void mort(personne* p) {
	if (p != NULL)
		free(p);
}

personne* naissance() {
	personne liuse = {.poids = 3.0, .taille = .5};
	personne* p = &liuse;
	return p;
}

int array_get(int_array* t, int i) {
	return t->data[i];
}

void array_set(int_array* t, int i, int x) {
	t->data[i] = x;
}

void array_delete(int_array* t) {
	free(t->data);
	free(t);
}

int main() {
	struct complexe z2 = {.re = 0.0, .im = 1.0};
	z2.im = -z2.im;
	personne isaline = {.age = 18, .taille = 1.55, .poids = 50.0};
	personne alison = {.age = 18, .taille = 1.70, .poids = 55.0};
	personne valentin = {.age = 17, .taille = 1.80, .poids = 55.0};
	personne pierre = {.age = 17, .taille = 1.75, .poids = 53.0};
	printf("IMC Valentin : %lf\n", imc(valentin));
	printf("IMC Pierre : %lf\n", imc(pierre));
	printf("IMC Alison : %lf\n", imc(alison));
	printf("IMC Isaline : %lf\n", imc(isaline));
}

// Q7 : erreur zp non défini
// Q14 : Renvoie un pointeur
// Q16 : utiliser free()

