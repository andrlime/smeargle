module Boolean : sig
  type t =
    | Flag of Literal.ConfigValue.t
    | And of t * t
    | Or of t * t
    | Xor of t * t
  
  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end

module Integer : sig
  type t =
    | Integer of int
    | If of Boolean.t * int * int
  
  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end

module String : sig
  type t =
    | String of string
    | If of Boolean.t * string * string
  
  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end

module Bullets : sig
  type t = String.t list
  
  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end
