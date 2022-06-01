(*Exercice 1*)
let est_rationnel (a, b) = if a mod b = 0 then false else true;;
let entier_vers_rationnel x = (x * 5, 5);;
let multiplication (x, y) = function (a, b) -> (x * a, y * b);;
let addition (x, y) = function (a, b) -> (x * b + a * y, y * b);;
let sont_egaux (x, y) = function (a, b) -> if x * b - y * a = 0 then true else false;;
let pgcd x = function y -> if x = y then 1 else if x mod y = 0 then y mod x else x mod y;;
let abs x = int_of_float(sqrt(float_of_int x ** 2.));;
let fraction_irreductible (x, y) = if (pgcd x y) = 1 then (x, y) else ((x / (pgcd x y)), (y / (pgcd x y)));;

(*Exercice 2*)
let floattoint x = int_of_float x;;
let f1 x = let floattoint x = float_of_int (int_of_float x) in if float_of_int x = 0. then floattoint else floattoint;;
let f2 f = let fonction = f in (fonction 0) +. 0.5;;
let f3 x = function y -> float_of_int x *. y;;
let f4 f x = if f x = float_of_int x then f x else float_of_int x;;
let f5 a = let f x = function y -> float_of_int y *. x in if a = 5 then f else f;;
let f6 a f = if f (float_of_int a) = int_of_float (float_of_int a) then float_of_int a else float_of_int (f (float_of_int a));;
let f7 a = let f x = function y -> float_of_int y *. x in if a = 5 then f else f;;
let f8 f = let f3 a = function y -> int_of_float (float_of_int a *. y) in if f 5 = f3 5 then 5. else 6.;;

(*Exercice 3*)
let rec delta u x = u (x + 1) - u (x);;

(*Exercice 4*)
let rec nombre_chiffres x =
  if x = 0 then
    1
  else
    if x >= 10 then
      1 + nombre_chiffres (x / 10)
    else
      nombre_chiffres (x / 10);;

(*Exercice 5*)
let rec produit f n m =
  if n >= m || n < 0 || m < 0 then
    0.
  else
    f (float_of_int n) +. produit f (n + 1) m;;
                                           

(*Exercice 6*)
let rec iter f x n =
  if n > 0 then
    f n (iter f x (n-1))
  else
    f 1 x;;

(*Exercice 7*)
let rec nombre_ecriture n m =
  if m = 1 || (n - m) < 1 then
    if n < m then
      0
    else
      1
  else
    nombre_ecriture (n - 1) (m - 1) + nombre_ecriture (n - m) m;;

(*Exercice 8*)
let rec probleme_48 n = let rec primary n = 
  if n = 0 then
    0
  else
    int_of_float(float_of_int n ** float_of_int n) + primary (n - 1) in primary n mod 10000000000;;
