open Sexplib.Std

module AstNode = struct
  type t =
    | Flag of Literal.ConfigValue.t * Literal.Boolean.t
    | Config of Config.T.t
    | Section of Literal.SectionName.t
    | School of School.T.t
    | List of Literal.SectionName.t * Variable.Bullets.t
    | Job of Job.T.t
    | Project of Project.T.t
    | Award of Award.T.t
    | When of Variable.Boolean.t * t
    | If of Variable.Boolean.t * t * t
  [@@deriving sexp]
end

module T = struct
  type t = AstNode.t list [@@deriving sexp]

  let to_string t = t |> sexp_of_t |> Sexplib.Sexp.to_string
  let of_string str = str |> Sexplib.Sexp.of_string |> t_of_sexp
end
