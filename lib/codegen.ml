module TypstGenerator = struct
  let to_string ast =
    let open Ast.AstNode in
    ast
    |> List.map (function
      | Output _ -> ""
      | Config cfg -> Config.T.typst_to_string cfg
      | Section sec -> Literal.SectionName.typst_to_string sec
      | School schl -> School.T.typst_to_string schl
      | List (title, bullets) -> Variable.TagList.typst_to_string (title, bullets)
      | Job j -> Job.T.typst_to_string j
      | Project proj -> Project.T.typst_to_string proj
      | Award awrd -> Award.T.typst_to_string awrd
      | Flag _ -> failwith "should not have fail in eval-ed AST"
      | If _ -> "should not have if in eval-ed AST"
      | When _ -> failwith "should not have when in eval-ed AST")
    |> String.concat "\n"
    |> String.trim
  ;;
end

module TypstTranspiler = struct
  let command ~input ~output = Printf.sprintf "typst compile %s %s" input output

  let compile (path, program) =
    let temppath = "./" ^ "tmp.typ" in
    Io.write_file temppath program;
    let result = Sys.command @@ command ~input:temppath ~output:path in
    Sys.remove temppath;
    result
  ;;
end

module T = struct
  type t =
    | TypstCompiler of string * string
    | NoCompiler

  let emit (state : Eval.T.state) =
    match state.output with
    | Output.T.Typst path ->
      TypstCompiler
        (Variable.Path.typst_to_string path, TypstGenerator.to_string state.ast)
    | Output.T.None -> NoCompiler
  ;;

  let compile = function
    | TypstCompiler (path, program) -> TypstTranspiler.compile (path, program)
    | NoCompiler -> 0
  ;;

  let emit_and_compile ast = ast |> emit |> compile
end
