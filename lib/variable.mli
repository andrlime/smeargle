module Boolean : sig
  type t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> bool
  val typst_to_string : t -> string
end

module Integer : sig
  type t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> t
  val typst_to_string : t -> string
end

module Path : sig
  type t =
    | IPath of Literal.Path.t
    | OPath of Literal.Path.t
    | If of Boolean.t * t * t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> t
  val typst_to_string : t -> string
  val check_path_exists : Literal.Path.t -> Literal.Path.t
end

module String : sig
  type t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> t
  val typst_to_string : t -> string
end

module Bullets : sig
  type t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> t
  val typst_to_string : t -> string
end
