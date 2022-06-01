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

let max_len_c =
  let mini = ref (-1) in
  let i_mini = ref 0 in
  for i = 1 to 1000000 do
    let res = collatz i 0 in
    if res > !mini then
      (
        mini := res;
        i_mini := i;
      )
    done;
    !i_mini;;