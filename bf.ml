let prog = Array.make 30000 0

let stack = Stack.create () (* Stack to store [ *)

let ip = ref 0 (* Instruction Pointer *)

let dp = ref 0 (* Data Pointer *)

let file = ref "" (* File as string *)

(* Util to increment a ref by 1 *)
let incr_ref ref = ref := succ !ref

(* Util to increment a ref by 1 *)
let decr_ref ref = ref := pred !ref

(* Util to get char from STDIN and get it's ASCII value *)
let read_char () = int_of_char (input_char Stdlib.stdin)

let stack_printer () =
  if Stack.is_empty stack then "Empty"
  else Stack.fold (fun acc x -> string_of_int x ^ "; " ^ acc) "" stack

let read_file (file : string) : string =
  let fd = open_in file in
  let s = really_input_string fd (in_channel_length fd) in
  close_in fd;
  s

let jump_to_next () =
  let rec aux opening closing =
    match !file.[!ip] with
    | '[' ->
        (* Printf.printf "Found '[' at %d, opening : %d, closing %d\n" !ip opening
           closing; *)
        incr_ref ip;
        aux (succ opening) closing
    | ']' ->
        (* Printf.printf "Found ']' at %d, opening : %d, closing %d\n" !ip opening
           closing; *)
        if opening = closing then ()
        else (
          incr_ref ip;
          aux opening (succ closing))
    | _ ->
        if !ip = String.length !file then failwith "No closing bracket"
        else incr_ref ip;
        aux opening closing
  in
  aux (-1) 0

let eval c =
  (* Printf.printf
       "Character %c - IP : %d - DP Address : %d - Value : %d\nStack : %s\n\n" c
       !ip !dp prog.(!dp) (stack_printer ());
     flush Stdlib.stdout;
     Unix.sleepf 0.1; *)
  match c with
  | '>' -> incr_ref dp (* Increment Data Pointer Address *)
  | '<' -> decr_ref dp (* Decrement Data Pointer Address *)
  | '+' -> prog.(!dp) <- succ prog.(!dp)
  | '-' -> prog.(!dp) <- pred prog.(!dp)
  | '.' ->
      print_char (char_of_int prog.(!dp));
      flush Stdlib.stdout
  | ',' -> prog.(!dp) <- read_char ()
  | '[' -> if prog.(!dp) = 0 then jump_to_next () else Stack.push !ip stack
  | ']' ->
      if prog.(!dp) <> 0 then
        let jump_to = Stack.top stack in
        ip := jump_to
      else ignore (Stack.pop stack)
  | ' ' | '\n' | '\t' | '\r' -> ()
  | _ -> ()

let compute () =
  let rec aux () =
    let instr = !file.[!ip] in
    eval instr;
    incr_ref ip;
    if !ip = String.length !file then () else aux ()
  in
  aux ()

let parse path = file := read_file path

let () =
  parse Sys.argv.(1);
  compute ()
