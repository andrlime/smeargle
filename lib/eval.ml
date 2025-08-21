module T = struct
  type state =
    { ast : Ast.T.t
    ; flags : Flags.T.t
    ; output : Output.T.t
    }

  let create_state ast = { ast; flags = Store.T.create (); output = Output.T.None }

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
    | Output out -> Some (Output (Output.T.eval state.flags out))
    | Config cfg -> Some (Config (Config.T.eval state.flags cfg))
    | Section sec -> Some (Section (Literal.SectionName.eval state.flags sec))
    | School schl -> Some (School (School.T.eval state.flags schl))
    | List (title, bullets) ->
      let newtitle, newbullets = Variable.TagList.eval state.flags (title, bullets) in
      Some (List (newtitle, newbullets))
    | Job j -> Some (Job (Job.T.eval state.flags j))
    | Project proj -> Some (Project (Project.T.eval state.flags proj))
    | Award awrd -> Some (Award (Award.T.eval state.flags awrd))
    | If (whn, thn, els) ->
      if Variable.Boolean.eval state.flags whn then eval state thn else eval state els
    | When (cond, node) ->
      if Variable.Boolean.eval state.flags cond then eval state node else None
  ;;

  let get_output ast =
    ast
    |> List.filter (function
      | Ast.AstNode.Output _ -> true
      | _ -> false)
    |> List.hd
    |> function
    | Ast.AstNode.Output output -> output
    | _ -> failwith "impossible"
  ;;

  let preprocess t =
    let curflags = t.flags in
    let newast = t.ast |> List.filter_map (eval t) in
    { ast = newast; flags = curflags; output = get_output newast }
  ;;

  let simplify t = t
  let get_ast t = t.ast
  let evaluate t = t |> create_state |> preprocess
end
