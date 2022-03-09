type mot = char list;;
type mots = mot list;;

let precede m1 m2 =
  let ch1, allowed1 = match m1 with
    | h :: t -> h, true
    | [] -> '1', false in
  let ch2, allowed2 = match m2 with
    | h :: t -> h, true
    | [] -> '2', false in
  if not (allowed1 && allowed2) then
    false
  else ch1 < ch2
;;

let prefixer  : mot -> mots -> mots = fun mot mots ->
  let a : mots = mot :: mots in a
;;

let complexite_prefixer = 1;;

type patricia = Noeud of bool * fils
and fils = (mot * patricia) list;;

let ex_2 =
  let ab = ['a';'b'] in
  let baba = ['b';'a';'b';'a'] in
  Noeud(false, [ab, Noeud(true, []); baba, Noeud(true,[])])
;;

let ex_3 =
  let a = ['a'] in
  let ba = ['b'; 'a'] in
  let b = ['b'] in
  Noeud(false, [a, Noeud(false, [a, Noeud(true, []); ba, Noeud(false, [[], Noeud(true, []); b, Noeud(true, [])])])]) 
;;

let creer : mot -> patricia = fun mot ->
  match mot with
  |[] -> Noeud(true, [])
  |h -> Noeud(false, [h, Noeud(true, [])])
;;


let rec compter patricia =
  match patricia with
  | Noeud(true, _) -> 1
  | Noeud(_, li) -> let rec analyse li =
                      match li with
                      |(_, b) :: t -> compter b + analyse t
                      |[] -> 0
                    in
                    analyse li
;;

let extraire arbre =
  let rec extraire_aux (Noeud (term, fils)) mot acc =
    if term then
      extraire_foret fils mot (acc @ [mot])
    else
      extraire_foret fils mot acc
  and extraire_foret liste mot acc =
    match liste with
    | [] -> (acc : mots)
    | (suivant, arbre) :: q -> extraire_aux arbre (mot @ suivant) acc @ extraire_foret q mot []
  in
  extraire_aux arbre [] []
;;

let valide arbre =
  let rec valide_aux arbre2 =
    let rec valide_aux_aux fils =
      match fils with 
      | [] -> 1
      | (mot1, patricia1) :: (mot2, patricia2) :: tl when not (precede mot1 mot2) -> 0
      | (mot1, patricia1) :: (mot2, patricia2) :: tl ->  1 * valide_aux_aux (List.tl fils) * valide_aux patricia1
      | (mot, patricia) :: [] -> 1 * valide_aux patricia
    in 
    match arbre2 with 
    | Noeud (term, []) when term -> 1
    | Noeud (term, []) -> 0
    | Noeud (term, fils) -> valide_aux_aux fils
  in
  match arbre with
  | Noeud (term, []) -> true
  | _ -> valide_aux arbre = 1
;;

let taille_ex_4_avec_ajout = (9, 3);;

