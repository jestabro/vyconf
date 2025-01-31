
(** Code for vydispatch.proto *)

(* generated from "data/vydispatch.proto", do not edit *)



(** {2 Types} *)

type dispatch_initialization = {
  config_active : string option;
  config_proposed : string option;
  dry_run : bool option;
  atomic : bool option;
}

type dispatch_call = {
  script : string;
  tag_value : string option;
  arg : string option;
}

type dispatch =
  | Initialization of dispatch_initialization
  | Call of dispatch_call

type dispatch_envelope = {
  token : int32;
  dispatch : dispatch;
}

type error =
  | Success 
  | Config_error 
  | Daemon_error 
  | Pass_through 

type command = {
  node : string list;
}

type commands = {
  cmd : command list;
}

type result = {
  error : error;
  output : string;
  set : commands option;
  delete : commands option;
}


(** {2 Basic values} *)

val default_dispatch_initialization : 
  ?config_active:string option ->
  ?config_proposed:string option ->
  ?dry_run:bool option ->
  ?atomic:bool option ->
  unit ->
  dispatch_initialization
(** [default_dispatch_initialization ()] is the default value for type [dispatch_initialization] *)

val default_dispatch_call : 
  ?script:string ->
  ?tag_value:string option ->
  ?arg:string option ->
  unit ->
  dispatch_call
(** [default_dispatch_call ()] is the default value for type [dispatch_call] *)

val default_dispatch : unit -> dispatch
(** [default_dispatch ()] is the default value for type [dispatch] *)

val default_dispatch_envelope : 
  ?token:int32 ->
  ?dispatch:dispatch ->
  unit ->
  dispatch_envelope
(** [default_dispatch_envelope ()] is the default value for type [dispatch_envelope] *)

val default_error : unit -> error
(** [default_error ()] is the default value for type [error] *)

val default_command : 
  ?node:string list ->
  unit ->
  command
(** [default_command ()] is the default value for type [command] *)

val default_commands : 
  ?cmd:command list ->
  unit ->
  commands
(** [default_commands ()] is the default value for type [commands] *)

val default_result : 
  ?error:error ->
  ?output:string ->
  ?set:commands option ->
  ?delete:commands option ->
  unit ->
  result
(** [default_result ()] is the default value for type [result] *)


(** {2 Formatters} *)

val pp_dispatch_initialization : Format.formatter -> dispatch_initialization -> unit 
(** [pp_dispatch_initialization v] formats v *)

val pp_dispatch_call : Format.formatter -> dispatch_call -> unit 
(** [pp_dispatch_call v] formats v *)

val pp_dispatch : Format.formatter -> dispatch -> unit 
(** [pp_dispatch v] formats v *)

val pp_dispatch_envelope : Format.formatter -> dispatch_envelope -> unit 
(** [pp_dispatch_envelope v] formats v *)

val pp_error : Format.formatter -> error -> unit 
(** [pp_error v] formats v *)

val pp_command : Format.formatter -> command -> unit 
(** [pp_command v] formats v *)

val pp_commands : Format.formatter -> commands -> unit 
(** [pp_commands v] formats v *)

val pp_result : Format.formatter -> result -> unit 
(** [pp_result v] formats v *)


(** {2 Protobuf Encoding} *)

val encode_pb_dispatch_initialization : dispatch_initialization -> Pbrt.Encoder.t -> unit
(** [encode_pb_dispatch_initialization v encoder] encodes [v] with the given [encoder] *)

val encode_pb_dispatch_call : dispatch_call -> Pbrt.Encoder.t -> unit
(** [encode_pb_dispatch_call v encoder] encodes [v] with the given [encoder] *)

val encode_pb_dispatch : dispatch -> Pbrt.Encoder.t -> unit
(** [encode_pb_dispatch v encoder] encodes [v] with the given [encoder] *)

val encode_pb_dispatch_envelope : dispatch_envelope -> Pbrt.Encoder.t -> unit
(** [encode_pb_dispatch_envelope v encoder] encodes [v] with the given [encoder] *)

val encode_pb_error : error -> Pbrt.Encoder.t -> unit
(** [encode_pb_error v encoder] encodes [v] with the given [encoder] *)

val encode_pb_command : command -> Pbrt.Encoder.t -> unit
(** [encode_pb_command v encoder] encodes [v] with the given [encoder] *)

val encode_pb_commands : commands -> Pbrt.Encoder.t -> unit
(** [encode_pb_commands v encoder] encodes [v] with the given [encoder] *)

val encode_pb_result : result -> Pbrt.Encoder.t -> unit
(** [encode_pb_result v encoder] encodes [v] with the given [encoder] *)


(** {2 Protobuf Decoding} *)

val decode_pb_dispatch_initialization : Pbrt.Decoder.t -> dispatch_initialization
(** [decode_pb_dispatch_initialization decoder] decodes a [dispatch_initialization] binary value from [decoder] *)

val decode_pb_dispatch_call : Pbrt.Decoder.t -> dispatch_call
(** [decode_pb_dispatch_call decoder] decodes a [dispatch_call] binary value from [decoder] *)

val decode_pb_dispatch : Pbrt.Decoder.t -> dispatch
(** [decode_pb_dispatch decoder] decodes a [dispatch] binary value from [decoder] *)

val decode_pb_dispatch_envelope : Pbrt.Decoder.t -> dispatch_envelope
(** [decode_pb_dispatch_envelope decoder] decodes a [dispatch_envelope] binary value from [decoder] *)

val decode_pb_error : Pbrt.Decoder.t -> error
(** [decode_pb_error decoder] decodes a [error] binary value from [decoder] *)

val decode_pb_command : Pbrt.Decoder.t -> command
(** [decode_pb_command decoder] decodes a [command] binary value from [decoder] *)

val decode_pb_commands : Pbrt.Decoder.t -> commands
(** [decode_pb_commands decoder] decodes a [commands] binary value from [decoder] *)

val decode_pb_result : Pbrt.Decoder.t -> result
(** [decode_pb_result decoder] decodes a [result] binary value from [decoder] *)
