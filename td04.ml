let func1 a b = a + b;;
let func2 f = if f 6 = 6 then 1 else 0;;
let func3 = func1;;

let compose f g = function x -> f (g x);;
let compose f g x = f (g x);;
let compose f = function g -> function x -> f (g x);;
let compose = function f -> function g -> function x -> f (g x);;

let uncurry f2 (x, y) = let f1 (x, y) = f2 x y in f1 (x, y);;
let curry f1 x y = let f2 x y = f1 (x, y) in f2 x y;;
