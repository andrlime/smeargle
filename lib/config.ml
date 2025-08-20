module Profile = struct
  type t =
    { name : Variable.String.t
    ; website : Variable.String.t
    ; github : Variable.String.t
    ; phone : Variable.String.t
    ; email : Variable.String.t
    }
  [@@deriving sexp]
end

module Margin = struct
  type t =
    { left : Variable.Integer.t
    ; right : Variable.Integer.t
    ; top : Variable.Integer.t
    ; bottom : Variable.Integer.t
    }
  [@@deriving sexp]
end

module Output = struct
  type t = Typst of Variable.Path.t [@@deriving sexp]
end

module T = struct
  type t =
    { profile : Profile.t
    ; template : Variable.String.t
    ; margin : Margin.t
    ; justify : Literal.Boolean.t
    ; pagesize : Variable.String.t
    ; font : Variable.String.t
    ; output : Output.t
    }
  [@@deriving sexp]
end
