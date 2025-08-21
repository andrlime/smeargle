module T = struct
  type t =
    | Unformatted of Literal.String.t
    | Bold of Literal.String.t
    | Italics of Literal.String.t
  [@@deriving sexp]

  let create_t ~typ:fmt str =
    match fmt with
    | '*' -> Bold str
    | '_' -> Italics str
    | _ -> Unformatted str
  ;;

  let[@inline] start_block ch stack = Stack.push ch stack

  let[@inline] should_start_block ch =
    match ch with
    | '*' | '_' -> true
    | _ -> false
  ;;

  let[@inline] end_block stack = Stack.pop stack |> ignore
  let[@inline] should_end_block stack ch = Stack.length stack > 0 && ch = Stack.top stack
  let[@inline] get_first_char str = String.get str 0
  let[@inline] remove_first_char str = String.sub str 1 (String.length str - 1)

  (*
     Bold: *string*
    Italics: _string_

    TODO: Support escape sequences
    TODO: Support stacking, like *_thing_*

    Returns in reverse order
  *)
  let format s =
    let (stack : char Stack.t) = Stack.create () in
    let unformatted = ' ' in
    let rec traverse str stack cur acc =
      if str = ""
      then create_t ~typ:unformatted cur :: acc
      else (
        let firstchar = get_first_char str in
        let reststr = remove_first_char str in
        if should_end_block stack firstchar
        then (
          end_block stack;
          traverse reststr stack "" (create_t ~typ:firstchar cur :: acc))
        else if should_start_block firstchar
        then (
          start_block firstchar stack;
          traverse reststr stack "" (create_t ~typ:unformatted cur :: acc))
        else (
          let concatstr = cur ^ String.make 1 firstchar in
          traverse reststr stack concatstr acc))
    in
    traverse s stack "" []
  ;;
end
