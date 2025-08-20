open Sexplib.Std

module Degree = struct
  type t =
    | Degree of
        { title : Variable.String.t
        ; major : Variable.String.t
        ; note : Variable.String.t option [@sexp.option]
        }
  [@@deriving sexp]
end

module T = struct
  type t =
    { name : Variable.String.t
    ; start : Variable.String.t
    ; until : Variable.String.t
    ; degrees : Degree.t list
    ; where : Variable.String.t
    ; gpa : Variable.String.t option [@sexp.option]
    }
  [@@deriving sexp]
end
