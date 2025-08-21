module T = struct
  type t =
    | Typst of Variable.Path.t
    | None
  [@@deriving sexp]

  let eval flags t =
    match t with
    | Typst p -> Typst (Variable.Path.eval flags p)
    | None -> None
  ;;
end
