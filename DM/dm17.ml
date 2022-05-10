let a1 = [|7;9;3;4;8;4|];;
let a2 = [|8;5;6;4;5;7|];;
let t1 = [|2;3;1;3;4|];;
let t2 = [|2;1;2;2;2;1|];;
let e1 = 2;;
let e2 = 4;;
let x1 = 3;;
let x2 = 2;;
let f1 = [|-1;-1;-1;-1;-1;-1|];;
let f2 = [|-1;-1;-1;-1;-1;-1|];;
let l1 = [|-1;-1;-1;-1;-1;-1|];;
let l2 = [|-1;-1;-1;-1;-1;-1|];;
let f = [|-1;-1;-1;-1;-1;-1|];;
let f_star = -1;;
let l_star = -1;;

let plus_rapide_chemin a t e x n =
  f1.(0) <- e.(0) + a.(0).(0);
  f2.(0) <- e.(1) + a.(1).(0);
  for j = 1 to (n - 1) do
    (
      if f1.(j - 1) + a.(0).(j) <= f2.(j - 1) + t.(1).(j - 1) + a.(0).(j) then
        (
          f1.(j) <- f1.(j - 1) + a.(0).(j);
          l1.(j) <- 0;
        )
      else
        (
          f1.(j) <- f2.(j - 1) + t.(1).(j - 1) + a.(0).(j);
          l1.(j) <- 1;
        )
    );
    (
      if f2.(j - 1) + a.(1).(j) <= f1.(j - 1) + t.(0).(j - 1) + a.(1).(j) then
        (
          f2.(j) <- f2.(j - 1) + a.(1).(j);
          l2.(j) <- 1;
        )
      else
        (
          f2.(j) <- f1.(j - 1) + t.(0).(j - 1) + a.(1).(j);
          l2.(j) <- 0;
        )
    );
  done;
  if f1.(n - 1) + x.(0) <= f2.(n - 1) + x.(1) then
    (
      let f_star = f1.(n - 1) + x.(0) in
      let l_star = 0 in
      (f_star, l_star, [|f1; f2|], [|l1; l2|])
    )
  else
    (
      let f_star = f2.(n - 1) + x.(1) in
      let l_star = 1 in
      (f_star, l_star, [|f1; f2|], [|l1; l2|])
    )
;;

let afficher_postes lstar l n =
  let empty = Array.make n [|-1;-1|] in
  let i = lstar in
  empty.(0) <- [|i + 1; n|];
  (*Printf.printf "chaine %d, poste %d\n" (i + 1) (n);*)
  for j = n - 1 downto 1 do
    (
      let i = l.(i + 1).(j) in
      empty.(n - j) <- [|i + 1; j|];
    (*Printf.printf "chaine %d, poste %d\n" (i + 1) j;*)
    )
  done;
  for k = n - 1 downto 0 do
    Printf.printf "chaine %d, poste %d\n" empty.(k).(0) empty.(k).(1);
  done;
;;

let multiplier_matrices a b =
  let cols_a = Array.length a.(0) in
  let lines_b = Array.length b in
  let c = Array.make (Array.length a) [||] in
  if cols_a <> lines_b then
    failwith "dimensions incompatibles"
  else
    for i = 0 to Array.length a - 1 do
     (
       c.(i) <- Array.make (Array.length b.(0)) 0;
       for j = 0 to Array.length b.(0) - 1 do
        (
          c.(i).(j) <- 0;
          for k = 0 to cols_a - 1 do
            (
              c.(i).(j) <- c.(i).(j) + a.(i).(k) + b.(k).(j);
            )
          done;
        )
      done;
     )
    done;
    c
;;

let ordre_chaine_matrices p =
  let n = Array.length p - 1 in
  let m = Array.make n [||] in
  let s = Array.make n [||] in
  for i = 0 to n - 1 do
    (
      m.(i) <- Array.make n (-1);
      s.(i) <- Array.make n (-1);
      m.(i).(i) <- 0;
    )
  done;
  for l = 2 to n do
    Printf.printf "l = %d\n" l;
    (
      for i = 1 to n - l + 1 do
        Printf.printf "i = %d\n" i;
        (
          let j = i + l - 1 in
          m.(i - 1).(j - 1) <- (-1);
          for k = i to j - 1 do
            Printf.printf "k = %d\n" k;
            (
              let q = m.(i - 1).(k - 1) + m.(k).(j - 1) + p.(i - 1) * p.(k - 1) * p.(j - 1) in
              if q < m.(i - 1).(j - 1) || q = (-1) then
                (
                  m.(i - 1).(j - 1) <- q;
                  s.(i - 1).(j - 1) <- k;
                )
            )
          done;
        )
      done;
    )
  done;
  (m, s)
;;

let rec recuperer_chaine p i j m =
  if m.(i - 1).(j - 1) > (-1) then
    m.(i - 1).(j - 1)
  else
    (
      if i = j then
        m.(i - 1).(j - 1) <- 0
      else
        (
          for k = i to j - 1 do
            let q = recuperer_chaine p i k m + recuperer_chaine p (k + 1) j m + p.(i - 2) + p.(k - 1) + p.(j - 1) in
            if q < m.(i - 1).(j - 1) then
              m.(i - 1).(j - 1) <- q;
          done;
        );
      m.(i - 1).(j - 1)
    )
;;

let memorisation_chaine_matrices p =
  let n = Array.length p - 1 in
  let m = Array.make n [||] in
  for i = 1 to n do
    m.(i - 1) <- Array.make n (-1);
  done;
  recuperer_chaine p 1 n m
;;
