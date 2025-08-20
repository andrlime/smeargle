module T = struct
  type state =
    { ast : Ast.T.t
    ; flags : Flags.T.t
    }

  let create_state ast = { ast; flags = Store.T.create () }

  let truthy value =
    match String.lowercase_ascii value with
    | "false" -> false
    | "true" -> true
    | _ -> failwith "invalid boolean"
  ;;

  let eval_flag flags (name, default) =
    try
      Sys.getenv name |> truthy |> Store.T.set_key flags name;
      Ast.AstNode.Flag (name, default)
    with
    | Not_found ->
      Store.T.set_key flags name default;
      Ast.AstNode.Flag (name, default)
  ;;

  let rec eval state node =
    let open Ast.AstNode in
    match node with
    | Flag (name, default) ->
      eval_flag state.flags (name, default) |> ignore;
      None
    | Config cfg -> Some (Config (Config.T.eval state.flags cfg))
    | Section sec -> Some (Section (Literal.SectionName.eval state.flags sec))
    | School schl -> Some (School (School.T.eval state.flags schl))
    | List (title, bullets) ->
      Some (List (title, Variable.Bullets.eval state.flags bullets))
    | Job j -> Some (Job (Job.T.eval state.flags j))
    | Project proj -> Some (Project (Project.T.eval state.flags proj))
    | Award awrd -> Some (Award (Award.T.eval state.flags awrd))
    | If (whn, thn, els) ->
      if Variable.Boolean.eval state.flags whn then eval state thn else eval state els
    | When (cond, node) ->
      if Variable.Boolean.eval state.flags cond then eval state node else None
  ;;

  let preprocess t =
    let curflags = t.flags in
    let newast = t.ast |> List.filter_map (eval t) in
    { ast = newast; flags = curflags }
  ;;

  let simplify t = t
  let get_ast t = t.ast
  let evaluate t = t |> create_state |> preprocess |> get_ast
end
