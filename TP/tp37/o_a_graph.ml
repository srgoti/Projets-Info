type vertex = int;;
type edge = vertex * vertex;;
type graph = bool array array;;
let create_graph n = Array.make_matrix n n false;;
let number_vertices g = Array.length g;;
let has_edge g e =
  let i, j = e in
  g.(i).(j)
;;
let add_edge g e =
  let n = number_vertices g in
  let newm : graph = Array.make_matrix (n + 1) (n + 1) false in
  if not (has_edge g e) then (
    for i = 0 to n - 1 do
      for j = 0 to n - 1 do
        newm.(i).(j) <- g.(i).(j);
      done;
    done;
    newm
  ) 
  else 
    g
;;
let remove_edge g e =
  let n = number_vertices g in
  let newm : graph = Array.make_matrix (n - 1) (n - 1) false in
  let x, y = e in
  if (has_edge g e) then 
    (
      for i = 0 to n - 2 do
        for j = 0 to n - 2 do
          let a, b = (if i >= x then i + 1 else i), (if j >= y then j + 1 else j) in
          newm.(i).(j) <- g.(a).(b);
        done;
      done;
      newm
    )
    else
      g
;;

let neighbors g v =
  let l = ref [] in
  for i = 0 to number_vertices g - 1 do
    if g.(i).(v) then
      l := i :: !l;
    if g.(i).(v) && not (List.mem i !l) then
       l := i :: !l;
  done;
  !l
;;

let all_edges (g : graph) =
  let l = ref [] in
  let n = number_vertices g in
  for i = 0 to n - 1 do
    for j = 0 to n - 1 do
      l := (i, j) :: !l;
    done;
  done;
  !l
;;

let indegree g v =
  let t = ref 0 in
  let n = number_vertices g in
  for i = 0 to n - 1 do
    if (g.(i).(v)) then
      t := !t + 1;
  done;
  !t
;;

let outdegree g v =
  let t = ref 0 in
  let n = number_vertices g in
  for i = 0 to n - 1 do
    if (g.(v).(i)) then
      t := !t + 1;
  done;
  !t
;;


let convert g =
  let n = number_vertices g in
  for i = 0 to n - 1 do
    for j = 0 to n - 1 do
      if g.(i).(j) || g.(j).(i) then
        (
          g.(i).(j) <- true;
          g.(j).(i) <- false;
        )
      else
        (
          g.(i).(j) <- false;
          g.(j).(i) <- false;
        )
    done;
  done;
  for i = 0 to n - 1 do
    for j = 0 to i do
      g.(i).(j) <- g.(j).(i)
    done;
  done;
;;

let reverse g =
  let len = Array.length g in
  let newm = Array.make_matrix len len false in
  for i = 0 to len - 1 do
    for j = 0 to len - 1 do
      newm.(i).(j) <- newm.(j).(i);
    done;
  done;
  newm
;;