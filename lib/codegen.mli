module TypstGenerator : sig
  val to_string : Ast.T.t -> string
end

module T : sig
  val emit : Eval.T.state -> string * Variable.Path.t
  val compile : string * Variable.Path.t -> string
  val emit_and_compile : Eval.T.state -> string
end
