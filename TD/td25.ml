(*TD fait presque en intégralité avec Github Copilot*)

type tas_arbre =
| Vide
| Noeud of tas_arbre * int * tas_arbre

type tas_tableau = {taille : int; elements : int array}

let rec verif (arbre : tas_arbre) =
  match arbre with
  | Noeud (left, value, Vide) -> (match left with
    | Noeud(Vide, value, Vide) -> true
    | _ -> false)
  | Noeud (left, value, right) -> verif left && verif right
  | Vide -> true
;;

let rec pere value =
  value / 2
;;

let rec fils_g value = 
  value * 2
;;

let rec fils_d value = 
  value * 2 + 1
;;

let rec verif (tab : tas_tableau) = 
  let rec verif_rec (i : int) =
    if i < tab.taille then
      if tab.elements.(i) < tab.elements.(pere i) then
        false
      else
        verif_rec (fils_g i) && verif_rec (fils_d i)
    else
      true
  in
    verif_rec 0
;;

type 'a tas =
| Vide
| Noeud of 'a tas * 'a * 'a tas;;


let rec creer =
  (Vide : 'a tas)
;;

let rec est_vide (tas : 'a tas) =
  match tas with
  | Vide -> true
  | Noeud (_, _, _) -> false
;;

let rec min_not_negative a b =
  if a < 0 then
    b
  else if b < 0 then
    a
  else
    if a < b then
      a
    else
      b
;;


let rec minimum (tas : 'a tas) =
  match tas with
  | Vide -> -1
  | Noeud (left, value, right) -> min_not_negative (min_not_negative (minimum left) (minimum right)) value
;;

let rec fusion (tas1 : 'a tas) (tas2 : 'a tas) =
  match tas1 with
  | Vide -> tas2
  | Noeud (left1, value1, right1) ->
    (match tas2 with
    | Vide -> tas1
    | Noeud (left2, value2, right2) ->
      if value1 < value2 then
        Noeud ((fusion left1 tas2), value1, right1)
      else
        Noeud ((fusion left2 tas1), value2, right2))
;;

let rec ajouter (a : 'a) (tas : 'a tas) =
  match tas with
  | Vide -> Noeud (Vide, a, Vide)
  | Noeud (left, value, right) ->
    if a < value then
      Noeud (ajouter a left, value, right)
    else
      Noeud (left, value, ajouter a right)
;;

let rec supprime_mini (tas : 'a tas) =
  match tas with
  | Vide -> Vide
  | Noeud (left, value, right) ->
    (match left with
    | Vide -> right
    | _ -> Noeud (supprime_mini left, value, right))
;;



