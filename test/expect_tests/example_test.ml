(* open Smeargle *)

let%expect_test "3+3=6" =
  3 + 3 |> string_of_int |> print_endline;
  [%expect {|6|}]
;;
