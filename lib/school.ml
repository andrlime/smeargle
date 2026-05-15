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
           {|%s + ", " + %s + " (" + %s + ")"|}
           (Variable.String.typst_to_string d.major)
           (Variable.String.typst_to_string d.title)
           (Variable.String.typst_to_string n)
       | None ->
         Printf.sprintf
           {|%s + ", " + %s|}
           (Variable.String.typst_to_string d.major)
           (Variable.String.typst_to_string d.title))
  ;;
end

module T = struct
  type t =
    { name : Variable.String.t
    ; start : Variable.String.t option [@sexp.option]
    ; until : Variable.String.t
    ; degrees : Degree.t list
    ; where : Variable.String.t
    ; gpa : Variable.String.t option [@sexp.option]
    }
  [@@deriving sexp]

  let eval flags t =
    { name = Variable.String.eval flags t.name
    ; until = Variable.String.eval flags t.until
    ; degrees = t.degrees |> List.map (Degree.eval flags)
    ; where = Variable.String.eval flags t.where
    ; start =
        (match t.start with
         | Some s -> Some (Variable.String.eval flags s)
         | None -> None)
    ; gpa =
        (match t.gpa with
         | Some g -> Some (Variable.String.eval flags g)
         | None -> None)
    }
  ;;

  let format_date t =
    match t.start with
    | Some s ->
      Variable.String.typst_to_string s
      ^ {| + " – " + |}
      ^ Variable.String.typst_to_string t.until
    | None -> Variable.String.typst_to_string t.until
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
      (format_date t)
      degrees_string
      (Variable.String.typst_to_string t.where)
      (match t.gpa with
       | Some g -> Variable.String.typst_to_string g
       | _ -> {|""|})
  ;;
end
