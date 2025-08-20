open Sexplib.Std

module Boolean = struct
  type t =
    | Flag of Literal.ConfigValue.t
    | And of t * t
    | Or of t * t
    | Xor of t * t
  [@@deriving sexp]
end

module Integer = struct
  type t =
    | Integer of int
    | If of Boolean.t * t * t
  [@@deriving sexp]
end

module Path = struct
  type t =
    | Path of Literal.Path.t
    | If of Boolean.t * t * t
  [@@deriving sexp]
end

module String = struct
  type t =
    | String of string
    | If of Boolean.t * t * t
    | When of Boolean.t * t
    | TwoColumn of t * t
  [@@deriving sexp]
end

module Bullets = struct
  type t = String.t list [@@deriving sexp]
end
