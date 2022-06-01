type ('f, 'n) arbre =
  |Feuille of 'f
  |NoeudInterne of ('f, 'n) arbre * 'n * ('f, 'n) arbre
;;

let rec strahler tree =
  match tree with
  |Feuille _ -> 1
  |NoeudInterne (a, _, b) when (strahler a) = (strahler b) -> (strahler a) + 1
  |NoeudInterne (a, _, b) -> max (strahler a) (strahler b)
