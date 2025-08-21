module T : sig
  type state =
    { ast : Ast.T.t
    ; flags : Literal.Boolean.t Store.T.t
    ; output : Output.T.t
    }

  val create_state : Ast.T.t -> state

  (* Gets flags from env or default value, checks paths, sanity checks *)
  val preprocess : state -> state

  (* Uses flags to flatten the AST *)
  val simplify : state -> state
  val get_ast : state -> Ast.T.t

  (* Entry point to evaluator *)
  val evaluate : Ast.T.t -> state
end
