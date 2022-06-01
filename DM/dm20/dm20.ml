let u0 = 42;;

let rec power k n =
  if n > 0 then
    k * power k (n - 1)
  else
    1
;;

let m = power 2 20 + 7;;

let rec u i =
  if i > 0 then
    (2035 * u (i - 1)) mod m
  else
    u0
;;

let v i j =
  ((j + 1) * u (i + j)) / m;;

let swap tab i1 i2 = 
  let t = tab.(i1) in
  tab.(i1) <- tab.(i2);
  tab.(i2) <- t;
;;


let pi n i a = 
  let x = Array.make n 0 in
  for k = 0 to n - 1 do
    x.(k) <- k;
  done;
  for j = 0 to n - 1 do
    swap x j (v i j);
  done;
  for j = 0 to n - 1 do
    x.(v i j) <- j;
  done;
  x.(a)
;;

let pi_alt n i = 
  let x = Array.make n 0 in
  for k = 0 to n - 1 do
    x.(k) <- k;
  done;
  for j = 0 to n - 1 do
    swap x j (v i j);
  done;
  for j = 0 to n - 1 do
    x.(v i j) <- j;
  done;
  x
;;

let rec len_cycle tab ind beg min =
  if (List.mem tab.(ind) min) then
    0 
  else if tab.(ind) = beg then 
    1
  else
    1 + len_cycle tab (tab.(ind)) beg min;;

let khi n i =
  let t = pi_alt n i in
  let minimums = ref [] in
  let lens = ref [] in
  for i = 0 to n - 1 do
    if not (List.mem i !minimums) then begin
      let x = len_cycle t i i !minimums in
      if not (x = 0) then begin
      lens := x :: !lens;
      minimums := i :: !minimums;
      end
    end
  done;
  lens;
;;