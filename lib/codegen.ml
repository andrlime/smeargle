module TypstGenerator = struct
  let to_string ast =
    let open Ast.AstNode in
    ast
    |> List.map (function
      | Output _ -> ""
      | Config cfg -> Config.T.typst_to_string cfg
      | Section sec -> Literal.SectionName.typst_to_string sec
      | School schl -> School.T.typst_to_string schl
      | List (title, bullets) ->
        Printf.sprintf
          {|#tags(
            "%s",
            (
              %s
            )
          )|}
          (Literal.SectionName.typst_to_string title)
          (Variable.Bullets.typst_to_string bullets)
      | Job j -> Job.T.typst_to_string j
      | Project proj -> Project.T.typst_to_string proj
      | Award awrd -> Award.T.typst_to_string awrd
      | Flag _ -> failwith "should not have fail in eval-ed AST"
      | If _ -> "should not have if in eval-ed AST"
      | When _ -> failwith "should not have when in eval-ed AST")
    |> String.concat "\n"
  ;;
end

module T = struct
  let emit (state : Eval.T.state) =
    match state.output with
    | Output.T.Typst path -> TypstGenerator.to_string state.ast, path
    | Output.T.None -> "", Variable.Path.OPath ""
  ;;

  let compile (_prgm, _path) = "ERROR 1"
  let emit_and_compile ast = ast |> emit |> compile
end
