let main path =
  path
  |> Io.set_working_directory
  |> Io.read_file
  |> Io.lispify
  |> Ast.T.of_string
  |> Eval.T.evaluate
  |> Codegen.T.emit_and_compile
  |> function
  | 0 -> ()
  | _ -> failwith "failed"
;;
