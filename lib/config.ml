(***********************************************************************)
(* Lukama: Static blog engine in OCaml                                 *)
(* (c) 2022 by Muqiu Han <muqiu-han@outlook.com>                       *)
(* Licence : MIT                                                       *)
(* https://opensource.org/licenses/MIT                                 *)
(***********************************************************************)

open Core
open Utils

module Struct = struct
  module Info = struct
    module Title = struct
      type t = string

      let parse : Toml.Types.table -> (t, string) result =
       fun info_table ->
        match
          Toml.Types.Table.find (Toml.Types.Table.Key.of_string "title") info_table
        with
        | Toml.Types.TString title -> Ok title
        | _ -> Error "The 'title' field type in the info table is wrong!"
     ;;
    end

    module Lang = struct
      type t = string

      let parse : Toml.Types.table -> (t, string) result =
       fun info_table ->
        match
          Toml.Types.Table.find (Toml.Types.Table.Key.of_string "lang") info_table
        with
        | Toml.Types.TString title -> Ok title
        | _ -> Error "The 'lang' field type in the info table is wrong!"
     ;;
    end

    module Description = struct
      type t = string

      let parse : Toml.Types.table -> (t, string) result =
       fun info_table ->
        match
          Toml.Types.Table.find (Toml.Types.Table.Key.of_string "description") info_table
        with
        | Toml.Types.TString title -> Ok title
        | _ -> Error "The 'lang' field type in the info table is wrong!"
     ;;
    end

    module Info_Table = struct
      type t = Toml.Types.table

      let parse : Toml.Types.table -> (t, string) result =
       fun config_filevalue ->
        match
          Toml.Types.Table.find (Toml.Types.Table.Key.of_string "info") config_filevalue
        with
        | Toml.Types.TTable info_table -> Ok info_table
        | _ -> Error "The configuration file lacks the 'info' table!"
     ;;
    end

    type info =
      { title : Title.t
      ; lang : Lang.t
      ; description : Description.t
      }

    type t = info

    let parse : Toml.Types.table -> info =
     fun config_filevalue ->
      let info_table = Info_Table.parse config_filevalue |> unsafe in
      let title = Title.parse info_table |> unsafe in
      let lang = Lang.parse info_table |> unsafe in
      let description = Description.parse info_table |> unsafe in
      { title; lang; description }
   ;;
  end

  module Style = struct
    module Style_Table = struct
      type style_table = Toml.Types.table
      type t = style_table

      let parse : Toml.Types.table -> (style_table, string) result =
       fun config_filevalue ->
        match
          Toml.Types.Table.find (Toml.Types.Table.Key.of_string "style") config_filevalue
        with
        | Toml.Types.TTable info_table -> Ok info_table
        | _ -> Error "The configuration file lacks the 'style' table!"
     ;;
    end

    module Theme = struct
      type t = string

      let parse : Toml.Types.table -> (t, string) result =
       fun style_table ->
        match
          Toml.Types.Table.find (Toml.Types.Table.Key.of_string "theme") style_table
        with
        | Toml.Types.TString title -> Ok title
        | _ -> Error "The 'lang' field type in the info table is wrong!"
     ;;
    end

    type style = { theme : string }
    type t = style

    let parse : Toml.Types.table -> t =
     fun config_filevalue ->
      let style_table = Style_Table.parse config_filevalue |> unsafe in
      let theme = Theme.parse style_table |> unsafe in
      { theme }
   ;;
  end

  type config_file_struct =
    { info : Info.t
    ; style : Style.t
    }

  let parse : Toml.Types.table -> config_file_struct =
   fun config_filevalue ->
    { info = Info.parse config_filevalue; style = Style.parse config_filevalue }
 ;;

  type t = config_file_struct
end

let parse : string -> Toml.Types.table =
 fun config_filepath ->
  let () = Simlog.info "Parser config file ..." in
  match Toml.Parser.from_filename config_filepath with
  | `Ok toml_table -> toml_table
  | `Error (msg, { source; line; column; position }) ->
    let error_msg =
      Format.sprintf
        "While parsing configuration file '%s', an error was found at line '%d', \
         character '%d': %s (%d)"
        source
        line
        column
        msg
        position
    in
    let () = Simlog.error error_msg in
    failwith error_msg
;;

let load : string -> Struct.t =
 fun config_filepath ->
  let () = Simlog.info "load config file ..." in
  config_filepath |> parse |> Struct.parse
;;
