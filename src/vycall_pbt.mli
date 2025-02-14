
(** Code for vycall.proto *)

(* generated from "data/vycall.proto", do not edit *)



(** {2 Types} *)

type error =
  | Success 
  | Config_error 
  | Daemon_error 
  | Background 

type reply = {
  error : error;
  out : string;
}

type call = {
  script_name : string;
  tag_value : string option;
  arg_value : string option;
  reply : reply option;
}

type commit = {
  session_id : string;
  named_active : string option;
  named_proposed : string option;
  dry_run : bool;
  atomic : bool;
  background : bool;
  calls : call list;
}


(** {2 Basic values} *)

val default_error : unit -> error
(** [default_error ()] is the default value for type [error] *)

val default_reply : 
  ?error:error ->
  ?out:string ->
  unit ->
  reply
(** [default_reply ()] is the default value for type [reply] *)

val default_call : 
  ?script_name:string ->
  ?tag_value:string option ->
  ?arg_value:string option ->
  ?reply:reply option ->
  unit ->
  call
(** [default_call ()] is the default value for type [call] *)

val default_commit : 
  ?session_id:string ->
  ?named_active:string option ->
  ?named_proposed:string option ->
  ?dry_run:bool ->
  ?atomic:bool ->
  ?background:bool ->
  ?calls:call list ->
  unit ->
  commit
(** [default_commit ()] is the default value for type [commit] *)


(** {2 Formatters} *)

val pp_error : Format.formatter -> error -> unit 
(** [pp_error v] formats v *)

val pp_reply : Format.formatter -> reply -> unit 
(** [pp_reply v] formats v *)

val pp_call : Format.formatter -> call -> unit 
(** [pp_call v] formats v *)

val pp_commit : Format.formatter -> commit -> unit 
(** [pp_commit v] formats v *)


(** {2 Protobuf Encoding} *)

val encode_pb_error : error -> Pbrt.Encoder.t -> unit
(** [encode_pb_error v encoder] encodes [v] with the given [encoder] *)

val encode_pb_reply : reply -> Pbrt.Encoder.t -> unit
(** [encode_pb_reply v encoder] encodes [v] with the given [encoder] *)

val encode_pb_call : call -> Pbrt.Encoder.t -> unit
(** [encode_pb_call v encoder] encodes [v] with the given [encoder] *)

val encode_pb_commit : commit -> Pbrt.Encoder.t -> unit
(** [encode_pb_commit v encoder] encodes [v] with the given [encoder] *)


(** {2 Protobuf Decoding} *)

val decode_pb_error : Pbrt.Decoder.t -> error
(** [decode_pb_error decoder] decodes a [error] binary value from [decoder] *)

val decode_pb_reply : Pbrt.Decoder.t -> reply
(** [decode_pb_reply decoder] decodes a [reply] binary value from [decoder] *)

val decode_pb_call : Pbrt.Decoder.t -> call
(** [decode_pb_call decoder] decodes a [call] binary value from [decoder] *)

val decode_pb_commit : Pbrt.Decoder.t -> commit
(** [decode_pb_commit decoder] decodes a [commit] binary value from [decoder] *)
