
(** Code for vycall.proto *)

(* generated from "data/vycall.proto", do not edit *)



(** {2 Types} *)

type call = {
  script_name : string;
  tag_value : string option;
  arg_value : string option;
}

type commit = {
  session_id : int32;
  named_active : string option;
  named_proposed : string option;
  dry_run : bool;
  atomic : bool;
  background : bool;
  calls : call list;
}

type error =
  | Success 
  | Config_error 
  | Daemon_error 
  | Background 

type result = {
  error : error;
  out : string;
}


(** {2 Basic values} *)

val default_call : 
  ?script_name:string ->
  ?tag_value:string option ->
  ?arg_value:string option ->
  unit ->
  call
(** [default_call ()] is the default value for type [call] *)

val default_commit : 
  ?session_id:int32 ->
  ?named_active:string option ->
  ?named_proposed:string option ->
  ?dry_run:bool ->
  ?atomic:bool ->
  ?background:bool ->
  ?calls:call list ->
  unit ->
  commit
(** [default_commit ()] is the default value for type [commit] *)

val default_error : unit -> error
(** [default_error ()] is the default value for type [error] *)

val default_result : 
  ?error:error ->
  ?out:string ->
  unit ->
  result
(** [default_result ()] is the default value for type [result] *)


(** {2 Formatters} *)

val pp_call : Format.formatter -> call -> unit 
(** [pp_call v] formats v *)

val pp_commit : Format.formatter -> commit -> unit 
(** [pp_commit v] formats v *)

val pp_error : Format.formatter -> error -> unit 
(** [pp_error v] formats v *)

val pp_result : Format.formatter -> result -> unit 
(** [pp_result v] formats v *)


(** {2 Protobuf Encoding} *)

val encode_pb_call : call -> Pbrt.Encoder.t -> unit
(** [encode_pb_call v encoder] encodes [v] with the given [encoder] *)

val encode_pb_commit : commit -> Pbrt.Encoder.t -> unit
(** [encode_pb_commit v encoder] encodes [v] with the given [encoder] *)

val encode_pb_error : error -> Pbrt.Encoder.t -> unit
(** [encode_pb_error v encoder] encodes [v] with the given [encoder] *)

val encode_pb_result : result -> Pbrt.Encoder.t -> unit
(** [encode_pb_result v encoder] encodes [v] with the given [encoder] *)


(** {2 Protobuf Decoding} *)

val decode_pb_call : Pbrt.Decoder.t -> call
(** [decode_pb_call decoder] decodes a [call] binary value from [decoder] *)

val decode_pb_commit : Pbrt.Decoder.t -> commit
(** [decode_pb_commit decoder] decodes a [commit] binary value from [decoder] *)

val decode_pb_error : Pbrt.Decoder.t -> error
(** [decode_pb_error decoder] decodes a [error] binary value from [decoder] *)

val decode_pb_result : Pbrt.Decoder.t -> result
(** [decode_pb_result decoder] decodes a [result] binary value from [decoder] *)
