module T : sig
  type t =
    | Typst of Variable.Path.t
    | None

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> t
end
