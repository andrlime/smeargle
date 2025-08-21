open Sexplib.Std

module String = struct
  type t = string [@@deriving sexp]

  let eval _ t = t
end

module Path = struct
  type t = string [@@deriving sexp]

  let eval _ t = t
end

module ConfigValue = struct
  type t = string [@@deriving sexp]

  let eval _ t = t
end

module SectionName = struct
  type t = string [@@deriving sexp]

  let eval _ t = t
end

module Boolean = struct
  type t = bool [@@deriving sexp]

  let eval _ t = t
end
