type 'a arbre =
 |Vide 
 | Noeud of 'a arbre * 'a * 'a arbre ;;

type 'a tableau = { taille : int ; data : 'a arbre };;

let longueur (tab : 'a tableau) =
  tab.taille
;;

let valeur (k : int) (tab : 'a tableau) =
  let rec value (k : int) (tree : 'a arbre) =
    match tree with
    |Noeud (lt, v, rt) ->
      if k = 1 then
        v
      else
        value (k / 2) (if k mod 2 = 0 then
          lt
        else
          rt)
    |Vide -> failwith "Non"
  in
  if k <= tab.taille then
    value k tab.data
  else
    failwith "Index out of bounds"
;;

let change (k : int) (tab : 'a tableau) (elem : 'a) =
  let rec value2 (k : int) (tree : 'a arbre) (elem : 'a) =
    match tree with
    |Noeud (lt, v, rt) ->
      if k = 1 then
        Noeud(lt, elem, rt)
      else
        if k mod 2 = 0 then
          Noeud(value2 k lt elem, v, rt)
        else
          Noeud(lt, v, value2 k rt elem)
    |Vide -> failwith "Non"
  in
  if k <= tab.taille then
    let (t : 'a tableau) = {taille = tab.taille; data = value2 k tab.data elem} in
    t
  else
    failwith "Index out of bounds"
;;