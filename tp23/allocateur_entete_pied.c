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


// Cette fonction convertit un pointeur (qui doit être issu de
// malloc_ui) en un indice dans le tableau heap.
// Vous en aurez besoin pour écrire les différentes versions
// de free_ui (juste un appel au début, ensuite on ne manipule plus
// que des indices), mais il est complètement normal de ne pas
// comprendre comment elle fonctionne : c'est de l'arithmétique des
// pointeurs, qui est hors programme.
ui heap_index(ui* p) {
    return p - heap;
}

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

const uint64_t prologue = 2;

bool is_free(uint64_t i) {
  // À implémenter
  return false;
}

uint64_t read_size(uint64_t i) {
  // À implémenter
  return 0;
}

void set_free(uint64_t i, uint64_t size) {
  // À implémenter
}

void set_used(uint64_t i, uint64_t size) {
  // À implémenter
}

// À ne pas appeler sur l'épilogue
uint64_t next(uint64_t i) {
  // À implémenter
  return 0;
}

// À ne pas appeler sur le prologue
uint64_t previous(uint64_t i) {
  // À implémenter
  return 0;
}

void init_heap(void) {
  // À implémenter
}

uint64_t* malloc_ui64(uint64_t size) {
  // À implémenter
  return NULL;
}

void free_ui64(uint64_t* p) {
  uint64_t i = heap_index(p);
  // À implémenter
}


int main(void) {

    pre_initialize_heap();

    /* // Pour tester, une fois que les fonctions sont implémentées
    init_heap();

    ui* p = malloc_ui64(8);
    set_memory(p, 8, 33);
    ui* q = malloc_ui64(2);
    set_memory(q, 2, 44);
    free_ui64(p);
    ui* r = malloc_ui64(7);
    set_memory(r, 7, 55);
    print_heap();
    free_ui64(r);
    free_ui64(q);


    uint64_t *p1 = malloc_ui64(6);
    uint64_t *p2 = malloc_ui64(7);
    uint64_t *p3 = malloc_ui64(1);
    set_memory(p1, 6, 42);
    set_memory(p2, 7, 52);
    set_memory(p3, 1, 62);
    print_heap();

    free_ui64(p2);
    print_heap();

    uint64_t *p4 = malloc_ui64(2);
    set_memory(p4, 2, 72);
    print_heap();

    free_ui64(p3);
    print_heap();
    */

    return EXIT_SUCCESS;
}
