open Smeargle
open Cmdliner

let version = "1.0b"
let smeargle_process_file file = file |> Entry_point.main

let input_file_arg =
  let doc = "The file to compile, provided via --input or -i." in
  Arg.(required & opt (some file) None & info [ "i"; "input" ] ~docv:"PATH" ~doc)
;;

let main_cmd =
  let term = Term.(const smeargle_process_file $ input_file_arg) in
  Cmd.v (Cmd.info "smeargle" ~version) term
;;

let main () = Cmd.eval main_cmd
let () = if !Sys.interactive then () else exit (main ())
