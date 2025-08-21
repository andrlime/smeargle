module T = struct
  type t =
    | Unformatted of Literal.String.t
    | Bold of Literal.String.t
    | Italics of Literal.String.t
  [@@deriving sexp]

  let create_t fmt str =
    match fmt with
    | '*' -> Bold str
    | '_' -> Italics str
    | _ -> Unformatted str
  ;;

  let[@inline] should_start_block ch =
    match ch with
    | '*' | '_' -> true
    | _ -> false
  ;;

  let[@inline] should_end_block stack ch = Stack.length stack > 0 && ch = Stack.top stack
  let[@inline] get_first_char str = String.get str 0
  let[@inline] remove_first_char str = String.sub str 1 (String.length str - 1)

  (*
     Bold: *string*
    Italics: _string_
    Bold-italics: *_string_*
    Can stack them and whatnot

    *_string*_ will lead to undefined behavior (what's the point?)
    Realistically, it will give * and then italicised string*

    TODO: Support escape sequences

    Returns in reverse order
  *)
  let format s =
    let (stack : char Stack.t) = Stack.create () in
    let rec traverse str stack cur acc =
      if str = ""
      then create_t ' ' cur :: acc
      else (
        let firstchar = get_first_char str in
        let reststr = remove_first_char str in
        if should_end_block stack firstchar
        then (
          Stack.pop stack |> ignore;
          traverse reststr stack "" (create_t firstchar cur :: acc))
        else if should_start_block firstchar
        then (
          Stack.push firstchar stack;
          traverse reststr stack "" (create_t ' ' cur :: acc))
        else (
          let concatstr = cur ^ String.make 1 firstchar in
          traverse reststr stack concatstr acc))
    in
    traverse s stack "" []
  ;;
end
