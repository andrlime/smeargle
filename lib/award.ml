module T = struct
  type t =
    { title : Variable.String.t
    ; organisation : Variable.String.t
    }
  [@@deriving sexp]
end
