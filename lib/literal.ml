open Sexplib.Std

module Path = struct
  type t = string [@@deriving sexp]
end

module ConfigValue = struct
  type t = string [@@deriving sexp]
end

module SectionName = struct
  type t = string [@@deriving sexp]
end

module Boolean = struct
  type t = bool [@@deriving sexp]
end
