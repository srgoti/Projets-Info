let rec length list =
  match list with
  | [] -> 0
  | h :: t -> 1 + length t
;;

let hd list =
  match list with
  | h :: t -> t
  | _ -> failwith "PAS HOMOGENE"
;;

let rec tl list =
  match list with
  | _ :: t -> tl t
  | [a] -> a
;;

let rec getall a =
  match list with
  | a -> a
  | h::t

let append lista listb =
  let listb = for sif = 0 to (length lista) do
    (nth sif lista) :: listb
  done in
  listb
;;

let rec nth n list =
  if n = 0 then
    match list with
    | a :: _ -> a
    | _ -> ignore
  else
    match list with
    | _ :: b -> nth (n - 1) b
    | _ -> ignore
;;

let rec decouple a =
  let match a with
  | (a,b) :: (c,d) -> 
