#include <stdio.h>
#include <stdlib.h>

struct int_dynarray {
int len;
int capacity;
int* data;
};
typedef struct int_dynarray int_dynarray;

int length(int_dynarray* t) {
	return t->len;
}

int_dynarray* create(void) {
	int_dynarray da = {.len = 0, .capacity = 0, .data = NULL};
	return &da;
}

int get(int_dynarray* t, int i) {
	return t->data[i];
}

void set(int_dynarray* t, int i, int x) {
	t->data[i] = x;
}

void resize(int_dynarray* t, int new_capacity) {
	realloc(t->data, new_capacity * sizeof(int));
//	free(t->data);
//	t->data = new_data;
	t->capacity = new_capacity;
}

int pop(int_dynarray* t) {
	t->len--;
	if (t->len < t->capacity / 2) {
		resize(t, (t->capacity / 2));
	}
	return t->data[t->len - 1];
}

void push(int_dynarray* t, int x) {
	if (t->len = t->capacity) {
		resize(t, (t->capacity == 0 ? t->capacity + 1 : t->capacity * 2));
	}
	t->data[len] = x;
	t->len++;
}

void delete(int_dynarray* t) {
	free(t->data);
	free(t);
}



int main() {

}