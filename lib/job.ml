module T = struct
  type t = {
    company : Variable.String.t ;
    title : Variable.String.t ;
    start : Variable.String.t ;
    until : Variable.String.t ;
    where: Variable.String.t ;
    bullets : Variable.Bullets.t
  } [@@deriving sexp]
end
