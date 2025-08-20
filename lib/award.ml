module T = struct
  type t =
    { title : Variable.String.t
    ; organisation : Variable.String.t
    }
  [@@deriving sexp]

  let eval _flags t = t
end
