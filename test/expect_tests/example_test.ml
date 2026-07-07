open Smeargle

let format_to_typst s =
  Formatter.T.format s
  |> Util.T.reverse_list
  |> List.filter Formatter.T.is_not_empty
  |> List.map Formatter.T.typst_to_string
  |> String.concat " + "
  |> print_endline
;;

let%expect_test "formats bold, italics, and backticks" =
  format_to_typst "plain *bold* _italic_ `raw`";
  [%expect {| "plain " + strong("bold") + " " + emph("italic") + " " + raw("raw") |}]
;;

let%expect_test "formatting characters inside backticks are literal" =
  format_to_typst "handling over `io_uring`.";
  [%expect {| "handling over " + raw("io_uring") + "." |}]
;;

let%expect_test "asterisks inside backticks are literal" =
  format_to_typst "deref `*ptr` here";
  [%expect {| "deref " + raw("*ptr") + " here" |}]
;;

let%expect_test "styles nest" =
  format_to_typst "*_thing_*";
  [%expect {| strong(emph("thing")) |}]
;;

let%expect_test "nested styles apply to surrounding text" =
  format_to_typst "*bold _both_ bold again* plain";
  [%expect
    {| strong("bold ") + strong(emph("both")) + strong(" bold again") + " plain" |}]
;;

let%expect_test "raw nests inside other styles and stays literal" =
  format_to_typst "*uses `io_uring` inside*";
  [%expect {| strong("uses ") + strong(raw("io_uring")) + strong(" inside") |}]
;;
