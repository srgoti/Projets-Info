#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <inttypes.h>

// Comme uint64_t est un peu pénible à taper, on utilise
// un typedef :
typedef uint64_t ui;

#define HEAP_SIZE 32

ui heap[HEAP_SIZE];

// Cette fonction initialise le tas à une valeur particulière, que
// vous avez peu de chance d'utiliser par hasard. Cela nous
// permettra en pratique de repérer les cases dont la valeur n'a
// jamais été modifiée quand on affiche le contenu du tas.
// Elle est destinée à être appelée une unique fois, tout au début
// de l'exécution du programme.
void pre_initialize_heap(void) {
    for (ui i = 0; i < HEAP_SIZE; i++) {
        heap[i] = 0xFFFFFFFF;
    }
}

// La fonction suivante affiche le contenu du tas. Les cases
// identifiées comme n'ayant jamais été modifiées sont affichées
// de manière particulière.
void print_heap(void) {
    for (ui i = 0; i < HEAP_SIZE; i++) {
        ui x = heap[i];
        if (x == 0xFFFFFFFF) {
            printf("... ");
        } else {
            printf("%3" PRIu64 " ", x);
        }
    }
    printf("\n");
}

void set_memory(ui* p, ui size, ui value) {
    for (ui i = 0; i < size; i++) {
        p[i] = value;
    }
}

void free_ui64(uint64_t *p) {}

void init_heap(void) {
  heap[0] = 1;
}

uint64_t* malloc_ui64(uint64_t size) {
	if (heap[0] == 0) {
		init_heap();
	}
	if (heap[0] + size < HEAP_SIZE) {
		heap[0] += size;
		return &heap[heap[0] - size];
	} else return NULL;
}

int main(void) {

    pre_initialize_heap();

    init_heap();
    uint64_t *p1 = malloc_ui64(6);
    uint64_t *p2 = malloc_ui64(5);
    set_memory(p1, 6, 42);
    set_memory(p2, 5, 52);
    free_ui64(p2);
    free_ui64(p1);


    print_heap();
    return EXIT_SUCCESS;

}
