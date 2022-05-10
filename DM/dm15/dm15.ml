
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)
(* NOM : FOULON                                                     *)
(* Prénom : Valentin                                                *)
(*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*)

(*** I Multiplication de polynômes *)

(* Préliminaires *)
let poly1 = [|3;5;6;3;2|];;
let poly2 = [|2;4;6;7|];;


let sub tableau debut longueur =
  let len = Array.length tableau in
  if longueur < 0 then
    failwith "Longueur négative"
  else if debut + longueur > len then
    failwith "Out of bounds"
  else
    let ar = ref [||] in
    for i = 0 to longueur do
      ar := Array.append !ar [|tableau.(i + debut)|];
    done;
    !ar
;;

(* Opérations de base sur les polynômes *)

(* convention deg(0) = -1 *)
let degre polynome =
  let len = Array.length polynome - 1 in
  if polynome = Array.make (len + 1) 0 then
    (-1)
  else 
    (
      let i = ref 0 in
      while polynome.(len - !i) = 0 do
        i := !i + 1;
      done;
      len - !i
    )
;;

let reduire_repr polynome =
  if polynome = [|0|] then 
    polynome
  else 
    (
      let tab = ref [||] in
      let len = Array.length polynome - 1 in
      let _begin = ref false in
      for i = len downto 0 do
        (
          if polynome.(i) <> 0 then
            _begin := true
          else
            ();
          if !_begin then
            tab := Array.append [|polynome.(i)|] !tab;
        )
      done;
      !tab
    )
;;

let agrandir_repr polynome m =
  let len = Array.length polynome in
  let diff = m - len in
  if diff < 0 then
    failwith "Longueur demandée inférieure à celle du polynome"
  else 
    (
      let ar = Array.make diff 0 in
      Array.append polynome ar
    )
;;

(* Multiplication naïve *)

(* Suppose les deux représentations égales *)
let somme_egale poly1 poly2 =
  let l = Array.length poly1 - 1 in
  let ar = Array.make (l + 1) 0 in
  for i = 0 to l do
    (
      ar.(i) <- poly1.(i) + poly2.(i);
    )
  done;
  reduire_repr ar
;;

let somme poly1 poly2 =
  let len1, len2 = Array.length poly1 - 1, Array.length poly2 - 1 in
  let l = max len1 len2 in
  let ar = Array.make (l + 1) 0 in
  for i = 0 to (min len1 len2) do
    (
      ar.(i) <- poly1.(i) + poly2.(i);
    )
  done;
  for i = (min len1 len2 + 1) to l do
    ar.(i) <- if len1 < len2 then
      poly2.(i)
    else
      poly1.(i)
    done;
  ar
;;

let multiplication_scalaire poly lambda =
  let poly3 = Array.make (Array.length poly) 0 in
  for i = 0 to Array.length poly - 1 do
    poly3.(i) <- poly.(i) * lambda;
  done;
  poly3
;;

let shift_right poly puissance =
  if puissance < 0 then
    failwith "Puissance negative"
  else
    (
      let ar = Array.make puissance 0 in
      let newa = Array.append ar poly in
      newa
    )
;;

let shift_left poly puissance =
  let len = Array.length poly in
  Array.sub poly puissance (len - puissance)
;;

let multiplication_naive poly1 poly2 =
  let len1, len2 = Array.length poly1 - 1, Array.length poly2 - 1 in
  let lenf = (len1 + 1) * (len2 + 1) in
  let ar_f = ref (Array.make (lenf - 1) 0) in
  for i = len1 downto 0 do
      ar_f := somme (shift_right (multiplication_scalaire poly2 poly1.(i)) i) !ar_f;
  done;
  !ar_f
;;

(* Methode de Karatsuba *)
let rec split poly n =
  Array.sub poly 0 (n / 2), Array.sub poly (n / 2) (n / 2)
;;

let opposite poly =
  let newarr = Array.make (Array.length poly) 0 in
  for i = 0 to Array.length poly - 1 do
    newarr.(i) <- -poly.(i)
  done;
  newarr
;;

let reverse ar =
  let len = Array.length ar - 1 in
  let ar2 = Array.make (len + 1) 0 in
  for i = 0 to len do
    ar2.(len - i) <- ar.(i)
  done;
  ar2
;;

let karatsuba p q =
let rec karatsuba2 p q =
  let len = Array.length p in
  if len = 1 then
    multiplication_naive p q
  else
    let p1, p2 = split p len in
    let q1, q2 = split q len in
    let r1 = karatsuba2 p1 q1 in
    let r2 = karatsuba2 (somme p1 p2) (somme q1 q2) in
    let r3 = karatsuba2 p2 q2 in
    let left = shift_right r1 len in
    let right = r3 in
    let mid = shift_right (somme r2 (somme (opposite r3) (opposite r1))) (len / 2) in
     (somme (somme left right) mid)
  in
  reverse (karatsuba2 p q)
;;

let prochaine_puissance n =
  let rec prochaine_puissance_aux n k =
    if 2. ** k <= n then
      prochaine_puissance_aux n (k +. 1.)
    else
       int_of_float(2. ** k)
  in
  prochaine_puissance_aux (float_of_int n) 0.
;;

let multiplication_karatsuba poly1 poly2 =
  let len1, len2 = Array.length poly1, Array.length poly2 in
  let puissance1, puissance2 = prochaine_puissance len1, prochaine_puissance len2 in
  let nombres_total = max puissance1 puissance2 in
  let shift1, shift2 = (nombres_total - len1), nombres_total - len2 in
  shift_left (karatsuba (shift_right poly1 shift1) (shift_right poly2 shift2)) (shift1 + shift2)
;;