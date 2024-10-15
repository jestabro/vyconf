type op_t =
    | OpSetupSession
    | OpExists
    | OpTeardownSession
    | OpShowConfig
    | OpValidate

val session_init : ?out_format:string -> ?config_format:string -> string -> string Lwt.t

val session_free : string -> string -> string Lwt.t

val session_validate_path : string -> string -> string list -> string Lwt.t

val session_show_config : string -> string -> string list -> string Lwt.t

val session_path_exists : string -> string -> string list -> string Lwt.t
