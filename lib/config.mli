module Profile : sig
  type t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> t
end

module Margin : sig
  type t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> t
end

module Output : sig
  type t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> t
end

module T : sig
  type t =
    { profile : Profile.t
    ; template : Variable.Path.t
    ; margin : Margin.t
    ; justify : Literal.Boolean.t
    ; pagesize : Variable.String.t
    ; font : Variable.String.t
    ; output : Output.t
    }

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val eval : Flags.T.t -> t -> t

  val create_config
    :  profile:Profile.t
    -> template:Variable.Path.t
    -> margin:Margin.t
    -> justify:Literal.Boolean.t
    -> pagesize:Variable.String.t
    -> font:Variable.String.t
    -> output:Output.t
    -> t
end
