(* Problème de 3n+1 *)

let rec collatz n mem =
  if n > 1 then (
    if n mod 2 = 0 then
      collatz (n / 2) (mem + 1)
    else
      collatz (3 * n + 1) (mem + 1)
  )
    else
      mem
;;
