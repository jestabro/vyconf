
(** Code for vycall.proto *)

(* generated from "data/vycall.proto", do not edit *)



(** {2 Types} *)

type commit_init = {
  named_active : string option;
  named_proposed : string option;
  dry_run : bool;
  atomic : bool;
  background : bool;
}

type commit_call = {
  script : string;
  tag_value : string option;
  arg_value : string option;
}

type commit =
  | Init of commit_init
  | Call of commit_call

type commit_envelope = {
  token : int32;
  commit : commit;
}

type error =
  | Success 
  | Config_error 
  | Sync_error 
  | Background 

type result = {
  error : error;
  output : string;
}


(** {2 Basic values} *)

val default_commit_init : 
  ?named_active:string option ->
  ?named_proposed:string option ->
  ?dry_run:bool ->
  ?atomic:bool ->
  ?background:bool ->
  unit ->
  commit_init
(** [default_commit_init ()] is the default value for type [commit_init] *)

val default_commit_call : 
  ?script:string ->
  ?tag_value:string option ->
  ?arg_value:string option ->
  unit ->
  commit_call
(** [default_commit_call ()] is the default value for type [commit_call] *)

val default_commit : unit -> commit
(** [default_commit ()] is the default value for type [commit] *)

val default_commit_envelope : 
  ?token:int32 ->
  ?commit:commit ->
  unit ->
  commit_envelope
(** [default_commit_envelope ()] is the default value for type [commit_envelope] *)

val default_error : unit -> error
(** [default_error ()] is the default value for type [error] *)

val default_result : 
  ?error:error ->
  ?output:string ->
  unit ->
  result
(** [default_result ()] is the default value for type [result] *)


(** {2 Formatters} *)

val pp_commit_init : Format.formatter -> commit_init -> unit 
(** [pp_commit_init v] formats v *)

val pp_commit_call : Format.formatter -> commit_call -> unit 
(** [pp_commit_call v] formats v *)

val pp_commit : Format.formatter -> commit -> unit 
(** [pp_commit v] formats v *)

val pp_commit_envelope : Format.formatter -> commit_envelope -> unit 
(** [pp_commit_envelope v] formats v *)

val pp_error : Format.formatter -> error -> unit 
(** [pp_error v] formats v *)

val pp_result : Format.formatter -> result -> unit 
(** [pp_result v] formats v *)


(** {2 Protobuf Encoding} *)

val encode_pb_commit_init : commit_init -> Pbrt.Encoder.t -> unit
(** [encode_pb_commit_init v encoder] encodes [v] with the given [encoder] *)

val encode_pb_commit_call : commit_call -> Pbrt.Encoder.t -> unit
(** [encode_pb_commit_call v encoder] encodes [v] with the given [encoder] *)

val encode_pb_commit : commit -> Pbrt.Encoder.t -> unit
(** [encode_pb_commit v encoder] encodes [v] with the given [encoder] *)

val encode_pb_commit_envelope : commit_envelope -> Pbrt.Encoder.t -> unit
(** [encode_pb_commit_envelope v encoder] encodes [v] with the given [encoder] *)

val encode_pb_error : error -> Pbrt.Encoder.t -> unit
(** [encode_pb_error v encoder] encodes [v] with the given [encoder] *)

val encode_pb_result : result -> Pbrt.Encoder.t -> unit
(** [encode_pb_result v encoder] encodes [v] with the given [encoder] *)


(** {2 Protobuf Decoding} *)

val decode_pb_commit_init : Pbrt.Decoder.t -> commit_init
(** [decode_pb_commit_init decoder] decodes a [commit_init] binary value from [decoder] *)

val decode_pb_commit_call : Pbrt.Decoder.t -> commit_call
(** [decode_pb_commit_call decoder] decodes a [commit_call] binary value from [decoder] *)

val decode_pb_commit : Pbrt.Decoder.t -> commit
(** [decode_pb_commit decoder] decodes a [commit] binary value from [decoder] *)

val decode_pb_commit_envelope : Pbrt.Decoder.t -> commit_envelope
(** [decode_pb_commit_envelope decoder] decodes a [commit_envelope] binary value from [decoder] *)

val decode_pb_error : Pbrt.Decoder.t -> error
(** [decode_pb_error decoder] decodes a [error] binary value from [decoder] *)

val decode_pb_result : Pbrt.Decoder.t -> result
(** [decode_pb_result decoder] decodes a [result] binary value from [decoder] *)
