module Profile : sig
  type t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> t
  val typst_to_string : t -> string
end

module Margin : sig
  type t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> t
  val typst_to_string : t -> string
end

module T : sig
  type t =
    { profile : Profile.t
    ; template : Variable.Path.t
    ; margin : Margin.t
    ; justify : Literal.Boolean.t
    ; pagesize : Variable.String.t
    ; font : Variable.String.t
    }

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> t
  val typst_to_string : t -> string
end
