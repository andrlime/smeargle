module T = struct
  type t =
    { title : Variable.String.t
    ; start : Variable.String.t
    ; until : Variable.String.t
    ; bullets : Variable.Bullets.t
    ; organisation : Variable.String.t option [@sexp.option]
    }
  [@@deriving sexp]

  let eval flags t =
    { title = Variable.String.eval flags t.title
    ; start = Variable.String.eval flags t.start
    ; until = Variable.String.eval flags t.until
    ; bullets = Variable.Bullets.eval flags t.bullets
    ; organisation =
        (match t.organisation with
         | Some o -> Some (Variable.String.eval flags o)
         | None -> None)
    }
  ;;
end
