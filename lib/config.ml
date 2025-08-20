module Profile = struct
  type t =
    { name : Variable.String.t
    ; website : Variable.String.t
    ; github : Variable.String.t
    ; phone : Variable.String.t
    ; email : Variable.String.t
    }
  [@@deriving sexp]

  let eval _flags t = t
end

module Margin = struct
  type t =
    { left : Variable.Integer.t
    ; right : Variable.Integer.t
    ; top : Variable.Integer.t
    ; bottom : Variable.Integer.t
    }
  [@@deriving sexp]

  let eval _flags t = t
end

module Output = struct
  type t = Typst of Variable.Path.t [@@deriving sexp]

  let eval _flags t = t
end

module T = struct
  type t =
    { profile : Profile.t
    ; template : Variable.Path.t
    ; margin : Margin.t
    ; justify : Literal.Boolean.t
    ; pagesize : Variable.String.t
    ; font : Variable.String.t
    ; output : Output.t
    }
  [@@deriving sexp]

  let create_config ~profile ~template ~margin ~justify ~pagesize ~font ~output =
    { profile; template; margin; justify; pagesize; font; output }
  ;;

  let eval flags t =
    create_config
      ~profile:(Profile.eval flags t.profile)
      ~template:(Variable.Path.eval flags t.template)
      ~margin:(Margin.eval flags t.margin)
      ~justify:(Literal.Boolean.eval flags t.justify)
      ~pagesize:(Variable.String.eval flags t.pagesize)
      ~font:(Variable.String.eval flags t.font)
      ~output:(Output.eval flags t.output)
  ;;
end
