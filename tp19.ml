let f_abs x y = abs(y) - abs(x);;
let f_couple x y =
  match x, y with
  |(a,b),(c,d) -> if a < c then
                    c - a
                  else if a > c then
                    a - c
                  else
                    if b < d then
                      b - d
                    else
                      d - b
;;

Array.stable_sort cmp_somme (Array.stable_sort cmp_premiere tab);;

(* Il faut floor(w / p) * p *)

(* 32, 16, 8, 4, 2, 1 *)

