type 'a arbre =
  | Vide
  | Noeud of 'a * 'a arbre * 'a arbre;;

let tree0 = Vide;;
let tree1 = Noeud ("Feuille", Vide, Vide);;
let tree2 = Noeud (3, Vide, Noeud (5, Vide, Vide));;
let tree3 = Noeud (1, Vide, Noeud (2, Vide, Noeud (3, Vide,  Noeud (4, Vide, Vide))));;
let tree4 = Noeud (1, Noeud (2, Vide, Noeud (3, Vide, Vide)), Noeud (4, Vide, Vide));;
let tree5 = Noeud (1, Noeud (2, Noeud (3, Vide, Vide), Noeud (24, Vide, Vide)), Noeud (29, Noeud (6, Vide, Vide), Noeud (7, Vide, Vide)));;

let rec hauteur arbre =
  match arbre with
  |Vide -> -1
  |Noeud (_, l, r) -> 1 + max (hauteur l) (hauteur r);;

let rec nb_noeuds arbre =
  match arbre with
  |Vide -> 0
  |Noeud (_, a, b) -> 1 + (nb_noeuds a) + (nb_noeuds b);;

let rec nb_feuilles arbre =
  match arbre with
  |Vide -> 0
  |Noeud (_, a, b) when (a = Vide && b = Vide) -> 1
  |Noeud (_, a, b) -> (nb_feuilles a) + (nb_feuilles b);;

let rec somme_etiquettes arbre =
  match arbre with
  |Vide -> 0
  |Noeud (a, b, c) -> a + (somme_etiquettes b) + (somme_etiquettes c);;

let rec max_etiquettes arbre =
  match arbre with
  |Vide -> 0
  |Noeud (a, b, c) -> max (max a (max_etiquettes b)) (max a (max_etiquettes c));;

let rec somme_feuilles arbre =
  match arbre with
  |Vide -> 0
  |Noeud (a, b, c) when (b = Vide) && (c = Vide) -> a
  |Noeud (a, b, c) -> (somme_feuilles b) + (somme_feuilles c);;

let rec parcours arbre =
  match arbre with
  |Vide -> []
  |Noeud (a, b, c) -> a :: ((parcours b) @ (parcours c));;

