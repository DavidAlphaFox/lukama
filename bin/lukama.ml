open Lukama_lib

let _ =
  let () = print_newline () in
  let () = Simlog.Level.global := Simlog.Level.Debug in
  Config.load Sys.argv.(1)
;;
