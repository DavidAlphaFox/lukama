(***********************************************************************)
(* Lukama: Static blog engine in OCaml                                 *)
(* (c) 2022 by Muqiu Han <muqiu-han@outlook.com>                       *)
(* Licence : MIT                                                       *)
(* https://opensource.org/licenses/MIT                                 *)
(***********************************************************************)

open Core

(* Get a markdown file path and convert it to HTML, return the converted string.
   TODO At present, the Omd version on opam does not seem to have the of_channel function.
        When it is available, it can be changed to of_channel to implement this function. *)
let to_html : string -> string =
 fun filepath -> filepath |> In_channel.read_all |> Omd.of_string |> Omd.to_html
;;