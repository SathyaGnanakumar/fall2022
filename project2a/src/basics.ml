(***********************************)
(* Part 1: Non-Recursive Functions *)
(***********************************)

let rev_tup tup = match tup with 
    | (a, b, c) -> (c, b, a)

let is_odd x = 
    if x mod 2 = 0 then
        false
    else
        true

let area x y = 
    match x with 
        (x1, x2) -> match y with 
            (y1, y2) -> abs((y1 - x1) * (y2 - x2))

let volume x y = (* Same procedure just with an additional argument in tuple *)
    match x with 
        (x1, x2, x3) -> match y with 
            (y1, y2, y3) -> abs((y1 - x1) * (y2 - x2) * (y3 - x3))

(*******************************)
(* Part 2: Recursive Functions *)
(*******************************)

let rec fibonacci n = 
    if n = 0 then
        0
    else if n = 1 then
        1
    else 
        fibonacci(n - 2) + fibonacci(n - 1)

let rec pow x y = 
    if y = 0 then
        1
    else if y = 1 then
        x
    else
        x * pow x (y - 1)

let rec log x y = 
    if x > y then
        0
    else    
        1 + log x (y / x)

let rec gcf x y = 
    if y = 0 then
        x
    else
        gcf y (x mod y)

let rec is_prime_helper x y = 

    if x < 2 then
        false
    else if y >= x then
        true
    else if x = 2 then
        true
    else if (x mod y = 0) then
        false
    else
        is_prime_helper x (y + 1) (* Increment y like a counter to find value which makes divisible *)

let rec is_prime x = 
    is_prime_helper x 2 

(*****************)
(* Part 3: Lists *)
(*****************)

let rec get idx lst = match lst with 
    | [] -> failwith "Out of bounds"
    | (h::t) -> if idx = 0 then h else get (idx - 1) t

let rec length l =
  match l with
    | [] -> 0
    | _ :: tl -> 1 + length tl

let larger lst1 lst2 = 
    if length lst1 == length lst2 then
        []
    else if length lst1 < length lst2 then
        lst2
    else
        lst1

let rec append l m = match l with
    []-> m
    |h::t -> h :: (append t m)

let rec reverse lst = match lst with
    |[] -> []
    | h::t -> append (reverse t) (h::[])

let rec combine lst1 lst2 = 
    match lst1 with 
        | [] -> lst2 
        | (h::t) -> h:: (combine t lst2)

let rec merge lst1 lst2 =  
    match lst1, lst2 with 
        | lst1, [] -> lst1 (* If the second list empty return the first *)
        | [], lst2 -> lst2 (* If the first list empty return the second *)
        | hlst1 :: tlst1, hlst2 :: tlst2 ->
            if hlst1 < hlst2 then   (* Figure out which is greater *)
                hlst1 :: merge tlst1 lst2 (* Return head 1 *)
            else    
                hlst2 :: merge lst1 tlst2 (* Return head 2 if less than *)
    

let rec rotate shift lst = 
    if shift = 0 then (* Nothing to shift *)
        lst 
    else   
        match lst with 
            | [] -> lst
            | (h::t) -> rotate (shift - 1) (t@[h])

let rec is_palindrome lst = 
    (* Just check if reverse list is the same as list! *)
    reverse lst = lst 