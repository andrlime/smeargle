let main path =
  path
  |> Io.get_absolute_file_path
  |> Io.read_file
  |> Io.lispify
  |> Ast.T.of_string
  |> Ast.T.to_string
  |> print_endline
;;
