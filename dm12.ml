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

let ex_0 = Noeud (false, []);;

let ex_1 = Noeud (true, []);;

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

let ex_4 =
  let mot_as = ['a'; 's'] in
  let mot_fa = ['f'; 'a'] in
  let mot_ble = ['b'; 'l'; 'e'] in
  let mot_c = ['c'] in
  let mot_e = ['e'] in
  let mot_ile = ['i'; 'l'; 'e'] in
  let mot_la = ['l'; 'a'] in
  Noeud (false,
        [
          (mot_as, Noeud (true, []));
          (mot_fa,
           Noeud (true,
                  [
                    (mot_ble, Noeud (true, []));
                    (mot_c,
                     Noeud (false,
                            [
                              (mot_e, Noeud (true, []));
                              (mot_ile, Noeud (true, []))
                            ]))
                  ]));
          (mot_la, Noeud (true, []))
        ]
       )
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

exception Syllabe_LENGTH;;

let est_le_deb (mot : mot) (syl : mot) =
  let rec est_le_deb_aux mot syl =
    match mot, syl with
    | [], [] -> 1
    | [], _ -> 0
    | l1 :: tl1, l2 :: tl2 when l1 = l2 -> 1 * est_le_deb_aux tl1 tl2
    | l1 :: _ , l2 :: _ -> 0
    | _, [] -> 1
  in est_le_deb_aux mot syl = 1
;;

let rec cut_word (mot : mot) (syl : mot) =
  match mot, syl with
  | [], [] -> []
  | [], _ -> raise Syllabe_LENGTH
  | _ :: tl1, _ :: tl2 -> cut_word tl1 tl2
  | _, [] -> mot
;;

let accepter (m : mot) (a : patricia) =
  let rec accepter_aux m a =
    let rec accepter_bis m fils =
      match fils with
      | [] -> 0
      | (syl, patricia) :: tl when est_le_deb m syl -> accepter_aux (cut_word m syl) patricia * 1
      | _ :: tl -> accepter_bis m tl
    in
    match a with
    | Noeud (term, _) when m = [] && term -> 1
    | Noeud (term, []) -> 0
    | Noeud (term, fils) when m = [] -> 0
    | Noeud (term, fils) -> accepter_bis m fils
  in
  accepter_aux m a = 1
;;

type boobool = 
  | True of mot
  | Elem of char
  | Part of mot
  | False 
;;

let ( |= ) (b1 : boobool) (b2 : boobool) = 
  match b1, b2 with
  | False, False -> False
  | False, _ -> False
  | _, False -> False
  | True m1, True m2 -> True m1
  | True m1, Elem m2 -> True (m2 :: m1)
  | Elem m1, True m2 -> True (m1 :: m2)
  | Elem m1, Elem m2 -> failwith "NE DEVRAIT PAS ARRIVER"
  | _,_ -> failwith "J'en ai pas besoin"
;;
let beg_for_a_part (mot : mot) (syl : mot) =
  let rec beg_for_a_part_aux (mot : mot) (syl : mot) (motnf : boobool) =
    match mot, syl with
    | [], [] -> True syl
    | [], _ -> False
    | l1 :: tl1, l2 :: tl2 when l1 = l2 -> beg_for_a_part_aux tl1 tl2 motnf |= Elem l1
    | l1 :: _ , l2 :: _ -> motnf
    | _, [] -> True syl
  in 
  let bo = beg_for_a_part_aux mot syl (True []) in
  match bo with
  | True [] -> False
  | True mot when not (mot = syl) -> Part mot
  | _ -> bo
;;

let terminal_to_not (Noeud(term, fils)) = Noeud(false, fils);;
let not_to_terminal (Noeud(term, fils)) = Noeud(true, fils);;
let est_feuille (un_fils : patricia) =
  match un_fils with
  | Noeud(term, []) -> term
  | _ -> false
;;

let rec ajouter (m : mot) (a : patricia) =
  let rec ajouter_bis (m : mot) (fils : (mot * patricia) list) =
    match fils with
    | [] -> [(m, Noeud(true, []))] 
    | (syl, patricia) :: tl -> 
      let bo = beg_for_a_part m syl in

      match bo with
      | Elem _ -> failwith "J'en ai pas besoin"
      | True _ ->(syl, (ajouter (cut_word m syl) patricia)) :: tl
      | False when precede syl m -> (List.hd fils) :: ajouter_bis m tl 
      (* | False when pre_suiv tl -> ajouter_bis m tl *)
      | False -> (m, Noeud(true, [])) :: tl
      | Part mot ->
        let part2_m = cut_word m mot in
        let part2_syl = cut_word syl mot in 
        match precede part2_m part2_syl with
        | true -> (mot,
                    Noeud(false, [
                      (part2_m, ex_1);
                      (part2_syl, patricia)
                    ])) :: tl
        | false -> (mot,
                    Noeud(false, [
                      (part2_syl, patricia);
                      (part2_m, ex_1)
                    ])) :: tl
    in
    match a with
    | Noeud (term, fils) -> Noeud (term, ajouter_bis m fils)
;;

(* Techniquement p2 n'est parcouru qu'une seule fois *)
let fusion p1 p2 =
  let li = extraire p1 in
  let rec add_all li pat =
    match li with
    | [] -> pat
    | h :: t -> add_all t (ajouter h pat)
  in
  add_all li p2
;;
