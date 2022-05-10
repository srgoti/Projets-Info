let itere n f x =let rec somme l = 
  match l with
  |h::t -> h + somme t
  |t -> t
;;
  let rec itere_aux n f x acc =
    match n with
    | 0 -> (f x)
    | _ -> f (itere_aux (n - 1) acc)
  in
  itere_aux n f x 1
;;

let rec rev_append liste1 liste2 =
  match liste1 with
  | h :: t -> let liste2 = h :: liste2 in rev_append t liste2
  | _ -> liste2
;;

let rev liste1 =
  let liste2 = [] in
  let rec rev2 liste1 liste2 =
    match liste1 with
    | h :: t -> let liste2 = h :: liste2 in rev2 t liste2
    | [] -> liste2
  in
  rev2 liste1 liste2;;

let append liste1 liste2 =
  let liste1 = rev liste1 in
  let final = rev_append liste1 liste2 in
  final;;

let sigma n =
  let rec sigma_aux n acc =
    match n with
    | 0 -> acc
    | _ -> sigma_aux (n - 1) (n + acc)
  in
  sigma_aux n 0;;

let rec sigma2 n =
  match n with
  | 0 -> 0
  | _ -> n + sigma2 (n - 1);;

let length liste =
  let rec length_aux liste acc =
    match liste with
    | [] -> acc
    | h :: t -> length_aux t (1 + acc)
  in
  length_aux liste 0
;;

let liste_arithm n u0 r =
  let liste = ref [] in
  for a = 0 to n do
    liste := (u0 + (a * r) :: !liste)
  done;
  rev !liste
;;

