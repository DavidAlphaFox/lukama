(***********************************************************************)
(* Lukama: Static blog engine in OCaml                                 *)
(* (c) 2022 by Muqiu Han <muqiu-han@outlook.com>                       *)
(* Licence : MIT                                                       *)
(* https://opensource.org/licenses/MIT                                 *)
(***********************************************************************)

let unsafe : ('a, string) result -> 'a =
  fun v ->
   match v with
   | Ok v -> v
   | Error msg ->
     let () = Simlog.error msg in
     failwith msg
;;