type vertex = int;;
type graph = vertex list array;;

let outdegree g v =
  List.length g.(v)
;;

let indegree (g : graph) (v : vertex) =
  let (t : int ref) = ref 0 in
  let n = Array.length g in
  for i = 0 to n - 1 do
    let l = g.(i) in
    if List.mem v g.(i) then
      t := !t + 1;
  done;
  !t
;;

let convert_to_o g =
  let n = Array.length g in
  for i = 0 to n - 1 do
    let l = g.(i) in
    let rec remove max li mem =
      match li with
      | h :: t when h >= max -> remove max t mem
      | h :: t -> remove max t (h :: mem)
      | [] -> mem
    in
    g.(i) <- remove i l [];
  done;
;;

let reverse g =
  let n = Array.length g in
  let newm = Array.make n [] in
  for i = 0 to n - 1 do
    let l = g.(i) in
    let rec append i li =
      match li with
      | h :: t -> let newl = ref newm.(h) in newl := i :: !newl
      | [] ->
;;

type none = |;;
let f (x : none) = match x with |_ -> .;;