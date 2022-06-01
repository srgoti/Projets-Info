let rec assoc (k : 'a) (li : ('a * 'b) list) =
  match li with
  | (key, value) :: t when key = k -> value
  | (key, value) :: t -> assoc k t
  | [] -> failwith "Key not found"
;;

let rec assoc_opt (k : 'a) (li : ('a * 'b) list) =
  match li with
  | (key, value) :: t when key = k -> Some(value)
  | (key, value) :: t -> assoc_opt k t
  | [] -> None
;;

let rec mem_assoc (k : 'a) (li : ('a * 'b) list) =
  match li with
  | (key, value) :: t when key = k -> true
  | (key, value) :: t -> mem_assoc k t
  | [] -> false
;;

let remove_assoc (k : 'a) (li : ('a * 'b) list) =
  let rec remove el li2 prev = 
  match li with
  | (key, value) :: t when key = k -> remove el t prev
  | (key, value) :: t -> remove el t ((key,value) :: prev)
  | [] -> prev
  in
  List.rev(remove k li [])
;;

let hash_int m k =
  let res = k mod m in
  if res > 0 then
    res
  else
    res + m
;;

let rec power n k =
  if k > 1 then
    n * power n (k - 1)
  else if k = 1 then
    n
  else
    -1
;;

let convert_string (str : string) =
  let ttl = ref 0 in
  let len = String.length str in
  for i = 0 to len - 1 do
    let c = (int_of_char (String.get str i)) * (power 256 i) in
    ttl := !ttl + c;
  done;
  !ttl
;;

let hash_string (value : int) (str : string) =
  hash_int value (convert_string str)
;;

Hashtbl.hash 42;;
Hashtbl.hash 43;;
Hashtbl.hash 44;;
Hashtbl.hash 45;;

let hash m x = Hashtbl.hash x mod m;;

type ('a, 'b) hashtbl = {
  mutable data : ('a * 'b) list array;
  mutable size : int;
  mutable h : 'a -> int
}

let create (value : int) =
  ({data = [|[]|]; size = 0; h = hash 1} : ('a, 'b)hashtbl)
;;

let length (t : ('a, 'b) hashtbl) =
  let ttl = ref 0 in
  let len = Array.length t.data in
  for i = 0 to len - 1 do
    let d = t.data.(i) in
    let rec count li =
      match li with
      | [] -> 0
      | h :: t -> 1 + count t
    in
    ttl := !ttl + (count d);
  done;
  !ttl
;;

let mem k (t : ('a, 'b) hashtbl) =
  let i = t.h k in
  let d = t.data.(i) in
  let rec count li k =
    match li with
    | [] -> false
    | (key, value) :: t when key = k -> true
    | (key, value) :: t -> count t k
  in
  count d k
;;

let rec add (tbl : ('a, 'b) hashtbl) (key : 'a) (value : 'b) =
  let index = tbl.h key in
  let newli = (key, value) :: tbl.data.(index) in
  tbl.data.(index) <- newli;
  tbl.size <- tbl.size + 1
;;

let find k (t : ('a, 'b) hashtbl) =
  let i = t.h k in
  let d = t.data.(i) in
  let rec count li k =
    match li with
    | [] -> failwith "Not_found"
    | (key, value) :: t when key = k -> value
    | (key, value) :: t -> count t k
  in
  count d k
;;

let find_opt k (t : ('a, 'b) hashtbl) =
  let i = t.h k in
  let d = t.data.(i) in
  let rec count li k =
    match li with
    | [] -> None
    | (key, value) :: t when key = k -> Some(value)
    | (key, value) :: t -> count t k
  in
  count d k
;;

let find_all k (t : ('a, 'b) hashtbl) =
  let i = t.h k in
  let d = t.data.(i) in
  let rec count li k fnd =
    match li with
    | [] -> fnd
    | (key, value) :: t when key = k -> count t k (value :: fnd)
    | (key, value) :: t -> count t k fnd
  in
  count d k []
;;

let find_all k (t : ('a, 'b) hashtbl) =
  let i = t.h k in
  let d = t.data.(i) in
  let rec count li k mem =
    match li with
    | [] -> mem
    | (key, value) :: t when key = k -> count t k mem
    | (key, value) :: t -> count t k ((key, value) :: mem)
  in
  let li = count d k [] in
  t.data.(i) <- li
;;

let remove (k : 'a) (t : ('a, 'b) hashtbl)=
  let i = t.h k in
  let d = t.data.(i) in
  let rec count li k mem tb =
    match li with
    | [] -> mem
    | (key, value) :: t when key = k -> if tb = true then count t k mem false else count t k ((key, value) :: mem) tb
    | (key, value) :: t -> count t k ((key, value) :: mem) tb
  in
  let li = count d k [] true in
  t.data.(i) <- li;
  t.size <- t.size + 1;
;;


let replace (k : 'a) (t : ('a, 'b) hashtbl) (v : 'b)=
  let i = t.h k in
  let d = t.data.(i) in
  let rec count li k v mem tb =
    match li with
    | [] -> mem
    | (key, value) :: t when key = k -> if tb = true then count t k v ((key, v) :: mem) false else count t k v ((key, value) :: mem) tb
    | (key, value) :: t -> count t k v ((key, value) :: mem) tb
  in
  let li = count d k v [] true in
  t.data.(i) <- li
;;

let rec iter (fct : 'a -> 'b -> unit) (tbl : ('a, 'b) hashtbl) =
  let len = Array.length tbl.data in
  for i = 0 to len - 1 do
    let rec iter_aux f li =
      match li with
      |[] -> ();
      |(key, value) :: t -> f key value; iter_aux f t;
    in
    iter_aux fct tbl.data.(i);
  done;
;;

let rec resize (tbl : ('a, 'b) hashtbl) =
  tbl.h <- hash (2 * tbl.size);
  for i = 0 to tbl.size do
    ()
  done;
  tbl.size <- tbl.size * 2;