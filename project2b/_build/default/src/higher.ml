open Funs

(********************************)
(* Part 1: High Order Functions *)
(********************************)

let contains_elem lst e = 
    fold (fun a x -> if x = e then true else a) false lst

let is_present lst x = 
    map (fun f -> if f = x then 1 else 0) lst

let count_occ lst target = 
    fold (fun acc x -> if x = target then acc + 1 else acc) 0 lst

let uniq lst = 
    fold(fun a x -> if contains_elem a x then a else x::a) [] lst

let assoc_list lst = failwith "unimplemented"

let ap fns args = failwith "unimplemented"
