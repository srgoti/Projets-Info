type 'a binaire =
  |V
  |N of 'a * 'a binaire * 'a binaire;;

let rec taille arbre =
  match arbre with
  |V -> 1
  |N (a, b, c) -> 1 + taille b + taille c;;

let rec nb_feuilles arbre =
  match arbre with
  |V -> 1
  |N (a, b, c) -> nb_feuilles b + nb_feuilles c;;

let rec hauteur arbre =
  match arbre with
  |V -> 1
  |N (a, b, c) -> 1 + max (hauteur b) (hauteur c);;


