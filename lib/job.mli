module T : sig
  type t = {
    company : Variable.String.t ;
    title : Variable.String.t ;
    start : Variable.String.t ;
    until : Variable.String.t ;
    where: Variable.String.t ;
    bullets : Variable.Bullets.t
  }

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end
