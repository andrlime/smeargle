module T = struct
  type t =
    { title : Variable.String.t
    ; start : Variable.String.t
    ; until : Variable.String.t
    ; bullets : Variable.Bullets.t
    ; organisation : Variable.String.t option [@sexp.option]
    }
  [@@deriving sexp]
end
