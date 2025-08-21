module Profile = struct
  type t =
    { name : Variable.String.t
    ; website : Variable.String.t
    ; github : Variable.String.t
    ; phone : Variable.String.t
    ; email : Variable.String.t
    ; linkedin : Variable.String.t option [@sexp.option]
    }
  [@@deriving sexp]

  (* TODO: add LinkedIn option *)
  let eval flags t =
    { name = Variable.String.eval flags t.name
    ; website = Variable.String.eval flags t.website
    ; github = Variable.String.eval flags t.github
    ; phone = Variable.String.eval flags t.phone
    ; email = Variable.String.eval flags t.email
    ; linkedin =
        (match t.linkedin with
         | Some l -> Some (Variable.String.eval flags l)
         | None -> None)
    }
  ;;

  let typst_to_string _t = ""
end

module Margin = struct
  type t =
    { left : Variable.Integer.t
    ; right : Variable.Integer.t
    ; top : Variable.Integer.t
    ; bottom : Variable.Integer.t
    }
  [@@deriving sexp]

  let eval flags t =
    { left = Variable.Integer.eval flags t.left
    ; right = Variable.Integer.eval flags t.right
    ; top = Variable.Integer.eval flags t.top
    ; bottom = Variable.Integer.eval flags t.bottom
    }
  ;;

  let typst_to_string _t = ""
end

module T = struct
  type t =
    { profile : Profile.t
    ; template : Variable.Path.t
    ; margin : Margin.t
    ; justify : Literal.Boolean.t
    ; pagesize : Variable.String.t
    ; font : Variable.String.t
    }
  [@@deriving sexp]

  let eval flags t =
    { profile = Profile.eval flags t.profile
    ; template = Variable.Path.eval flags t.template
    ; margin = Margin.eval flags t.margin
    ; justify = Literal.Boolean.eval flags t.justify
    ; pagesize = Variable.String.eval flags t.pagesize
    ; font = Variable.String.eval flags t.font
    }
  ;;

  let typst_to_string _t = ""
end
