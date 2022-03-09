 
type 'a liste = 'a cellule option
and 'a cellule = {elt : 'a; mutable next : 'a liste}
;;

let liste1 = Some {elt = 0; next = Some {elt = 1; next = None}};;

let rec to_list liste =
  match liste with
  | Some {elt = h; next = t} -> h :: to_list t;
  | None -> [];
;;

let rec from_list list =
  match list with
  | h :: t -> Some {elt = h; next = from_list t};
  | [] -> None;
;;

let liste2 = from_list [2;4;4;1;8];;

let rec get index liste =
  match liste with
  | Some {elt = h; next = t} -> if index = 0 then h else get (index - 1) t;
  | None -> failwith "Index out of bounds";
;;

let rec iter f liste =
  match liste with
  | Some {elt = h; next = t} -> f h; iter f t;
  | None -> ();
;;

let print_int_liste liste = iter print_int liste;;

let liste3 =
  let rec liste2 = Some {elt = 4; next = Some {elt = 1; next = Some {elt = 8; next = liste2}}} in
  Some {elt = 2; next = Some {elt = 4; next = liste2}}
;;

let comporte_cycle liste =
  let l_aux = [] in
  let rec sub l1 l2 =
    match l1 with
    | None -> false
    | a -> if List.memq a l2 then true else match a with
                                            | Some {elt = h; next = t} -> sub t (a :: l2)
                                            | None -> false;
  in
  sub liste l_aux
;;

let liste = from_list [10;11;12;1;2;3;4;5;6;7;8;9];;
let liste4 =
  let rec liste_aux = Some {elt = 10; next = Some {elt = 11; next = Some {elt = 12; next = Some {elt = 1; next = Some {elt = 2; next = Some {elt = 3; next = Some {elt = 4; next = Some {elt = 5; next = Some {elt = 6; next = Some {elt = 7; next = Some {elt = 8; next = Some {elt = 9; next = liste_aux}}}}}}}}}}}} in
  Some {elt = 13; next = Some {elt = 14; next = Some {elt = 15; next = liste_aux}}};;

