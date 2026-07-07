open Sexplib.Std

module T = struct
  type style =
    | Bold
    | Italics
    | Raw
  [@@deriving sexp]

  (* A run of text with every style block open around it, outermost first *)
  type t = Styled of style list * Literal.String.t [@@deriving sexp]

  let style_of_char = function
    | '*' -> Bold
    | '_' -> Italics
    | '`' -> Raw
    | ch -> failwith (Printf.sprintf "char %c is not a formatting character" ch)
  ;;

  let[@inline] start_block ch stack = Stack.push ch stack
  let[@inline] in_raw_block stack = Stack.length stack > 0 && Stack.top stack = '`'

  let[@inline] should_start_block stack ch =
    (not (in_raw_block stack))
    &&
    match ch with
    | '*' | '_' | '`' -> true
    | _ -> false
  ;;

  let[@inline] end_block stack = Stack.pop stack |> ignore
  let[@inline] should_end_block stack ch = Stack.length stack > 0 && ch = Stack.top stack
  let[@inline] get_first_char str = String.get str 0
  let[@inline] remove_first_char str = String.sub str 1 (String.length str - 1)

  (* Outermost style first: the bottom of the stack was opened first *)
  let[@inline] open_styles stack =
    Stack.fold (fun acc ch -> style_of_char ch :: acc) [] stack
  ;;

  (*
     Bold: *string*
    Italics: _string_
    Raw/tt: `string`

    Styles nest, like *_thing_*; inside `raw` every character is literal.

    TODO: Support escape sequences

    Returns in reverse order
  *)
  let format s =
    let (stack : char Stack.t) = Stack.create () in
    let rec traverse str cur acc =
      if str = ""
      then Styled (open_styles stack, cur) :: acc
      else (
        let firstchar = get_first_char str in
        let reststr = remove_first_char str in
        if should_end_block stack firstchar
        then (
          let styled = Styled (open_styles stack, cur) in
          end_block stack;
          traverse reststr "" (styled :: acc))
        else if should_start_block stack firstchar
        then (
          let styled = Styled (open_styles stack, cur) in
          start_block firstchar stack;
          traverse reststr "" (styled :: acc))
        else (
          let concatstr = cur ^ String.make 1 firstchar in
          traverse reststr concatstr acc))
    in
    traverse s "" []
  ;;

  let is_not_empty (Styled (_, s)) = s <> ""

  let typst_to_string (Styled (styles, s)) =
    List.fold_right
      (fun style inner ->
         match style with
         | Bold -> Printf.sprintf {|strong(%s)|} inner
         | Italics -> Printf.sprintf {|emph(%s)|} inner
         | Raw -> Printf.sprintf {|raw(%s)|} inner)
      styles
      (Printf.sprintf {|"%s"|} s)
  ;;
end
