(lang dune 3.18)

(name smeargle)

(generate_opam_files true)

(source
 (github andrlime/smeargle))

(authors "Andrew Li <andrewli@u.northwestern.edu>")
(maintainers "Andrew Li <andrewli@u.northwestern.edu>")

(license MIT)

(package
 (name smeargle)
 (synopsis "Resume templating DSL engine, built for Typst but can plug-and-play with LaTeX too")
 (description "Lisp like wrapper of a subset of Typst")
 (depends dune ocaml ocamlformat csv core_unix sexplib ppx_sexp_conv)
 (tags
  ("ocaml" "dsl" "cli" "codegen" "csv" "compiler" "react")))
