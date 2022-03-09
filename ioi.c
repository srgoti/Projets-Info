#include <stdio.h>
#include <stdlib.h>

int main() {
   int nbLivres, nbJours;
   scanf("%d %d", &nbLivres, &nbJours);
   int* duree = malloc(nbLivres * sizeof(int));
   for (int i = 0; i < nbLivres; i++) {
      duree[i] = 0;
   }
//   printf("%d\n", nbJours);
   for (int i = 0; i < nbJours; i++) {
      int nbClients;
      scanf("%d", &nbClients);
      for (int j = 0; j < nbClients; j++) {
         int index, jours;
         scanf("%d %d", &index, &jours);
         if (duree[index] == 0) {
            printf("1\n");
            duree[index] = jours;
         } else {
            printf("0\n");
			duree[index]--;
         }
      }
   }
}