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
end
