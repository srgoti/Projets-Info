 
let prix_auberge heure =
  if heure < 7 then failwith "Pas homogène" else 
  if heure < 12 then 10 else
  if 10 + 5 * (heure - 12) < 53 then 10 + 5 * (heure - 12) else 53;;

let tri3 a b c =
  if a < b && a < c then
    if b < c then
      (a, b, c)
    else
      (a, c, b)
  else if b < c && b < a then
    if c < a then
      (b, c, a)
    else
      (b, a, c)
  else
    if b < a then
      (c, b, a)
    else
      (c, a, b)
;;

let racine a b c =
  if a = 0. && b = 0. then
    if c = 0. then
      -1
    else
      0
  else
    if a = 0. then
      1
    else
      
  let delta = b ** 2. -. 4. *. a *. c in
  if delta = 0. then
    1
  else if delta > 0. then
    2
  else
    - 1;;


let rec catalan n =
  if n = 0 then
    1
  else
    (catalan (n - 1)) * (2 * (2 * n - 1)) / (n + 1);;

let f x =
  x +. cos (x) +. 3. *. sin (x /. 2.);;

let est_premier n =
  let rec premiers_entre_eux a b =
    if a = b then
      true
    else if a mod b = 0 then
      false
    else
      premiers_entre_eux a (b + 1)
  in
  if n = 2 then
    true
  else  
    premiers_entre_eux n 2;;


let log2 n =
  let rec is_inf n k =
    if (2. ** (float_of_int k)) >= float_of_int n then
      k - 1
    else
      is_inf n (k + 1)
  in
  is_inf n 1;;

type entier =
  | Zero
  | Successeur of entier
;;

let int_vers_entier a =
  let rec u a =
  if a = 0 then
    Zero
  else
    Successeur (u (a - 1))
  in
  u a;;

let entier_vers_int a =
  let rec test entier int =
  if (int_vers_entier int) = entier then
    0
  else
    1 + test entier (int + 1)
  in
  test a 0;;

let add a b =
  int_vers_entier ((entier_vers_int a) + (entier_vers_int b));;

let mult a b =
  int_vers_entier ((entier_vers_int a) * (entier_vers_int b));;

let expo a b =
  int_of_float((float_of_int (entier_vers_int a)) ** (float_of_int (entier_vers_int b)));;

type 'a liste =
  | Nil
  | TeteEtQueue of ('a * 'a liste)
;;

let list = TeteEtQueue(5, TeteEtQueue(2, TeteEtQueue(6, Nil)));;

let somme liste =
  let rec do list index
  match liste with
  | TeteEtQueue (a, Nil) -> ()
  | TeteEtQueue 
