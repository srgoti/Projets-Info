#define _DEFAULT_SOURCE
#include <stdio.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdbool.h>

typedef uint32_t T;

set* set_new(void);
bool set_is_member(set* s, T x);
void set_add(set* s, T x);
void set_remove(set* s, T x);
void set_delete(set* s);
uint64_t hash(T x, int p);

const uint8_t empty = 0;
const uint8_t occupied = 1;
const uint8_t tombstone = 2;

typedef struct bucket {
	uint8_t status;
	T element;
} bucket;

typedef struct set {
	int p;
	bucket* a;
	uint64_t nb_empty;
} set;


uint64_t p2(int p) {
	return 1 << p;
}

uint64_t hash(T x, int p) {
	return (uint64_t) x % p2(p);
}

set* empty_table(int p) {
	set* s = (set*) malloc(sizeof(set));
	s->p = p;
	s->a = (bucket*) calloc(p2(p), sizeof(bucket));
	s->nb_empty = p2(p);
	return s;
}

set* set_new() {
	set* s = malloc(sizeof(set));
	s->p = 1;
	s->a = NULL;
	s->nb_empty = 0;
	return s;
}

set* set_example() {
	set* s = empty_table(2);
	set_add(s, 1492);
	set_add(s, 1515);
	set_add(s, 1939);
	return s;
}

void set_delete(set* s) {
	free(s->a);
	free(s);
}

uint64_t search(set* s, T x, bool* found) {
	uint64_t i = hash(x, s->p);
	uint64_t j = 0;
	while (j < s->p) {
		if (s->a[i].status == empty) {
			*found = false;
			return i;
		} else if (s->a[i].status == occupied && s->a[i].element == x) {
			*found = true;
			return i;
		} else if (s->a[i].status == occupied) {
			i = (i + 1) % p2(s->p);
		} else {
			i = (i + 1) % p2(s->p);
			j++;
		}
	}
	return i;
}

bool set_is_member(set* s, T x) {
	bool* f;
	int i = search(s, x, f);
	return *f;
}

T set_get(set* s, uint64_t i) {
	return (s->a[i].element);
}

uint64_t set_begin(set* s) {
	uint64_t i = 0;
	while (i < p2(s->p) && s->a[i].status != empty) {
		i++;
	}
	return i;
}

uint64_t set_end(set* s) {
	return p2(s->p);
}

uint64_t set_next(set* s, uint64_t i) {
	i++;
	while (i < p2(s->p) && s->a[i].status != empty) {
		i++;
	}
	return i;
}

void add_no_resize(set* s, T x) {
	uint64_t index = hash(x, s->p);
	while (s->a[index].status != empty) {
		index = set_next(s, index);
	}
	s->a[index].element = x;
	s->a[index].element = occupied;
	s->nb_empty--;
}

void resize(set* s, int p) {
	set* s2 = empty_table(p);
	for (uint64_t i = 0; i < p2(s->p); i++) {
		if (s->a[i].status == occupied) {
			add_no_resize(s2, s->a[i].element);
		}
	}
	set_delete(s);
	s = s2;
}

void set_add(set* s, T x) {
	
}