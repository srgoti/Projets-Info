let dejavu el arr ini =
  let found = ref 0 in
  for i = 0 to ini - 1 do
    if arr.(i) = el then
      found := 1
  done;
  1 - !found
;;

let cardinal_liste li =
  let arr = Array.of_list li in
  let len = List.length li - 1 in
  let rec card li ar index =
    match li with
    | h :: t -> (dejavu h ar (index)) + (card t ar (index + 1))
    | [] -> 0
  in
  card li arr 0
;;

type ('a, 'b) dict = ('a * 'b) list;;

let rec get : 'a -> ('a, 'b) dict -> 'b = fun x m ->
  match m with
  |(a,b) :: n -> if x = a then b else get x n
  |[] -> None
;;

let rec set : 'a -> 'b -> ('a, 'b) dict -> ('a, 'b) dict = fun x y m ->
  match m with
  |[] -> (x, y) :: m
  |(a, _) :: n when a = x -> (a, y) :: n
  |c :: n -> c :: (set x y n)
;;

let rec of_list : ('a * 'b) list -> ('a, 'b) dict = fun li ->
  match li with
  |(a, b) :: n -> (a, b) :: (of_list n)
  |[] -> []
;;

let rec to_list : ('a, 'b) dict -> ('a * 'b) list = fun di ->
  match di with
  |(a, b) :: n -> (a, b) :: (to_list n)
  |[] -> []
;;

type 'a abr =
  | V
  | N of 'a abr * 'a * 'a abr;;

let rec appartient tree elem =
  match tree with
  |N(a, x, b) -> (x = elem || appartient a elem) || appartient b elem
  |V -> false
;;

let minimum tree =
  let mini = 
    ref (match tree with
    |N(a, x, b) -> x
    |V -> failwith "Not a t")
  in
  let rec min mini tr =
    match tr with
    |N(a, x, b) -> (if x < !mini then mini := x); min mini a; min mini b;
    |V -> ()
  in
  min mini tree;
  !mini
;;
