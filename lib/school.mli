module Degree : sig
  type t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> t
  val typst_to_string : t -> string
end

module T : sig
  type t =
    { name : Variable.String.t
    ; start : Variable.String.t
    ; until : Variable.String.t
    ; degrees : Degree.t list
    ; where : Variable.String.t
    ; gpa : Variable.String.t option
    }

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> t
  val typst_to_string : t -> string
end
