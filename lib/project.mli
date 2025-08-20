module T : sig
  type t = {
    title : Variable.String.t ;
    start : Variable.String.t ;
    until : Variable.String.t ;
    bullets : Variable.Bullets.t ;
    organisation : Variable.String.t option ;
  }

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end
