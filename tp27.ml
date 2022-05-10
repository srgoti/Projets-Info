type couleur =
  |Rouge
  |Noir;;

type 'a bicolore =
  |Nil
  |Noeud of couleur * 'a bicolore * 'a * 'a bicolore;;

let a8 =
  Noeud (Noir, Noeud (Rouge, Noeud (Noir, Nil, 1, Nil), 2, Noeud (Noir, Noeud (Rouge, Nil, 5, Nil), 7, Noeud (Rouge, Nil, 8, Nil))), 11, Noeud (Noir, Noeud (Rouge, Nil, 13, Nil), 14, Noeud (Rouge, Nil, 15, Nil)));;

let rec hauteur arbre =
  match arbre with
  |Nil -> 1
  |Noeud (c, l, v, r) -> 1 + max (hauteur l) (hauteur r);;

let rec hauteur_noire arbre =
  match arbre with
  |Nil -> 1
  |Noeud (c, l, v, r) -> max (hauteur_noire l) (hauteur_noire r) + if c = Noir then 1 else 0;;

let est_rouge_noir arbre =
  match arbre with
  |Nil -> true
  |Noeud (c, l, v, r) -> if c = Rouge then
                           false
                         else
                           let rec est_rouge_noir arbre couleur_precedente nb_noirs_sup prev =
                             match arbre with
                             |Nil -> (nb_noirs_sup, true)
                             |Noeud (c, l, v, r) -> if couleur_precedente = Rouge && c = Rouge then
                                                      (nb_noirs_sup, false)
                                                    else
                                                      let a,b = est_rouge_noir l c (nb_noirs_sup + 1) in
                                                      if b then
                                                        let d,e = est_rouge_noir r c (nb_noirs_sup + 1) in
                                                        if a = d then
                                                          d,true
                                                        else
                                                          d,false
                                                      else
                                                        a,false
                           in
                           let a,b = est_rouge_noir l Noir 0 v in
                           if b then
                             let c,d = est_rouge_noir r Noir 0 v in
                             if d then
                               true
                             else
                               false
                           else
                             false;;

let correction_rouge arbre =
  match arbre with
  |Noeud (Noir, Noeud (Rouge, Noeud (Rouge, a, x, b), y, c), z, d)
   |Noeud (Noir, Noeud (Rouge, a, x, Noeud (Rouge, b, y, c)), z, d)
   |Noeud (Noir, a, x, Noeud (Rouge, b, y, Noeud (Rouge, c, z, d)))
   |Noeud (Noir, a, x, Noeud (Rouge, Noeud (Rouge, b, y, c), z, d))
   -> Noeud (Rouge, Noeud (Noir, a, x, b), y, Noeud (Noir, c, z, d))
  |_ -> arbre;;


let insere e arbre =
  let rec insere_aux e arbre =
    match arbre with
    | Noeud (c, l, v, r) -> if e > v then
                              correction_rouge (Noeud (c, correction_rouge l, v, (correction_rouge (insere e r))))
                            else
                              correction_rouge (Noeud (c, (correction_rouge (insere e l)), v, correction_rouge r))
    | Nil -> Noeud(Rouge, Nil, e, Nil)
  in
  correction_rouge (insere_aux e (correction_rouge arbre));;

let rec insert_all arbre n =
  if n > 0 then
    correction_rouge (insere n (correction_rouge (insert_all (correction_rouge arbre) (n - 1))))
  else
    correction_rouge arbre
;;
