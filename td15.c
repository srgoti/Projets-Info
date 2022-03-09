#include <stdlib.h>
#include <stdbool.h>
#include <stdio.h>

struct cell {
	int val;
	struct cell* next;
};
typedef struct cell cell;

cell* new_cell(int val) {
	cell* c = (cell*) malloc(sizeof(cell));
	c->val = val;
	c->next = NULL;
	return c;
}

cell* cons(int val, cell* list) {
	cell* c = new_cell(val);
	c->next = list;
	return c;
}

int length(cell* list) {
	if (list->next != NULL) {
		return (1 + length (list->next));
	} else {
		return 1;
	}
}

void free_list(cell* list) {
	if (list->next != NULL) {
		free_list(list->next);
	} else {
		free(list);
	}
}

bool mem(int val, cell* list) {
	if (list->next == NULL) {
		return false;
	} else {
		if (val == list->val) {
			return true;
		} else {
			return (mem(val, list->next));
		}
	}
}

cell* of_array(int array[], int len) {
	cell* c = (cell*) malloc(len * sizeof(cell));
	c->val = array[0];
	c->next = (len == 0 ? NULL : of_array(++array, len - 1));
	return c;
}

int iter(int* array, cell* list) {
	array[0] = list->val;
	if (list->next != NULL) {
		iter(&array[1], list->next);
	}
}

int* to_array(cell* list) {
	int index = 0;
	int* arr = (int*) malloc(sizeof(int) * length(list));
	iter(arr, list);
	return arr;
}

void print_list(cell* list) {
	int* arr = to_array(list);
	printf("[");
	for (int i = 0; i < length(list) - 1; i++) {
		printf("%d, ", arr[i]);
	}
	printf("%d]\n", arr[length(list - 2)]);
}

int nth(cell* list, int n) {
	if (n > 0) {
		return nth(list->next, n - 1);
	} else if (list->next != NULL) {
		return (list->val);
	} else {
		return -1;
	}
}

bool is_equal(cell* l1, cell* l2) {
	if (l1->next == NULL && l2->next == NULL) {
		return true;
	} else if (l1->next != NULL && l2->next != NULL) {
		if (l1->val == l2->val) {
			return is_equal(l1->next, l2->next);
		} else {
			return false;
		}
	} else {
		return false;
	}
}

cell* append(cell* l1, cell* l2) {
	if (l1->next != NULL) {
		append(l1->next, l2);
	} else {
		l1->next = l2;
	}
}


cell* insert_at_v2(cell* list, int val, int i) {
	if (i > 0) {
		if (list->next == NULL) {
			return NULL;
		}
		return insert_at_v2(list->next, val, i - 1);
	} else {
		cell* intermediate;
		intermediate->next = list->next->next;
		intermediate->val = val;
		list->next = intermediate;
		return list;
	}
}

bool is_sorted(cell* list) {
	if (list->next == NULL) {
		return true;
	} else if (list->val <= list->next->val) {
		return is_sorted(list->next);
	} else {
		return false;
	}
}

void insert(int val, cell* list) {
	if (list->val < val && list->next->val > val) {
		cell* inter;
		inter->next = list->next;
		inter->val = val;
		list->next = inter;
	} else {
		insert(val, list->next);
	}
}

cell* reverse_copy(cell* list) {
	int len = length(list) - 1;
	int* arr = to_array(list);
	for (int i = 0; i <= ((len) % 2 == 0 ? (len) / 2 : (len + 1) / 2); i++) {
		printf("%d\n", arr[i]);
		int tmp = arr[i];
		arr[i] = arr[len - i];
		arr[len - i] = tmp;
	}
	printf("Hello\n");
	return of_array(arr, len);
}

int main() {
	cell* ex = cons(0, cons(1, cons(2, cons(3, cons(4, NULL)))));
	print_list(reverse_copy(ex));
//	print_list(ex);
}
