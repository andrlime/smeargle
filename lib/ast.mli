module AstNode : sig
  type t =
    | Flag of Literal.ConfigValue.t * Literal.Boolean.t
    | Output of Output.T.t
    | Config of Config.T.t
    | Section of Literal.SectionName.t
    | School of School.T.t
    | List of Literal.SectionName.t * Variable.Bullets.t
    | Job of Job.T.t
    | Project of Project.T.t
    | Award of Award.T.t
    | When of Variable.Boolean.t * t
    | If of Variable.Boolean.t * t * t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end

module T : sig
  type t = AstNode.t list

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val to_string : t -> string
  val of_string : string -> t
end
