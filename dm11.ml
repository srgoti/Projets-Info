let echange arr i j =
  Printf.printf "---Affichage de echange---\n";
  Printf.printf "Echange de %d et %d\n" i j;
  let len = Array.length arr - 1 in
  if i > len || j > len || i < 0 || j < 0 then
    failwith "Index out of range"
  else (
    let tmp = arr.(i) in
    arr.(i) <- arr.(j);
    arr.(j) <- tmp;
  );
  Printf.printf "---Fin de echange---\n";
;;

let tri_insertion arr =
  let len = Array.length arr - 1 in
  Printf.printf "---Affichage de tri_insertion---\n";
  for i = 0 to len do
    for j = i to len do
      if arr.(i) > arr.(j) then
        echange arr i j;
      let () = Array.iter (Printf.printf "%d ") arr in
      print_newline();
    done;
  done;
  Printf.printf "---Fin de tri_insertion---\n";
;;

let partition arr i j =
  let p = arr.(i) in
  let index_p = ref i in
  for e = i + 1 to j do
    if arr.(e) <= p then begin
        for j = e downto !index_p + 1 do
          echange arr j (j - 1);
        done;
        incr index_p;
      end
  done;
  !index_p
;;

let rec tri_rapide_aux arr i j =
  Printf.printf "---Affichage de tri_rapide_aux---\n";
  let () = Array.iter (Printf.printf "%d ") arr in
  print_newline();
  if i < j then (
    let p = partition arr i j in (
        tri_rapide_aux arr i (p - 1);
        tri_rapide_aux arr (p + 1) j;
      );
  );
  Printf.printf "---Fin de tri_rapide_aux---\n";
;;

let tri_rapide arr =
  tri_rapide_aux arr 0 (Array.length arr - 1)
;;

let est_permutation tab =
  let len = Array.length tab in
  let a2 = Array.make len (-1) in
  let return = ref true in
	  Printf.printf "---Affichage de est_permutation---\n";
  for i = 0 to len - 1 do
    let el = tab.(i) in
    if el > len - 1 then
      return := false
    else (
      if not (a2.(el) = (-1)) then
        return := false;
      a2.(el) <- el;
    );
    let () = Array.iter (Printf.printf "%d ") a2 in
    print_newline()
  done;
  Printf.printf "---Fin de est_permutation---\n";
  !return
;;

let rec print_list li =
  match li with
  |h :: t -> Printf.printf "%d " h; print_list t;
  |[] -> ()
;;

let support arr =
  Printf.printf "---Affichage de support---\n";
  let len = Array.length arr in
  let li = ref [] in
  for i = 0 to len - 1 do
    if not (arr.(i) = i) then (
      li := i :: !li;
    );
    Printf.printf "Etat de la liste : ";
    print_list !li;
    print_newline();
  done;
  Printf.printf "---Fin de support---\n";
  List.rev !li
;;

let compose arr1 arr2 =
  Printf.printf "---Affichage de compose---\n";
  let len = Array.length arr1 in
  let len2 = Array.length arr2 in
  if not (len2 = len) then
    failwith "Pas la meme longueur";
  let arr_f = Array.make len (-1) in
  for i = 0 to len - 1 do
    Printf.printf "arr_f.(%d) = arr1.(arr2.(%d)) = arr1.(%d) = %d" i i arr2.(i) arr1.(arr2.(i));
    print_newline();
    arr_f.(i) <- arr1.(arr2.(i));
  done;
  Printf.printf "---Fin de compose---\n";
  arr_f
;;

let print_arr arr =
  let len = Array.length arr - 1 in
  for i = 0 to len do
    Printf.printf "%d " arr.(i);
  done;
;;

let inverse arr =
  let len = Array.length arr in
  let arr_f = Array.make len (-1) in
  Printf.printf "---Affichage de inverse---\n";
  for i = 0 to len - 1 do
    let index = arr.(i) in
    arr_f.(index) <- i
  done;
  Printf.printf "---Fin de inverse---\n";
  Printf.printf "Vérification par la composée : compose ";
  print_arr arr;
  Printf.printf "avec ";
  print_arr arr_f;
  Printf.printf ", résultat : ";
  let _ = compose arr arr_f in
  print_newline();
  arr_f
;;
 
