open Sexplib.Std

module String = struct
  type t = string [@@deriving sexp]

  let eval _ t = t
  let typst_to_string t = t
end

module Path = struct
  type t = string [@@deriving sexp]

  let eval _ t = t
  let typst_to_string t = t
end

module ConfigValue = struct
  type t = string [@@deriving sexp]

  let eval _ t = t
  let typst_to_string t = t
end

module ListTitle = struct
  type t = string [@@deriving sexp]

  let eval _ t = t
  let typst_to_string t = Printf.sprintf {|"%s"|} t
end

module SectionName = struct
  type t = string [@@deriving sexp]

  let eval _ t = t
  let typst_to_string t = Printf.sprintf {|#section("%s")|} t
end

module Boolean = struct
  type t = bool [@@deriving sexp]

  let eval _ t = t
  let typst_to_string t = string_of_bool t
end
