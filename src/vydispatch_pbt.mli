
(** Code for vydispatch.proto *)

(* generated from "data/vydispatch.proto", do not edit *)



(** {2 Types} *)

type dispatch_init = {
  config_active : string option;
  config_proposed : string option;
  dry_run : bool option;
  atomic : bool option;
}

type dispatch_call = {
  script : string;
  tag_value : string option;
  arg_value : string option;
}

type dispatch =
  | Init of dispatch_init
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

type result = {
  error : error;
  output : string;
}


(** {2 Basic values} *)

val default_dispatch_init : 
  ?config_active:string option ->
  ?config_proposed:string option ->
  ?dry_run:bool option ->
  ?atomic:bool option ->
  unit ->
  dispatch_init
(** [default_dispatch_init ()] is the default value for type [dispatch_init] *)

val default_dispatch_call : 
  ?script:string ->
  ?tag_value:string option ->
  ?arg_value:string option ->
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

val default_result : 
  ?error:error ->
  ?output:string ->
  unit ->
  result
(** [default_result ()] is the default value for type [result] *)


(** {2 Formatters} *)

val pp_dispatch_init : Format.formatter -> dispatch_init -> unit 
(** [pp_dispatch_init v] formats v *)

val pp_dispatch_call : Format.formatter -> dispatch_call -> unit 
(** [pp_dispatch_call v] formats v *)

val pp_dispatch : Format.formatter -> dispatch -> unit 
(** [pp_dispatch v] formats v *)

val pp_dispatch_envelope : Format.formatter -> dispatch_envelope -> unit 
(** [pp_dispatch_envelope v] formats v *)

val pp_error : Format.formatter -> error -> unit 
(** [pp_error v] formats v *)

val pp_result : Format.formatter -> result -> unit 
(** [pp_result v] formats v *)


(** {2 Protobuf Encoding} *)

val encode_pb_dispatch_init : dispatch_init -> Pbrt.Encoder.t -> unit
(** [encode_pb_dispatch_init v encoder] encodes [v] with the given [encoder] *)

val encode_pb_dispatch_call : dispatch_call -> Pbrt.Encoder.t -> unit
(** [encode_pb_dispatch_call v encoder] encodes [v] with the given [encoder] *)

val encode_pb_dispatch : dispatch -> Pbrt.Encoder.t -> unit
(** [encode_pb_dispatch v encoder] encodes [v] with the given [encoder] *)

val encode_pb_dispatch_envelope : dispatch_envelope -> Pbrt.Encoder.t -> unit
(** [encode_pb_dispatch_envelope v encoder] encodes [v] with the given [encoder] *)

val encode_pb_error : error -> Pbrt.Encoder.t -> unit
(** [encode_pb_error v encoder] encodes [v] with the given [encoder] *)

val encode_pb_result : result -> Pbrt.Encoder.t -> unit
(** [encode_pb_result v encoder] encodes [v] with the given [encoder] *)


(** {2 Protobuf Decoding} *)

val decode_pb_dispatch_init : Pbrt.Decoder.t -> dispatch_init
(** [decode_pb_dispatch_init decoder] decodes a [dispatch_init] binary value from [decoder] *)

val decode_pb_dispatch_call : Pbrt.Decoder.t -> dispatch_call
(** [decode_pb_dispatch_call decoder] decodes a [dispatch_call] binary value from [decoder] *)

val decode_pb_dispatch : Pbrt.Decoder.t -> dispatch
(** [decode_pb_dispatch decoder] decodes a [dispatch] binary value from [decoder] *)

val decode_pb_dispatch_envelope : Pbrt.Decoder.t -> dispatch_envelope
(** [decode_pb_dispatch_envelope decoder] decodes a [dispatch_envelope] binary value from [decoder] *)

val decode_pb_error : Pbrt.Decoder.t -> error
(** [decode_pb_error decoder] decodes a [error] binary value from [decoder] *)

val decode_pb_result : Pbrt.Decoder.t -> result
(** [decode_pb_result decoder] decodes a [result] binary value from [decoder] *)
