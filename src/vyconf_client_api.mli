type op_t =
    | OpSetupSession
    | OpTeardownSession
    | OpShowConfig
    | OpValidate

val session_init : ?out_format:string -> ?config_format:string -> unit -> string

val session_free : string -> string

val session_validate_path : string -> string list -> string

val session_show_config : string -> string list -> string
