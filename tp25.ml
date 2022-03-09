Sys.rename titi.txt tata.txt;;


let move = 
  let () = print_string "Quel programme souhaitez-vous renommer ?" in
  let a = read_line() in
  let () = print_string "Avec quel nouveau nom ?" in
  let b = read_line() in
  Sys.rename a b;;

let move_sys =
  if Array.length Sys.argv != 2 then
    failwith "Mauvais nombre d'arguments"
  else
    Sys.rename Sys.argv.(1) Sys.argv.(2);;

let arit =
  let c = Array.length Sys.argv in
  if c = 1 then
    0
  else if c = 2 then
    (int_of_string Sys.argv.(1)) + 1
  else if c = 3 then
    (int_of_string Sys.argv.(1)) + (int_of_string Sys.argv.(2))
  else if c = 4 then
    (int_of_string Sys.argv.(1)) * (int_of_string Sys.argv.(2)) * (int_of_string Sys.argv.(3))
  else
    42;;

let cameleon =
  let c = Sys.argv.(0) in
  let count = Array.length Sys.argv in
  let n = if count = 1 then
            "cameleon.exe"
          else
            (
              Random.self_init();
              let i = (Random.int count mod count) + 1 in
              Sys.argv.(i)
            )
  in
  Sys.rename c n;;

