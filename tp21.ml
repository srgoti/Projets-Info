 
module type DynArraySig = sig
  type 'a t
  val get : 'a t -> int -> 'a
  val set : 'a t -> int -> 'a -> unit
  val push : 'a t -> 'a -> unit
  val pop : 'a t -> 'a
  val create : 'a -> 'a t
  val length : 'a t -> int
  val resize : 'a t -> int -> unit
end;;

                        
module DynArray : DynArraySig = struct 
type 'a t = {
    mutable len : int;
    mutable data : 'a option array;
  }
;;

let length da =
  da.len
;;

let create tab =
  {len = 1; data = [|None|]} 
;;

let get da ind =
  if ind - 1 > length da || ind < 0 then
    failwith "Index invalide"
  else
    da.data.(ind)
;;

let set da ind el =
  if ind - 1 > length da || ind < 0 then
    failwith "Index invalide"
  else
    da.data.(ind) <- el
;;

let resize da size =
  let l = length da in
  da.len <- size;
  let arr = Array.make size da.data.(0) in
  for i = 0 to l - 1 do
    arr.(i) <- da.data.(i);
  done;
  da.data <- arr
;;

let push da elem =
  let l = (length da) in
  resize da (l + 1);
  da.data.(l) <- elem
;;

let pop da =
  let l = (length da) in
  resize da (l - 1);
  da.data.(l)
;;

end;;
