module Profile = struct
  type t =
    { name : Variable.String.t
    ; website : Variable.String.t
    ; phone : Variable.String.t
    ; email : Variable.String.t
    ; github : Variable.String.t option [@sexp.option]
    ; linkedin : Variable.String.t option [@sexp.option]
    }
  [@@deriving sexp]

  (* TODO: add LinkedIn option *)
  let eval flags t =
    { name = Variable.String.eval flags t.name
    ; website = Variable.String.eval flags t.website
    ; phone = Variable.String.eval flags t.phone
    ; email = Variable.String.eval flags t.email
    ; github =
        (match t.github with
         | Some g -> Some (Variable.String.eval flags g)
         | None -> None)
    ; linkedin =
        (match t.linkedin with
         | Some l -> Some (Variable.String.eval flags l)
         | None -> None)
    }
  ;;

  let typst_to_string t =
    Printf.sprintf
      {|#profile(
  %s,
  %s,
  %s,
  %s,
  %s)|}
      (Variable.String.typst_to_string t.name)
      (Variable.String.typst_to_string t.website)
      (Variable.String.typst_to_string t.phone)
      (Variable.String.typst_to_string t.email)
      (match t.github with
        | Some g -> (Variable.String.typst_to_string g)
        | None -> "")
  ;;
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

  let typst_to_string t =
    Printf.sprintf
      {|(left: %spt, right: %spt, top: %spt, bottom: %spt)|}
      (Variable.Integer.typst_to_string t.left)
      (Variable.Integer.typst_to_string t.right)
      (Variable.Integer.typst_to_string t.top)
      (Variable.Integer.typst_to_string t.bottom)
  ;;
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

  let typst_to_string t =
    Printf.sprintf
      {|
#import "%s": *
#set page(margin: %s, columns: 1)
#set page(%s)
#set par(justify: %s)
#set text(font: %s)

%s
|}
      (Variable.Path.typst_to_string t.template)
      (Margin.typst_to_string t.margin)
      (Variable.String.typst_to_string t.pagesize)
      (Literal.Boolean.typst_to_string t.justify)
      (Variable.String.typst_to_string t.font)
      (Profile.typst_to_string t.profile)
  ;;
end
