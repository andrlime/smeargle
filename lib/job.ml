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

  let typst_to_string t =
    match t.bullets with
    | Some bullets ->
      Printf.sprintf
        {|#job(
    %s,
    (
        (
            %s,
            %s,
            %s,
            (
                %s,
            )
        ),
    )
)|}
        (Variable.String.typst_to_string t.company)
        (Variable.String.typst_to_string t.title)
        (Variable.String.typst_to_string t.start
         ^ {| + " – " + |}
         ^ Variable.String.typst_to_string t.until)
        (Variable.String.typst_to_string t.where)
        (Variable.Bullets.typst_to_string bullets)
    | None ->
      Printf.sprintf
        {|#futurejob(
    %s,
    (
        (
            %s,
            %s,
            %s,
        ),
    )
)|}
        (Variable.String.typst_to_string t.company)
        (Variable.String.typst_to_string t.title)
        (Variable.String.typst_to_string t.start
         ^ {| + " – " + |}
         ^ Variable.String.typst_to_string t.until)
        (Variable.String.typst_to_string t.where)
  ;;
end
