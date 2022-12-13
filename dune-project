(lang dune 3.6)

(name lukama)

(generate_opam_files true)

(source
 (github muqiuhan/lukama))

(authors "Muqiu Han")

(maintainers "Muqiu Han")

(license MIT)

(documentation https://github.com/muqiuhan/lukama)

(package
 (name lukama)
 (synopsis "Static blog engine in OCaml")
 (description "Static blog engine in OCaml")
 (depends ocaml dune toml dream omd simlog)
 (tags
  (blog)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
