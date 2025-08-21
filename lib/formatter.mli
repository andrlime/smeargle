module T : sig
  type t =
    | Unformatted of string
    | Bold of string
    | Italics of string

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val format : string -> t list
  val is_not_empty : t -> bool
  val typst_to_string : t -> string
end
