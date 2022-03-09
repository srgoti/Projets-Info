let init n f =
  let arr = Array.make n (f 0) in
  for i = 1 to n - 1 do
    arr.(i) <- (f i)
  done;
  arr;;

let range n =
  let arr = Array.make n 0 in
  for i = 1 to n - 1 do
    arr.(i) <- i
  done;
  arr;;

let fibonacci_tab n =
  let arr = Array.make n 0 in
  arr.(1) <- 1;
  for i = 2 to n - 1 do
    arr.(i) <- arr.(i - 1) + arr.(i - 2)
  done;
  arr;;

let map f arr =
  let len = Array.length arr - 1 in
  let arr2 = Array.make (len + 1) (f arr.(0)) in
  for i = 1 to len do
    arr2.(i) <- f arr.(i)
  done;
  arr2;;

let iter : ('a -> unit) -> 'a array -> unit = fun f arr ->
  for i = 0 to Array.length arr - 1 do
    f arr.(i)
  done;;

let miroir tab =
  let len = Array.length tab - 1 in
  let arr = Array.make (len + 1) tab.(len) in
  for i = 0 to len do
    arr.(i) <- tab.(len - i);
  done;
  arr;;

let array_of_list li =
  let len = List.length li in
  if len = 0 then
    failwith "Liste trop courte"
  else
    assert (List.length li >= 1);
    let arr = Array.make len (match li with h :: t -> h) in
    let rec aol li index arr =
      match li with
      |h :: t -> arr.(index) <- h; (aol t (index + 1) arr);
      |[] -> ()
    in
    aol (match li with h :: t -> t | h -> h) 1 arr;
    arr;;

let array_to_list arr =
  let len = Array.length arr - 1 in
  let rec atl arr index len =
    if index > len then
      []
    else
      arr.(index) :: (atl arr (index + 1) len)
  in
  atl arr 0 len;;

let make_matrix l c ini =
  let arr = Array.make l [||] in
  for i = 0 to l - 1 do
    let ligne = Array.make c ini in
    arr.(i) <- ligne
  done;
  arr
;;

let copy_matrix m =
  let arr = Array.make (Array.length m) m.(0) in
  for i = 0 to Array.length m - 1 do
    arr.(i) <- Array.copy m.(i);
  done;
  arr;;

let dimensions m =
  let x = Array.length m in
  let y = Array.length m.(0) in
  (x, y);;

let add_matrix m1 m2 =
  let x, y = dimensions m1 in
  let arr = make_matrix x y 0. in
  for i = 0 to x - 1 do
    for j = 0 to y - 1 do
      arr.(i).(j) <- m1.(i).(j) +. m2.(i).(j);
    done;
  done;
  arr;;

let transposee m =
  let x, y = dimensions m in
  let arr = make_matrix y x m.(0).(0) in
  for i = 0 to x - 1 do
    for j = 0 to y - 1 do
      arr.(j).(i) <- m.(i).(j)
    done;
  done;
  arr;;
