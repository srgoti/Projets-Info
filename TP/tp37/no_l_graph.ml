type vertex = int;;
type graph = vertex list array;;

let outdegree g v =
  List.length g.(v)
;;

let indegree (g : graph) (v : vertex) =
  let t = ref 0 in
  let n = Array.length g in
  for i = 0 to n - 1 do
    let l = g.(i) in
    if List.mem v g.(i) then
      t := !t + 1;
  done;
  !t
;;

let convert_to_no g =
  let n = Array.length g in
  for i = 0 to n - 1 do
    let l = g.(i) in
    let rec op l g i =
      match l with
      |h :: t -> if not (List.mem i g.(h)) then
        let l2 = ref g.(h) in
        l2 := h :: !l2
        ; op t g i 
      |[] -> ()
    in
    op l g i
  done;
;;