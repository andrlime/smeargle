open Sexplib.Std

module Boolean = struct
  type t =
    | Flag of Literal.ConfigValue.t
    | And of t * t
    | Or of t * t
    | Xor of t * t
  [@@deriving sexp]

  let rec eval flags t =
    match t with
    | Flag name -> Store.T.get_key flags name
    | And (a, b) -> eval flags a && eval flags b
    | Or (a, b) -> eval flags a || eval flags b
    | Xor (a, b) -> eval flags (Or (a, b)) && not (eval flags (And (a, b)))
  ;;
end

module Integer = struct
  type t =
    | Integer of int
    | If of Boolean.t * t * t
  [@@deriving sexp]

  let eval _flags t = t
end

module Path = struct
  type t =
    | Path of Literal.Path.t
    | If of Boolean.t * t * t
  [@@deriving sexp]

  let eval _flags t = t
end

module String = struct
  type t =
    | String of string
    | If of Boolean.t * t * t
    | When of Boolean.t * t
    | TwoColumn of t * t
  [@@deriving sexp]

  let eval _flags t = t
end

module Bullets = struct
  type t = String.t list [@@deriving sexp]

  let eval _flags t = t
end
