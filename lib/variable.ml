open Sexplib.Std

module Boolean = struct
  type t =
    | Flag of Literal.ConfigValue.t
    | And of t * t
    | Or of t * t
    | Xor of t * t
    | Not of t
    | Nand of t * t
  [@@deriving sexp]

  let rec eval flags t =
    match t with
    | Flag name -> Store.T.get_key flags name
    | And (a, b) -> eval flags a && eval flags b
    | Or (a, b) -> eval flags a || eval flags b
    | Xor (a, b) -> eval flags (Or (a, b)) && eval flags (Nand (a, b))
    | Not a -> not (eval flags a)
    | Nand (a, b) -> not (eval flags (And (a, b)))
  ;;

  let typst_to_string _ = failwith "cannot to_string a Literal.Boolean"
end

module Integer = struct
  type t =
    | Integer of int
    | If of Boolean.t * t * t
  [@@deriving sexp]

  let rec eval flags t =
    match t with
    | Integer i -> Integer i
    | If (cond, thn, els) ->
      if Boolean.eval flags cond then eval flags thn else eval flags els
  ;;

  let typst_to_string = function
    | If _ -> failwith "cannot have post eval If"
    | Integer i -> string_of_int i
  ;;
end

module Path = struct
  type t =
    | IPath of Literal.Path.t
    | OPath of Literal.Path.t
    | If of Boolean.t * t * t
  [@@deriving sexp]

  let[@inline] check_path_exists p =
    if p |> Sys.file_exists then p else failwith ("(Path " ^ p ^ "): path does not exist")
  ;;

  let rec eval flags t =
    match t with
    | IPath p -> IPath (check_path_exists p)
    | OPath p -> OPath p
    | If (cond, thn, els) ->
      if Boolean.eval flags cond then eval flags thn else eval flags els
  ;;

  let typst_to_string = function
    | IPath p | OPath p -> p
    | If _ -> failwith "cannot have If after eval"
  ;;
end

module String = struct
  type t =
    | String of string
    | If of Boolean.t * t * t
    | When of Boolean.t * t
    | TwoColumn of t * t
    | StringsList of Formatter.T.t list
  [@@deriving sexp]

  let rec eval flags t =
    match t with
    | If (cond, thn, els) ->
      if Boolean.eval flags cond then eval flags thn else eval flags els
    | When (cond, thn) -> When (cond, thn)
    | String s -> StringsList (Formatter.T.format s)
    | TwoColumn (l, r) -> TwoColumn (eval flags l, eval flags r)
    | StringsList _ -> failwith "top level StringsList not supported"
  ;;

  let rec typst_to_string = function
    | String _ | If _ | When _ ->
      failwith "unexpected String, If, When block in eval-ed AST"
    | TwoColumn (l, r) -> typst_to_string l ^ " + h(1fr) + " ^ typst_to_string r
    | StringsList list ->
      list
      |> Util.T.reverse_list
      |> List.filter Formatter.T.is_not_empty
      |> List.map Formatter.T.typst_to_string
      |> Stdlib.String.concat " + "
  ;;
end

module Bullets = struct
  type t = String.t list [@@deriving sexp]

  let eval flags t =
    t
    |> List.filter_map (fun node ->
      match node with
      | String.When (cond, thn) ->
        if Boolean.eval flags cond then Some (String.eval flags thn) else None
      | _ -> Some (String.eval flags node))
  ;;

  let typst_to_string t =
    t
    |> List.map String.typst_to_string
    |> List.map (fun b -> "text(" ^ b ^ ")")
    |> Stdlib.String.concat ",\n"
  ;;
end

module TagList = struct
  type t = Literal.ListTitle.t * Bullets.t [@@deriving sexp]

  let eval flags t =
    let title, bullets = t in
    Literal.ListTitle.eval flags title, Bullets.eval flags bullets
  ;;

  let typst_to_string t =
    let title, bullets = t in
    Printf.sprintf
      {|#tags(
  %s,
  (
    %s
  )
)|}
      (Literal.ListTitle.typst_to_string title)
      (Bullets.typst_to_string bullets)
  ;;
end
