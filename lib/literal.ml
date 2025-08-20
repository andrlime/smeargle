open Sexplib.Std

module ConfigValue = struct
  type t = string [@@deriving sexp]
end

module SectionName = struct
  type t = string [@@deriving sexp]
end

module Boolean = struct
  type t = bool [@@deriving sexp]
end
