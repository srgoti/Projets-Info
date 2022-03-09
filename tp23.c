#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

#define HEAP_SIZE 32
uint64_t heap[HEAP_SIZE];

uint64_t end = 0;

uint64_t *malloc_ui(uint64_t size);
void free_ui(uint64_t *p);

const uint64_t block_size = 8;

void set_memory(uint64_t *p, uint64_t n, uint64_t value) {
	for (uint64_t i = 0; i < n; i++) {
		p[i] = value;
	}
}

void free_ui(uint64_t *p) {}

void init_heap() {
	heap[0] = 1;
}

uint64_t* malloc_ui(uint64_t size) {
	if (heap[0] == 0) {
		init_heap();
	}
	if (heap[0] + size < 32) {
		heap[0] += size;
		return &heap[heap[0] - size];
	} else return NULL;
}

int main() {
	uint64_t *p1 = malloc_ui(6);
	uint64_t *p2 = malloc_ui(3);
	set_memory(p1, 6, 42);
	set_memory(p2, 3, 52);
}