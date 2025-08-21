module T = struct
  type t =
    { title : Variable.String.t
    ; organisation : Variable.String.t
    }
  [@@deriving sexp]

  let eval flags t =
    { title = Variable.String.eval flags t.title
    ; organisation = Variable.String.eval flags t.organisation
    }
  ;;

  let typst_to_string t =
    Printf.sprintf
      {|#award(%s, %s)|}
      (Variable.String.typst_to_string t.title)
      (Variable.String.typst_to_string t.organisation)
  ;;
end
