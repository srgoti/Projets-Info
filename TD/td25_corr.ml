
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)
(* Nicolas Pécheux <info.cpge@cpge.info>                            *)
(* Friday, 15 April 2022                                            *)
(* http://cpge.info                                                 *)
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)

(*** I Représentation des tas ***)

type tas_arbre =
  | Vide
  | Noeud of tas_arbre * int * tas_arbre

type tas_tableau = {taille : int; elements : int array}

(** Question 1 **)

(* Il faut vérifier que l'arbre est parfait et qu'il vérifie la
   propriété de tas-min. Remarquons qu'un arbre est complet ssi ses
   deux fils sont complets de même hauteur. Un arbre est parfait ssi
   son fils gauche est complet de hauteur h et son fils droit parfait
   de hauteur h ou bien si son fils gauche est parfait de hauteur h et
   son fils droit complet de hauteur h - 1. On va écrire une fonction
   auxiliaire qui prend en paramètre une valeur et qui renvoie
   simultanément la hauteur, si c'est un tas dont tous les éléments
   sont plus petit que `mini` et si c'est un arbre complet. Remarquons
   que l'on pourrait se passer de l'appel à droite si l'appel à gauche
   ne donne pas un tas. *)

let rec haut_tas_complet arbre mini =
  match arbre with
  | Vide -> -1, true, true
  | Noeud (fg, x, fd) ->
    let hg, tg, cg = haut_tas_complet fg x in
    let hd, td, cd = haut_tas_complet fd x in
    let est_tas =
      mini <= x && tg && td && ((hg = hd && cg) || (hg = hd + 1 && cd))
    in
    let est_complet = cg && cd && hg = hd in
    1 + max hg hd, est_tas, est_complet

let est_tas_arbre arbre =
  match arbre with
  | Vide -> true
  | Noeud (_, x, _) ->
     let _, t, _ = haut_tas_complet arbre x in
     t

(** Question 2 **)

(* Les noeuds sont numérotés à partir de 0 (ou de 1) en suivant un
   parcours en largeur, par niveaux croissants de gauche à droite. *)

(** Question 3 **)

(* Voir la question suivante pour les formules à partir de 0.

En indexant à partir de 1 on a :

fils_g(i) = 2 * i
fils_d(i) = 2 * i + 1
pere(i) = floor(i / 2)

On montre par récurrence sur p que pour 0 <= p <= h, les noeuds de
   profondeur p sont ceux d'indices entre 2^p et 2^(p + 1) - 1. Soit i
   l'indice d'un noeud de profondeur p, on a donc i = 2^p + j ou j est
   le nombre de noeuds de profondeur p avant i. Si i dispose d'un fils
   gauche, qui sera de profondeur (p + 1), et comme l'arbre est
   parfait, chacun des j noeuds possède exactement deux fils de
   profondeur (p + 1) qui sont numérotés avant fils_g(i) à cette
   profondeur. On a donc fils_g(i) = 2^(p + 1) + 2 * j puisque
   fils_g(i) est à la profondeur (p + 1) avec exactement 2 * j noeuds
   à cette profondeur numérotés avant lui. D'où fils_g(i) = 2 * (2^p +
   j) = 2 * i. Le fils droit de i s'il existe est le noeud numéroté
   juste après son fils gauche et la formule pour les fils permet d'en
   déduire celle pour le père.

On peut faire de même pour les indice qui commencent à 0, ou, plus
   simplement, utiliser les formules qui commencent à 1 avec un
   décalage de 1.

*)

(** Question 4 **)

let pere i = (i - 1) / 2

let fils_g i = 2 * i + 1

let fils_d i = 2 * (i + 1)

(** Question 5 **)

let est_tas_tableau t =
  let rec est_tas_aux i =
    (fils_g i >= t.taille || t.elements.(i) <= t.elements.(fils_g i) && est_tas_aux (fils_g i)) &&
      (fils_d i >= t.taille || t.elements.(i) <= t.elements.(fils_d i) && est_tas_aux (fils_d i))
  in
  0 <= t.taille && t.taille <= Array.length t.elements && est_tas_aux 0

(** Question 6 **)

let rec taille a =
  match a with
  | Vide -> 0
  | Noeud (fg, _, fd) -> 1 + taille fg + taille fd

let arbre_vers_tab arbre =
  let n = taille arbre in
  let tab = Array.make n 0 in
  let rec remplir arbre i =
    match arbre with
    | Vide -> ()
    | Noeud (fg, x, fd) ->
       assert (0 <= i && i < n);
       tab.(i) <- x;
       remplir fg (fils_g i);
       remplir fd (fils_d i)
  in
  remplir arbre 0;
  {taille = n; elements = tab}

(** Question 7 **)

let tab_vers_arbre tab =
  let rec arbre_en i =
    if i >= tab.taille then
      Vide
    else
      Noeud (arbre_en (fils_g i), tab.elements.(i), arbre_en (fils_d i))
  in
  arbre_en 0

(*** II File de priorité persistantes ***)

(* Question 8. *)

(*

type 'a file_prio
val creer : unit -> 'a file_prio
val est_vide :'a file_prio -> bool
val ajouter : 'a -> 'a file_prio -> unit
val minimum : 'a file_prio -> 'a
val supprimer_minimum : 'a file_prio -> unit

*)

(** Question 9 **)

type 'a file_prio = 'a list

(* O(1) *)
let creer = []

(* O(1) *)
let est_vide file = file = []

(* O(1) *)
let ajouter elt file = elt :: file

(* O(n) *)
let rec minimum file =
  match file with
  | [] -> failwith "File vide"
  | tete :: [] -> tete
  | tete :: queue -> min tete (minimum queue)

(* O(n) *)
let supprimer_minimum file =
  let mini = minimum file in
  let rec supprime file =
    match file with
    | [] -> []
    | tete :: queue when tete = mini -> queue
    | tete :: queue -> tete :: supprime queue
  in
  supprime file

(** Question 10 **)

type 'a file_prio = 'a list

(* O(1) *)
let creer = []

(* O(1) *)
let est_vide file = file = []

(* O(n) *)
let ajouter elt file =
  match file with
  | [] -> [elt]
  | tete :: queue when elt <= tete -> elt :: file
  | tete :: queue -> tete :: (ajouter elt queue)

(* O(1) *)
let rec minimum = List.hd

(* O(1) *)
let supprimer_minimum = List.tl

(* Les opérations n'ont pas le même coût, ici c'est l'ajout qui est
   linéaire en la taille de la file. Cette implémentation n'est ni
   moins efficace, ni plus efficace que l'implémentation par liste non
   triée. *)

(** Question 11 **)

type 'a tas = | Vide | Noeud of 'a tas * 'a * 'a tas

type 'a file_prio = 'a tas

(* O(1) *)
let creer = Vide

(* O(1) *)
let est_vide file = file = Vide

(* O(1) *)
let minimum file =
  match file with
  | Vide -> failwith "File vide"
  | Noeud (_, racine, _) -> racine

(** Question 12 **)

let rec fusion tas1 tas2 =
  match tas1, tas2 with
  | Vide, _ -> tas2
  | _, Vide -> tas1
  | Noeud (g1, r1, d1), Noeud (g2, r2, d2) ->
     if r1 <= r2 then
       Noeud (d1, r1, fusion g1 tas2)
     else
       Noeud (d2, r2, fusion g2 tas1)

(** Question 13 **)

let ajouter elt file = fusion (Noeud (Vide, elt, Vide)) file

let supprimer_minimum file =
  match file with
  | Vide -> failwith "File vide"
  | Noeud (g, _, d) -> fusion g d

(** Question 14 **)

(* En commentaires ci-dessus *)

(*** III Tri par tas ***)

(* Échange `t.(i)` et `t.(j)` *)
let swap t i j =
  let tmp = t.(i) in
  t.(i) <- t.(j);
  t.(j) <- tmp

(* Percolation (vers le haut) de `i` dans `t[0..i]` *)
let rec sift_up t i =
  let p = (i - 1) / 2 in
  if p >= 0 && t.(p) > t.(i) then begin
      swap t i p;
      sift_up t p
  end

(* Percolation (vers le bas) de `i` dans `t[0..last]` *)
let rec sift_down t i last =
  let left = 2 * i + 1 in
  let right = 2 * i + 2 in
  let largest = ref i in
  if left <= last && t.(left) > t.(i) then
    largest := left;
  if right <= last && t.(right) > t.(!largest) then
    largest := right;
  if !largest <> i then begin
      swap t i !largest;
      sift_down t !largest last
    end

(* Extraction du maximum de `t[0..last]` que l'on place en `last` *)
let extract t last =
  swap t 0 last;
  sift_down t 0 (last - 1)

(* Insertion de tous les noeuds dans le tas (a) *)
let creer_tas_a t =
  let n = Array.length t in
  (* Invariant : t[0..i - 1] est un tas *)
  for i = 1 to n - 1 do
    sift_up t i
  done

(* Insertion de tous les noeuds dans le tas (b) *)
let creer_tas_b t =
  let n = Array.length t in
  (* Invariant : les noeuds d'indice i + 1 à n - 1 sont racines d'un
     tas *)
  (* Amélioration : on peut commencer à n / 2 - 1 plutôt qu'à n - 1
     puisque pour i >= n / i, i est une feuille donc la racine d'un
     tas *)
  for i = n / 2 - 1 downto 0 do
    sift_down t i (n - 1)
  done

let tri_par_tas t =
  let n = Array.length t in
  creer_tas_a t;
  (* Extractions successives du maximum ; on peut s'arrêter à 1 *)
  for last = n - 1 downto 1 do
    extract t last
  done

let ex = [|7; 4; 1; 8; 5; 4; 8; 3; 6; 9; 3|]
let () = tri_par_tas ex
let _ = ex

(*** IV Création d'un tas et analyse de la complexité ***)

(** Question 16 **)

(* Ci-dessus *)

(** Question 17 **)

(* i est une feuille ssi i n'a pas de fils gauche ssi 2 * i + 1 >= n
   ssi i >= (n - 1) / 2 ssi i >= ceil((n - 1) / 2) = floor(n / 2) *)

(** Question 18 **)

(* Ci-dessus *)

(** Question 19 **)

(* La construction a) exécute n fois la fonction `sift_up` de
   complexité O(log n) d'où une complexité en O(nlog n).

On peut montrer que la borne est serrée, c'est-à-dire que l'on a même
   un $\Theta(n logn)$. Dans le pire cas, chaque élément remonte
   jusqu'à la racine (par exemple si le tableau est triée
   décroissant). Chaque noeud de profondeur p contribue donc à p
   échanges. On a donc une complexité en

(\sum_{p = 1}^{h - 1} p2^p) + h(n - 2^h + 1) = h(n + 1) - 2^{h + 1} +
   2 = \Theta(n log n).

La construction b) exécute n fois (ou (n / 2)) fois la fonction
   `sift_down` de complexité O(log n) d'où une complexité en O(n log
   n). Nous allons voir que cette complexité est sur-estimée.

*)

(** Question 20 **)

(*

On note H la hauteur de l'arbre (dans cette question h est la hauteur
   d'un noeud quelconque).

Attention à ne pas confondre la hauteur h d'un noeud (distance à la
   feuille la plus profonde du sous-arbre enraciné en ce noeud) et sa
   profondeur (distance à la racine). De plus, comme l'arbre n'est pas
   nécessairement complet mais seulement parfait, tous les noeuds à
   une même profondeur n'ont pas nécessairement la même hauteur.

On montre la propriété par récurrence sur h (0 <= h <= H).

Les noeuds de hauteur h = 0 sont exactement les feuilles et donc les
   noeuds d'indices entre floor(n / 2) et n - 1. Il y en a exactement
   ceil(n / 2) et l'initialisation est donc vérifiée.

On suppose la propriété vraie pour h - 1 (1 <= h <= H) et on montre
   que celle-ci est encore vraie pour h. Soit n_h le nombre de noeuds
   de hauteur h dans l'arbre a de taille n. On considère l'arbre a'
   obtenu en supprimant toutes les feuilles de l'arbre a. L'arbre a'
   est donc de taille floor(n / 2). Les noeuds de hauteur h de a sont
   les noeuds de hauteur h - 1 de a', dont on note n'_{h - 1} le
   nombre. Par hypothèse de récurrence

   n'_{h - 1} <= ceil(n' / 2^h) = ceil(floor(n / 2) / 2^h) = ceil(n / 2^{h + 1})

Ainsi n_h = n'_{h - 1} <= ceil(n / 2^{h + 1}) et la propriété est démontrée.

*)

(** Question 21 **)

(*

Dans la deuxième approche, dans le pire cas, chaque noeud descend de
   sa hauteur. Comme il y a au plus ceil(n / 2^{n + 1}) noeuds de
   hauteur h, le nombre total d'échanges est majoré par

\sum_{h = 1}^{H} (ceil(n / 2^{h + 1})O(h) = O(n \sum_{h = 0}^{H} h / 2^h) = O(n)

car sum_{h = 0}^{H} h / 2^h <= 2

*)

(** Question 22 **)

(* La très grande majorité des noeuds ont une hauteur faible et une
   profondeur élevée (remarquons déjà qu'à peu près la moitié des
   noeuds sont des feuilles de hauteur 0 et de profondeur H ou H - 1
   !). Il est bien plus efficace pour chaque noeud de descendre de sa
   hauteur que de remonter de sa profondeur.
*)
