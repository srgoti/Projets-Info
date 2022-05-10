let sum_multiples_1000 =
  let t = ref 0 in
  for i = 0 to 999 do
    if i mod 3 = 0 || i mod 5 = 0 then
      t := !t + i
  done;
  !t
;;