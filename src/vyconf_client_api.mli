type op_t =
    | OpSetupSession
    | OpTeardownSession
    | OpShowConfig
    | OpValidate

val session_init : ?out_format:string -> ?config_format:string -> string -> (string, string) result Lwt.t

val session_free : string -> (string, string) result Lwt.t

val session_validate_path : string -> string list -> (string, string) result Lwt.t
