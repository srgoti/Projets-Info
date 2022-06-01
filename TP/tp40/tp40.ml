
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)
(* Nicolas Pécheux <info.cpge@cpge.info>                            *)
(* http://cpge.info                                                 *)
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)

(* Fonctions utilitaires disponibles dans les versions récentes de
   OCaml *)

(* String.split_on_char *)
let split_on_char sep s =
  let r = ref [] in
  let j = ref (String.length s) in
  for i = String.length s - 1 downto 0 do
    if String.get s i = sep then begin
        r := String.sub s (i + 1) (!j - i - 1) :: !r;
        j := i
      end
  done;
  String.sub s 0 !j :: !r

(* List.filter_map *)
let filter_map f =
  let rec aux acc = function
    | [] -> List.rev acc
    | h :: t ->
       match f h with
       | None -> aux acc t
       | Some v -> aux (v :: acc) t
  in
  aux []

(***********************)
(* Vive-lès-communes 1 *)
(***********************)

type commune = {nom : string; dep : string; long : float; lati : float}

(* Fausse commune pour initialiser *)
let rien = {nom = ""; dep = ""; long = 0.; lati = 0.}

(* Nombre de communes *)
let nb_communes =
  let fc = open_in "communes.csv" in
  let rec loop n =
    try ignore (input_line fc); loop (n + 1)
    with End_of_file -> close_in fc;  n
  in loop 0

(* Association entre un nom de commune et son identifiant et tableau
   des communes *)
let nom_vers_id, communes =
  let data = Array.make nb_communes rien in
  let h = Hashtbl.create nb_communes in
  let fc = open_in "communes.csv" in
  for i = 0 to nb_communes - 1 do
    match split_on_char ',' (input_line fc) with
    | [nom; long; lati; dep] ->
       data.(i) <- {nom = nom; dep = dep;
                    long = float_of_string long;
                    lati = float_of_string lati;
                   };
       Hashtbl.add h nom i
    | _ -> failwith "Inconsistent data"
  done;
  close_in fc;
  (fun nom -> Hashtbl.find h nom), data

(** Question 1 **)

let id_dijon = Hashtbl.find communes "Dijon";;
let lat, lng = communes.(id_dijon).lati, communes.(id_dijon).long;;
let commune_id_42 = communes.(id_dijon).nom;;

(* Distance entre deux communes *)

(** Question 2 **)

(* Distance entre deux communes *)
let dist s d =
  let rad x = (atan 1.) *. x /. 45. in
  let ps = rad communes.(s).lati in
  let ls = rad communes.(s).long in
  let pd = rad communes.(d).lati in
  let ld = rad communes.(d).long in
  (* Formule de Haversine *)
  let a = (sin ((pd -. ps) /. 2.)) ** 2. in
  let a = a +. (cos ps) *. (cos pd) *. (sin ((ld -. ls) /. 2.)) ** 2. in
  let c = 2. *. atan (sqrt a /. (sqrt (1. -. a))) in
  6371. *. c

(** Question 2 **)

let dist_dijon_lyon = dist id_dijon (Hashtbl.find communes "Lyon");;

(** Question 3 **)

(**************************)
(* Communes-et-voisines 2 *)
(**************************)

type graphe = (int * float) list array

let graphe_france =
  let g = Array.make (Array.length communes) [] in
  let fv = open_in "voisines.csv" in
  begin try
    while true do
      match String.split_on_char ',' (input_line fv) with
      | [src; dst] ->
         let s = int_of_string src in
         let d = int_of_string dst in
         let w = dist s d in
         g.(s) <- (d, w) :: g.(s);
         g.(d) <- (s, w) :: g.(d)
      | _ -> failwith "Inconsistent data"
    done
  with End_of_file ->
    close_in fv;
  end;
  g

(** Question 3 **)

let nbr_aretes_graphe = Array.fold (fun acc e ->
                                     List.length e + acc) 0 graphe_france;;
let degre_max_graphe = Array.fold (fun acc e ->
                                    List.fold (fun acc' (d, w) ->
                                               if d > acc' then d else acc'
                                              ) 0 e + acc
                                   ) 0 graphe_france;;
let commune_avec_degre_max = communes.(Array.fold (fun acc e ->
                                          List.fold (fun acc' (d, w) ->
                                                     if d > acc' then
                                                       (d, acc')
                                                     else acc'
                                                    ) (-1, -1) e + acc
                                         ) (-1, -1) graphe_france).nom;;
let communes_voisines_dijon =
  let id = commune_avec_degre_max in
  let g = graphe_france in
  Array.fold (fun acc e ->
               List.fold (fun acc' (d, w) ->
                            if d = id then
                              acc' :: acc
                            else acc
                           ) [] e
              ) [] g

(**************************)
(* Communes-et-voisines 3 *)
(**************************)

(***********************)
(* Vive-lès-communes 3 *)
(***********************)

(* Fonctions utilitaires *)


(****************************)
(* Côte-d'Or-la-bienvenue 3 *)
(****************************)

let sous_graphe com =
  let n =
    let f acc elt = if elt.dep = com then acc + 1 else acc in
    Array.fold_left f 0 communes
  in
  let c = Array.make n rien in
  let m = Array.make nb_communes (-1) in
  let k = ref 0 in
  for i = 0 to nb_communes - 1 do
    if communes.(i).dep = com then begin
      c.(!k) <- communes.(i);
      m.(i) <- !k;
      incr k
    end
  done;
  let g = Array.make n [] in
  for i = 0 to nb_communes - 1 do
    if m.(i) <> -1 then
      g.(m.(i)) <- filter_map
                     (fun (j, w) -> if m.(j) <> -1 then Some (m.(j), w) else None)
                     graphe_france.(i)
  done;
  let map nom = m.(nom_vers_id nom) in
  map, c, g

let nom_vers_id21, communes21, graphe21 = sous_graphe "21"

(** Question 4 **)


(*******************)
(* Bar-sur-réels 4 *)
(*******************)

(** Algorithme de Bellman-Ford **)

type rbar =
  | R of float
  | Inf

let reel r =
  failwith "À implémenter"

let somme r1 r2 =
  failwith "À implémenter"

let inferieur r1 r2 =
  failwith "À implémenter"

(*******************)
(* Bellman-Fords 5 *)
(*******************)

(* Relâcher l'arc (u, v) de poids w en mettant à jour le tableau des
   estimations des distances et le tableau des pères. *)
let relacher dist pere u (v, w) =
  failwith "À implémenter"

let bellman_ford graphe s_initial =
  failwith "À implémenter"

(* Un plus court chemin du sommet initial à u *)
let plus_court_chemin pere u =
  failwith "À implémenter"

let g_ex1 = [|
  [(1, 5.); (2, -4.); (3, 8.)];
  [(0, -2.)];
  [(1, 7.)];
  [(1, -3.); (2, 9.)];
  [(0, 6.); (3, 7.)]
|];;

let g_ex2 = [|
  [];
  [(0, 2.); (2, 1.)];
  [(5, -4.)];
  [(6, 7.)];
  [(2, 0.)];
  [(4, 3.)];
  [(3, -8.)]
|]

let g_ex3 = [|
  [(1, 6.); (3, 7.)];
  [(2, 5.); (4, -4.); (3, 8.)];
  [(1, -2.)];
  [(2, -3.); (4, 9.)];
  [(2, 7.); (0, 2.)]
|]

(** Algorithme de Dikstra **)

(* On va définir un tas dont les éléments sont des sommets, avec un
   tableau de type `int array`, où la case d’indice 0 va contenir la
   taille du tas. Les priorités des éléments du tas ne seront pas les
   éléments du tas eux-même mais celles du tableau des estimations des
   distances.

   Il faut être capable de savoir rapidement où se trouve un sommet
   dans le tas (hors de question de faire une recherche à chaque fois,
   ce serait trop coûteux). Pour cela on va conserver cette
   information dans un tableau `indice`. Par exemple, pour un sommet
   `s`, `indice.(s)` sera l’indice dans le tableau `tas` où se trouve
   `s`. On garanti donc l’invariant `tas.(indice.(s)) = s` pour tout
   sommet `s`. *)

let pere i = failwith "À implémenter"
let fils_droit i = failwith "À implémenter"
let fils_gauche i = failwith "À implémenter"

let est_vide tas = failwith "À implémenter"

(* Échange les éléments d'indices `i` et `j` dans le tas. Il faut
   répercuter ce changement sur le tableau indices également. *)
let echange tas indices i j =
  failwith "À implémenter"

(* Fait remonter le sommet d'indice `i` dans le tas, tant que
   nécessaire *)
let rec remonte tas dist indices i =
  failwith "À implémenter"

(* Fait descendre le sommet d'indice `i` dans le tas, tant que
   nécessaire *)
let rec descend tas dist indices i =
  failwith "À implémenter"

let inserer tas dist indices s =
  failwith "À implémenter"

let extraire tas dist indices =
  failwith "À implémenter"

(* Relâcher l'arc (u, v) de poids w en mettant à jour le tableau des
   estimations des distances et le tableau des pères. *)
let relacher tas dist indices pere u (v, w) =
  failwith "À implémenter"

let dijkstra graphe s_initial =
  failwith "À implémenter"

let g_ex5 = [|
  [(1, 9.); (3, 5.)];
  [(2, 1.); (3, 2.)];
  [(4, 4.)];
  [(1, 3.); (2, 9.); (4, 2.)];
  [(0, 7.); (2, 6.)]
|];;
