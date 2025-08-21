val get_absolute_file_path : string -> string
val set_working_directory : string -> string
val read_file : Literal.Path.t -> string
val write_file : Literal.Path.t -> string -> unit
val lispify : string -> string
