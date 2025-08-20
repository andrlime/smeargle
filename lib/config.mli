module Profile : sig
  type t = {
    name : Variable.String.t ;
    website : Variable.String.t ;
    github : Variable.String.t ;
    phone : Variable.String.t ;
    email : Variable.String.t ;
  }
  
  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end

module Margin : sig
  type t = {
    left : Variable.Integer.t ;
    right : Variable.Integer.t ;
    top : Variable.Integer.t ;
    bottom : Variable.Integer.t ;
  }
  
  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end

module Output : sig
  type t = 
    | Typst of Variable.String.t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end

module T : sig
  type t = {
    profile : Profile.t ;
    template : Variable.String.t ;
    margin: Margin.t ;
    pagesize : Variable.String.t ;
    font : Variable.String.t ;
    output : Output.t
  }

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end
