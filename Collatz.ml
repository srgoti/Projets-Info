(* Problème de 3n+1 *)

let rec collatz n =
  print_int n;
  print_newline();
  if n > 1 then (
    if n mod 2 = 0 then
      collatz (n / 2)
    else
      collatz (3 * n + 1)
  )
;;
