#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
// Nombre maximum de sommets
#define MAXV 100

struct edgenode {
	int y; // le voisin
	struct edgenode *next; // la suite de la liste
};
typedef struct edgenode edgenode;

struct graph {
	edgenode* edges[MAXV]; // tableau de listes d'adjacence
	int degree[MAXV]; // le degré de chaque sommet
	int nvertices;
	int nedges;
	bool directed; // indique si le graphe est orienté
};
typedef struct graph graph;

void initialize_graph(graph* g, int n, bool directed) {
	g->nedges = n;
	g->directed = directed;
	g->nvertices = 0;
	for (int i = 0; i < MAXV; i++) {
		g->degree[i] = 0;
		g->edges[i] = NULL;
	}
}

void insert_edge(graph* g, int x, int y, bool directed) {
	if (directed) {
		g->directed = true;
		g->degree[x]++;
	} else {
		g->degree[x]++;
		g->degree[y]++;
	}
}

void read_graph(graph* g) {
	int n, m, ori;
	initialize_graph(g, n, ori);
	scanf("%d %d %d", &n, &m, &ori);
	for (int i = 0; i < m; i++) {
		int* line[2];
		scanf("%d %d", &line[0], &line[1]);
		insert_edge(line[0], line[1]);
	}
}

void free_list(edgenode* e) {
	if (e->next != NULL) {
		free_list(e->next);
	}
	free(e);
}

void free_edges(graph* g) {
	for (int i = 0; i < MAXV; i++) {
		free_list(g->edges[i]);
	}
}