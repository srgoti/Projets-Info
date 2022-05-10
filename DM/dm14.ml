
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)
(* Nom :                                                            *)
(* Prénom :                                                         *)
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)

(*** Deux points les plus proches ***)

type point = float * float;;

(* Pour vos tests. Vous pouvez modifier. *)
let n_points = 10;;
let points =
  let f _ =
    (-100. +. Random.float 200., -100. +. Random.float 200.)
  in
  Array.init n_points f
;;

(** Question 1 **)

let distance (p1 : point) (p2 : point) =
  let x1,y1 = p1 in
  let x2,y2 = p2 in
  ((x2 -. x1) ** 2.0 +. (y2 -. y1) ** 2.0) ** 0.5;;
  

(** Question 2 **)

let plus_proches_naif (points : point array) =
  let len = Array.length points - 1 in
  let min_dist = ref (-1.) in
  let p1 = ref (0., 0.) in
  let p2 = ref (0., 0.) in
  for i = 0 to len do
    for j = i + 1 to len do
      let x = distance points.(i) points.(j) in
      if x < !min_dist || !min_dist = (-1.) then
        (
          min_dist := x;
          p1 := points.(i);
          p2 := points.(j);
        )
    done;
  done;
  (!p1, !p2)
;;


(** Question 3 **)

let complexite_methode_naive = 4;;

(** Question 4 **)

let tri_abscisses tab =
  let cmp (x1, y1) (x2, y2) =
    if (x1, y1) = (x2, y2) then
      0
    else if x1 < x2 || x1 = x2 && y1 < y2 then
      -1
    else
      1
  in
  Array.stable_sort cmp tab
;;

let tri_ordonnees tab =
  let cmp (x1, y1) (x2, y2) =
    if (x1, y1) = (x2, y2) then
      0
    else if y1 < y2 || y1 = y2 && x1 < x2 then
      -1
    else
      1
  in
  Array.stable_sort cmp tab
;;

(** Question 5 **)

let selectionne_points_dans_T (points : point array) (x0 : float) (delta : float) =
  let len = Array.length points - 1 in
  let tab = ref [||] in
  for i = 0 to len do
    let x,y = points.(i) in
    if abs_float (x -. x0) <= delta then
      tab := Array.append !tab [|points.(i)|];
  done;
  !tab
;;


(** Question 6 **)

let plus_proches_dans_T tab =
  let n = Array.length tab in
  assert (n >= 2);
  let d_min = ref (distance tab.(0) tab.(1)) in
  let couple = ref (tab.(0), tab.(1)) in
  tri_ordonnees tab;
  for i = 0 to (n - 1) do
    for j = (i + 1) to min (n - 1) (i + 6) do
      let d = distance tab.(i) tab.(j) in
      if d < !d_min
      then begin
          d_min := d;
          couple := (tab.(i), tab.(j))
	end
    done
  done;
  !couple
;;

let rec plus_proches_diviser points =
  let n = Array.length points in
  if n <= 3 then
    plus_proches_naif points
  else begin
    tri_abscisses points;
    let points_G = Array.sub points 0 (n / 2) in
    let points_D = Array.sub points (n / 2) (n - (n / 2)) in
    let x0 = fst points.((n / 2) - 1) in
    let (p1_G, p2_G) = plus_proches_diviser points_G in
    let (p1_D, p2_D) = plus_proches_diviser points_D in
    let p1,p2 = if (distance p1_G p1_D) < (distance p2_G p2_D) then
                  p1_G, p1_D
                else
                  p2_G, p2_D
    in
    let delta = distance p1 p2 in
    let points_dans_T = selectionne_points_dans_T points x0 delta in
    ();
    failwith "Je suis trop con, dommage"
  end
;;

(** Question 7 **)

let complexite_methode_diviser = 3;;


(** Question 8 **)

let complexite_methode_optimisee = 2;;
