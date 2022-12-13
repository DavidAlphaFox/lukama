(***********************************************************************)
(* Lukama: Static blog engine in OCaml                                 *)
(* (c) 2022 by Muqiu Han <muqiu-han@outlook.com>                       *)
(* Licence : MIT                                                       *)
(* https://opensource.org/licenses/MIT                                 *)
(***********************************************************************)

(* In Lukama, an article is just an article, 
   you only need to create a new md file in the article directory, 
   and the information of the article will be stored in the article table of .lukama/.data.toml.
   
   Command to create a new article: lukama new XXX
   
   If the article is not created by command, 
   lukama will compare the actual article list with the article list stored in .data.toml at runtime,
   and then ask for article information *)
