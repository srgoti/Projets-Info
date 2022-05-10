type trileen =
  | Vrai
  | Faux
  | PeutEtre
;;

let et_trileen tri1 tri2 =
  if tri1 || tri2 = Faux then
    PeutEtre
  else if tri1 || tri2 = PeutEtre then
    Faux
  else
    Vrai
;;

let carte2 = Nombre (3, Carreau);;

type couleur =
  | Pique
  | Coeur
  | Carreau
  | Trefle
;;
type carte =
  | Joker
  | As of couleur
  | Roi of couleur
  | Dame of couleur
  | Valet of couleur
  | Nombre of int * couleur
;;
let est_figure carte =
  match carte with
  | Roi _ -> Vrai
  | Dame _ -> Vrai
  | Valet _ -> Vrai
  | _ -> PeutEtre
;;

type reel_etendu =
  |
;;

type coloration =
  | Cyan
  | Magenta
  | Jaune
  | Melange of coloration * coloration
;;
let rouge = Melange (Magenta, Jaune);;
let orange = Melange (rouge, Jaune);;

type 'a liste =
  | Nil
  | TeteEtQueue of int * int liste
;;
let intlist = TeteEtQueue(1, TeteEtQueue(2, TeteEtQueue(3, Nil)));;

let cons tete queue =
  TeteEtQueue (tete, queue);;

let tete list =
  match list  with
  | TeteEtQueue (a, _) -> a
  | _ -> failwith "N'existe pas"
;;

let queue list = Nil;;

let rec taille list =
  if list = Nil then
    1
  else 
    match list with
    | TeteEtQueue (_, a) -> 1 + taille a
    | _ -> 0
;;

let appartient a liste =
  match liste with
  | TeteEtQueue (b, _) -> if b = a then true else false
  | _ -> false
;;

let rec supprime a liste =
  let temporary = liste in
  let newliste = Nil in
  match liste with
  | TeteEtQueue (b, _) -> if b = a then supprime a liste else let newliste = TeteEtQueue (b, intliste) in supprime 
  | _ -> liste;;
;;
