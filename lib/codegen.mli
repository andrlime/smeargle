module TypstGenerator : sig
  val to_string : Ast.T.t -> string
end

module T : sig
  type t =
    | TypstCompiler of string * string
    | NoCompiler

  val emit : Eval.T.state -> t
  val compile : t -> int
  val emit_and_compile : Eval.T.state -> int
end

module TypstTranspiler : sig
  val compile : string * string -> int
end
