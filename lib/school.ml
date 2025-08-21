open Sexplib.Std

module Degree = struct
  type t =
    | Degree of
        { title : Variable.String.t
        ; major : Variable.String.t
        ; note : Variable.String.t option [@sexp.option]
        }
  [@@deriving sexp]

  let eval flags t =
    match t with
    | Degree d ->
      Degree
        { title = Variable.String.eval flags d.title
        ; major = Variable.String.eval flags d.major
        ; note =
            (match d.note with
             | Some n -> Some (Variable.String.eval flags n)
             | None -> None)
        }
  ;;
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

  let eval flags t =
    { name = Variable.String.eval flags t.name
    ; start = Variable.String.eval flags t.start
    ; until = Variable.String.eval flags t.until
    ; degrees = t.degrees |> List.map (Degree.eval flags)
    ; where = Variable.String.eval flags t.where
    ; gpa =
        (match t.gpa with
         | Some g -> Some (Variable.String.eval flags g)
         | None -> None)
    }
  ;;
end
