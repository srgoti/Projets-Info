(* DM 10 OCaml *)
(* Valentin FOULON - MP2I *)

(* Question  1 *)
let rec idx_max_array arr =
  let len = Array.length arr in
  if len = 0 then -1 else
    (
      let mini_indice = ref (-1) in
      let minimum = ref arr.(0) in
      for i = 0 to len - 1 do
        if arr.(i) < !minimum then (
          minimum := arr.(i);
          mini_indice := i;
        )
      done;
      !mini_indice
    )
;;

(* Question  2 *)
let make_tenseur x y z ini =
  let arr_x = Array.make x [||] in
  for i = 0 to x - 1 do
    (
      let arr_y = Array.make y [||] in
      arr_x.(i) <- arr_y;
      for j = 0 to y - 1 do (
        let arr_z = Array.make z ini in
        arr_y.(j) <- arr_z;
      )
      done;
    )
  done;
  arr_x;;

(* Question  3 *)
let sub ar b e =
  let arr = Array.make (e - b) ar.(b) in
  for i = b to e - 1 do
    arr.(i - b) <- ar.(i);
  done;
  arr
;;

(* Question  4 *)
let rev arr =
  let len = Array.length arr - 1 in
  let new_arr = Array.make (len + 1) arr.(0) in
  for i = 0 to len do
    new_arr.(i) <- arr.(len - i);
  done
;;

(* Question  5 *)
let map f arr =
  let len = Array.length arr - 1 in
  let new_arr = Array.make (len + 1) (f arr.(0)) in
  for i = 1 to len do
    new_arr.(i) <- f arr.(i)
  done;
  new_arr
;;

(* Question  6 *)
(* Pas sûr de ça mais ça a l'air de marcher *)
let rec fold_left f a arr =
  let ini_len = Array.length arr - 1 in
  let rec fl f arr ini_len =
    let len = Array.length arr - 1 in
    if len = 0 then
      a
    else
      f (fl f (sub arr 1 (len + 1)) ini_len) arr.(0)
  in
  f (fl f arr ini_len) arr.(ini_len)
;;

(* Question  7 *)
let rec rot arr dec =
  let len = Array.length arr - 1 in
  if dec < 0 then
    rot arr (dec + len + 1)
  else if dec = 0 then
    arr
  else
    (
      let tmp = ref arr.(0) in
      for i = 0 to len - 1 do
        arr.(i) <- arr.(i + 1);
      done;
      arr.(len) <- !tmp;
      rot arr (dec - 1);
    )
;;

(* Question  8 *)
let plateau arr =
  let max_letter_count = ref 0 in
  let current_letter_count = ref 0 in
  let elem = ref arr.(0) in
  let be = ref 0 in
  let current_be = ref 0 in
  let len = Array.length arr - 1 in
  for i = 1 to len do
    if arr.(i) = !elem then
      current_letter_count := !current_letter_count + 1
    else
      (
        elem := arr.(i);
        if !max_letter_count <= !current_letter_count then
          be := !current_be;
        max_letter_count := max (!max_letter_count) (!current_letter_count);
        current_be := i;
        current_letter_count := 1
      );
  done;
  !be, !max_letter_count
;;

(* Question  9 *)
let plus_grande_somme arr maxi =
  let len = Array.length arr - 1 in
  let maximum = ref 0 in
  for i = 0 to len do
    for j = i to len do
      let sum ar =
        let l = Array.length ar - 1 in
        let s = ref 0 in
        for k = 0 to l do
          s := !s + ar.(k)
        done;
        if !s > maxi then
          s := 0;
        maximum := max !maximum !s;
      in
      sum (sub arr i j);
    done;
  done;
  !maximum
;;
