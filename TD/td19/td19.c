#include <stdio.h>

typedef struct liste_fils {
	void* value;
	liste_fils* fd;
	liste_fils* fg;
	liste_fils* parent;
}
