module T = struct
  type t =
    { company : Variable.String.t
    ; title : Variable.String.t
    ; start : Variable.String.t
    ; until : Variable.String.t
    ; where : Variable.String.t
    ; bullets : Variable.Bullets.t option [@sexp.option]
    }
  [@@deriving sexp]

  let eval flags t =
    { company = Variable.String.eval flags t.company
    ; title = Variable.String.eval flags t.title
    ; start = Variable.String.eval flags t.start
    ; until = Variable.String.eval flags t.until
    ; where = Variable.String.eval flags t.where
    ; bullets =
        (match t.bullets with
         | Some b -> Some (Variable.Bullets.eval flags b)
         | None -> None)
    }
  ;;
end
