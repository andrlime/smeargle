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

  let typst_to_string t =
    match t with
    | Degree d ->
      (match d.note with
       | Some n ->
         Printf.sprintf
           {|%s + " in " + %s + " (" + %s + ")"|}
           (Variable.String.typst_to_string d.title)
           (Variable.String.typst_to_string d.major)
           (Variable.String.typst_to_string n)
       | None ->
         Printf.sprintf
           {|%s + " in " + %s|}
           (Variable.String.typst_to_string d.title)
           (Variable.String.typst_to_string d.major))
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

  let typst_to_string t =
    let degrees_string =
      match List.length t.degrees with
      | 0 -> {|""|}
      | _ -> t.degrees |> List.map Degree.typst_to_string |> String.concat {| + "; " + |}
    in
    Printf.sprintf
      {|#school(
    %s,
    %s,
    %s,
    %s,
    %s,
)|}
      (Variable.String.typst_to_string t.name)
      (Variable.String.typst_to_string t.until)
      degrees_string
      (Variable.String.typst_to_string t.where)
      (match t.gpa with
       | Some g -> Variable.String.typst_to_string g
       | _ -> {|""|})
  ;;
end
