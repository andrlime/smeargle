module T : sig
  type t = {
    title : Variable.String.t ;
    organisation : Variable.String.t 
  }
  
  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end
