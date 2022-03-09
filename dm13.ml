type tree =
  | Leaf
  | Tree of (tree * tree)
;;

type itree =
  | ILeaf of int
  | ITree of (itree * itree * int)
;;

let rec print_tree itree =
  match itree with
  | ITree(a, b, i) -> Printf.printf "Tree %d\n" i; print_tree a; print_tree b;
  | ILeaf i -> Printf.printf "Leaf %d\n" i;
;;


let u0 = 7;;

let rec u k = 
	if k > 0 then
		(15091 * u (k - 1)) mod 64007
	else
		u0
;;

let rec a n =
  if n = 0 then
    Leaf
  else
    Tree(a (u (2 * n) mod n), a (u (2 * n + 1) mod n));
;;

let rec leaves tree =
  match tree with
  | Leaf -> 1
  | Tree(a, b) -> (leaves a) + (leaves b)
;;

let rec nodes tree =
  match tree with
  | Leaf -> 1
  | Tree(a, b) -> 1 + (nodes a) + (nodes b)
;;

let rec internal_nodes tree =
  match tree with
  | Leaf -> 0
  | Tree(a, b) -> 1 + (internal_nodes a) + (internal_nodes b)
;;

let convert tree =
  let index = ref 0 in
  let rec c tree index =
    let snapshot = !index in
    index := !index + 1;
    match tree with
    | Tree(a, b) -> let ltree = (c a index) in ITree(ltree, (c b index), snapshot)
    | Leaf -> ILeaf(snapshot)
  in
  c tree index
;;

let rec max_index itree =
  match itree with
  | ILeaf i -> i
  | ITree(a, b, i) -> max (max (max_index a) (max_index b)) i
;;

let rec m_from_l itree li =
  match itree with
  | ITree(a, b, i) when i = li ->  max (max_index a) (max_index b)
  | ITree(a, b, i) -> max (m_from_l a li) (m_from_l b li)
  | ILeaf i -> if i = li then i else (-1)
;;

let rec parent itree node index =
  match itree with
  | ITree (a, b, i) -> if i = node then
                         index
                       else
                         max (parent a node i) (parent b node i)
  | ILeaf i -> if i = node then
                 index
               else
                 (-1)
;;

let chemin tree ni nj =
  let itree = convert tree in
  let rec distance itree ni nj =
    match itree with
    | ILeaf i -> if ni = i then 1 else -1
    | ITree(_,_,_) ->
    if ni = nj then
      1
    else if m_from_l itree ni > nj then
      let lt, rt = match itree with ITree(a, b, i) -> a, b | ILeaf i -> (ILeaf i, ILeaf i) in
      let ilt, irt = (match lt with ITree(a, b, i) -> i | ILeaf i -> i), (match rt with ITree(a, b, i) -> i | ILeaf i -> i) in
      if ilt = nj || irt = nj then
        0
      else (
        print_tree lt;
        print_tree rt;
        1 + min (distance lt ilt nj) (distance rt irt nj)
      )
    else (
      let p = parent itree ni 0 in
      print_int p;
      if not (p = -1) then
        1 + (distance itree p nj)
      else
        453405840985
    )
  in
  distance itree ni nj
;;
