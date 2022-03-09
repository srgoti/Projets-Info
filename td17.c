#include <stdio.h>

struct processus {
	char *exec; // nom de l'exécutable
	int pid; // identifiant du processus
};
typedef struct processus processus;

struct process {
	processus *actif;
	struct process *suivant;
	struct process *precedent;
};
typedef struct process process;


void ps(process** ordonnanceur) {

}

int main() {
	process** ordonnanceur = (process**) malloc(sizeof(process*));
	
}