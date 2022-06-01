let produit (z1 : complexe) (z2 : complexe) =
  let (re1, im1), (re2, im2) = z1, z2 in (((re1 *. re2) -. (im1 *. im2)), ((re1 *. im2) +. (re2 *. im1)) : complexe);;

type bulletin = {
    etudiant : string;
    note_maths : int;
    note_physique : int;
    note_philo : int;
    note_info : int;
    note_langues : int;
  };;

type complexe = {
    re : float;
    im : float;
  };;

let somme (z1 : complexe) (z2 : complexe) =
  {re = (z1.re +. z2.re); im = (z1.im +. z2.im)};;

let produit (z1 : complexe) (z2 : complexe) =
  {re = ((z1.re *. z2.re) -. (z1.im *. z2.im)); im = ((z1.re *. z2.im) +. (z1.im *. z2.re))};;

type 'a boite = {
    taille : int;
    contenu : 'a list
  };;

type 'a option =
  |None
  |Some of 'a
;;

let indice elem list =
  let rec i e l n =
    match l with
    |h :: t when h = e -> Some n
    |h :: t -> (i e t (n + 1))
    |[] -> None
  in
  i elem list 0
;;

type 'a arbre = Vide | Noeud of 'a * 'a foret and 'a foret = 'a arbre list;;

let rec hauteur tree =
  match tree with
  |Vide -> 0
  |Noeud (_, c) -> (1 + (max_hauteur_foret c))
  and
    max_hauteur_foret tree =
    match tree with
    |[] -> 0
    |h :: t -> max (hauteur h) (max_hauteur_foret t);;

let rec parcours_suffixe tree =
  match tree with
  |Vide -> ()
  |Noeud (t, c) ->
    tp c; print_int t
  and
    tp tr =
    match tr with
    |[] -> ()
    |hd :: tl -> parcours_suffixe hd; tp tl;;

let rec parcours_prefixe tree =
  match tree with
  |Vide -> []
  |Noeud (t, c) -> t :: [tp c]
  and
    tp tr =
    match tr with
    |[] -> []
    |hd :: tl -> (tp tl) :: [parcours;;
