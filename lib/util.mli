(* Some generic utils *)
module T : sig
  val is_not_space : char -> bool
  val quote : string -> string
  val unquote : string -> string
  val get_current_date : unit -> string
  val reverse_list : 'a list -> 'a list
end
