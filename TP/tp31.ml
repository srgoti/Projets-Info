type table = string array list

let vehicule = [
  [|"30990"; "AA320"; "Hop !"|];
  [|"98300"; "Bus"; "IBUS"|];
  [|"1832"; "Bus"; "SNCF"|];
  [|"1562"; "TGV"; "SNCF"|];
  [|"1781"; "TGV"; "SNCF"|];
]
;;
let trajet = [
  [|"1"; "Lille"; "Rennes"; "19-12-05"; "09h00"; "30990"|];
  [|"2"; "Lille"; "Rennes"; "19-12-05"; "10h00"; "98300"|];
  [|"3"; "Lille"; "Rennes"; "19-12-05"; "14h00"; "1562"|];
  [|"4"; "Rennes"; "Lille"; "19-12-05"; "14h00"; "1781"|];
  [|"5"; "Lille"; "Rennes"; "19-12-06"; "14h00"; "1562"|];
]
;;

let sans_doublons list =
  let rec sans_doublons_aux hd tl =
    let rec belongs el li =
      match li with
      |h :: t when h = el -> true
      |h :: t -> belongs el t;
      |[] -> false
    in
    match tl with
    |h :: t -> if (belongs h hd) then
      sans_doublons_aux (hd) t
    else
      sans_doublons_aux (h :: hd) t
      |[] -> hd
    in
  sans_doublons_aux [] list
;;

let selection_constante table i str =
  let rec selection_constante_aux table i str mem =
    match table with
    | h :: t when h.(i) = str -> selection_constante_aux t i str (h :: mem)
    | h :: t -> selection_constante_aux t i str mem
    | [] -> mem
  in
  selection_constante_aux table i str []
;;

let selection_egalite table i j =
  let rec selection_egalite_aux table i j mem =
    match table with
    | h :: t when h.(i) = h.(j) -> selection_egalite_aux t i j (h :: mem)
    | h :: t-> selection_egalite_aux t i j mem
    | [] -> mem
  in
  selection_egalite_aux table i j []
;;

let projection table arr =
  let rec projection_aux table arr mem =
    match table with
    |h :: t -> projection_aux t arr (
      (let ar = ref [||] in
      for i = 0 to (Array.length arr) - 1 do
        ar := Array.append !ar [|h.(arr.(i))|];
      done;
      !ar) :: mem
    )
    |[] -> mem
    in
    sans_doublons (projection_aux table arr [])
  ;;

let produit_cartesien (table1 : table) (table2 : table) =
  let rec produit_cartesien_aux table1 table2 mem =
    let rec produit_cartesien_aux_aux elem table2 mem2 =
      match table2 with
      | h :: t -> produit_cartesien_aux_aux elem t ((Array.append h elem) :: mem2)
      | [] -> mem2
    in
    match table1 with
    | h :: t -> produit_cartesien_aux t table2 (produit_cartesien_aux_aux h table2 [] @ mem)
    | [] -> mem
  in
  produit_cartesien_aux table1 table2 []
;;

let jointure table1 table2 i j =
  selection_egalite (produit_cartesien table1 table2) i j
;;