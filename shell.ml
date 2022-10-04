open Unix

(* We need to do navigation and know how to start processes, no operations, and exit shell *)

type exec = {name: string; 
             args: string list
            }

type command = 
    | Nav of string
    | SP of exec
    | Empty 
    | Exit

let rec batch_shell commands =  
    match commands with 
    | []            ->  exit 0 
    | Exit::cs      ->  exit 0
    | Empty::cs     ->  batch_shell cs
    | Nav(dir)::cs  ->  
        let _ = chdir dir in 
        batch_shell cs 
    | SP(ex)::cs    -> failwith "TODO: starting process"
                