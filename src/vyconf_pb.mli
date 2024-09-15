
(** Code for vyconf.proto *)

(* generated from "data/vyconf.proto", do not edit *)


(** {2 Formatters} *)

val pp_request_config_format : Format.formatter -> Vyconf_types.request_config_format -> unit 
(** [pp_request_config_format v] formats v *)

val pp_request_output_format : Format.formatter -> Vyconf_types.request_output_format -> unit 
(** [pp_request_output_format v] formats v *)

val pp_request_status : Format.formatter -> Vyconf_types.request_status -> unit 
(** [pp_request_status v] formats v *)

val pp_request_setup_session : Format.formatter -> Vyconf_types.request_setup_session -> unit 
(** [pp_request_setup_session v] formats v *)

val pp_request_set : Format.formatter -> Vyconf_types.request_set -> unit 
(** [pp_request_set v] formats v *)

val pp_request_delete : Format.formatter -> Vyconf_types.request_delete -> unit 
(** [pp_request_delete v] formats v *)

val pp_request_rename : Format.formatter -> Vyconf_types.request_rename -> unit 
(** [pp_request_rename v] formats v *)

val pp_request_copy : Format.formatter -> Vyconf_types.request_copy -> unit 
(** [pp_request_copy v] formats v *)

val pp_request_comment : Format.formatter -> Vyconf_types.request_comment -> unit 
(** [pp_request_comment v] formats v *)

val pp_request_commit : Format.formatter -> Vyconf_types.request_commit -> unit 
(** [pp_request_commit v] formats v *)

val pp_request_rollback : Format.formatter -> Vyconf_types.request_rollback -> unit 
(** [pp_request_rollback v] formats v *)

val pp_request_load : Format.formatter -> Vyconf_types.request_load -> unit 
(** [pp_request_load v] formats v *)

val pp_request_merge : Format.formatter -> Vyconf_types.request_merge -> unit 
(** [pp_request_merge v] formats v *)

val pp_request_save : Format.formatter -> Vyconf_types.request_save -> unit 
(** [pp_request_save v] formats v *)

val pp_request_show_config : Format.formatter -> Vyconf_types.request_show_config -> unit 
(** [pp_request_show_config v] formats v *)

val pp_request_exists : Format.formatter -> Vyconf_types.request_exists -> unit 
(** [pp_request_exists v] formats v *)

val pp_request_get_value : Format.formatter -> Vyconf_types.request_get_value -> unit 
(** [pp_request_get_value v] formats v *)

val pp_request_get_values : Format.formatter -> Vyconf_types.request_get_values -> unit 
(** [pp_request_get_values v] formats v *)

val pp_request_list_children : Format.formatter -> Vyconf_types.request_list_children -> unit 
(** [pp_request_list_children v] formats v *)

val pp_request_run_op_mode : Format.formatter -> Vyconf_types.request_run_op_mode -> unit 
(** [pp_request_run_op_mode v] formats v *)

val pp_request_confirm : Format.formatter -> Vyconf_types.request_confirm -> unit 
(** [pp_request_confirm v] formats v *)

val pp_request_enter_configuration_mode : Format.formatter -> Vyconf_types.request_enter_configuration_mode -> unit 
(** [pp_request_enter_configuration_mode v] formats v *)

val pp_request_exit_configuration_mode : Format.formatter -> Vyconf_types.request_exit_configuration_mode -> unit 
(** [pp_request_exit_configuration_mode v] formats v *)

val pp_request : Format.formatter -> Vyconf_types.request -> unit 
(** [pp_request v] formats v *)

val pp_request_envelope : Format.formatter -> Vyconf_types.request_envelope -> unit 
(** [pp_request_envelope v] formats v *)

val pp_status : Format.formatter -> Vyconf_types.status -> unit 
(** [pp_status v] formats v *)

val pp_response : Format.formatter -> Vyconf_types.response -> unit 
(** [pp_response v] formats v *)


(** {2 Protobuf Encoding} *)

val encode_pb_request_config_format : Vyconf_types.request_config_format -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_config_format v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_output_format : Vyconf_types.request_output_format -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_output_format v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_status : Vyconf_types.request_status -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_status v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_setup_session : Vyconf_types.request_setup_session -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_setup_session v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_set : Vyconf_types.request_set -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_set v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_delete : Vyconf_types.request_delete -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_delete v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_rename : Vyconf_types.request_rename -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_rename v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_copy : Vyconf_types.request_copy -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_copy v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_comment : Vyconf_types.request_comment -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_comment v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_commit : Vyconf_types.request_commit -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_commit v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_rollback : Vyconf_types.request_rollback -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_rollback v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_load : Vyconf_types.request_load -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_load v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_merge : Vyconf_types.request_merge -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_merge v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_save : Vyconf_types.request_save -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_save v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_show_config : Vyconf_types.request_show_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_show_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_exists : Vyconf_types.request_exists -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_exists v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_get_value : Vyconf_types.request_get_value -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_get_value v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_get_values : Vyconf_types.request_get_values -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_get_values v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_list_children : Vyconf_types.request_list_children -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_list_children v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_run_op_mode : Vyconf_types.request_run_op_mode -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_run_op_mode v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_confirm : Vyconf_types.request_confirm -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_confirm v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_enter_configuration_mode : Vyconf_types.request_enter_configuration_mode -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_enter_configuration_mode v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_exit_configuration_mode : Vyconf_types.request_exit_configuration_mode -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_exit_configuration_mode v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request : Vyconf_types.request -> Pbrt.Encoder.t -> unit
(** [encode_pb_request v encoder] encodes [v] with the given [encoder] *)

val encode_pb_request_envelope : Vyconf_types.request_envelope -> Pbrt.Encoder.t -> unit
(** [encode_pb_request_envelope v encoder] encodes [v] with the given [encoder] *)

val encode_pb_status : Vyconf_types.status -> Pbrt.Encoder.t -> unit
(** [encode_pb_status v encoder] encodes [v] with the given [encoder] *)

val encode_pb_response : Vyconf_types.response -> Pbrt.Encoder.t -> unit
(** [encode_pb_response v encoder] encodes [v] with the given [encoder] *)


(** {2 Protobuf Decoding} *)

val decode_pb_request_config_format : Pbrt.Decoder.t -> Vyconf_types.request_config_format
(** [decode_pb_request_config_format decoder] decodes a [request_config_format] binary value from [decoder] *)

val decode_pb_request_output_format : Pbrt.Decoder.t -> Vyconf_types.request_output_format
(** [decode_pb_request_output_format decoder] decodes a [request_output_format] binary value from [decoder] *)

val decode_pb_request_status : Pbrt.Decoder.t -> Vyconf_types.request_status
(** [decode_pb_request_status decoder] decodes a [request_status] binary value from [decoder] *)

val decode_pb_request_setup_session : Pbrt.Decoder.t -> Vyconf_types.request_setup_session
(** [decode_pb_request_setup_session decoder] decodes a [request_setup_session] binary value from [decoder] *)

val decode_pb_request_set : Pbrt.Decoder.t -> Vyconf_types.request_set
(** [decode_pb_request_set decoder] decodes a [request_set] binary value from [decoder] *)

val decode_pb_request_delete : Pbrt.Decoder.t -> Vyconf_types.request_delete
(** [decode_pb_request_delete decoder] decodes a [request_delete] binary value from [decoder] *)

val decode_pb_request_rename : Pbrt.Decoder.t -> Vyconf_types.request_rename
(** [decode_pb_request_rename decoder] decodes a [request_rename] binary value from [decoder] *)

val decode_pb_request_copy : Pbrt.Decoder.t -> Vyconf_types.request_copy
(** [decode_pb_request_copy decoder] decodes a [request_copy] binary value from [decoder] *)

val decode_pb_request_comment : Pbrt.Decoder.t -> Vyconf_types.request_comment
(** [decode_pb_request_comment decoder] decodes a [request_comment] binary value from [decoder] *)

val decode_pb_request_commit : Pbrt.Decoder.t -> Vyconf_types.request_commit
(** [decode_pb_request_commit decoder] decodes a [request_commit] binary value from [decoder] *)

val decode_pb_request_rollback : Pbrt.Decoder.t -> Vyconf_types.request_rollback
(** [decode_pb_request_rollback decoder] decodes a [request_rollback] binary value from [decoder] *)

val decode_pb_request_load : Pbrt.Decoder.t -> Vyconf_types.request_load
(** [decode_pb_request_load decoder] decodes a [request_load] binary value from [decoder] *)

val decode_pb_request_merge : Pbrt.Decoder.t -> Vyconf_types.request_merge
(** [decode_pb_request_merge decoder] decodes a [request_merge] binary value from [decoder] *)

val decode_pb_request_save : Pbrt.Decoder.t -> Vyconf_types.request_save
(** [decode_pb_request_save decoder] decodes a [request_save] binary value from [decoder] *)

val decode_pb_request_show_config : Pbrt.Decoder.t -> Vyconf_types.request_show_config
(** [decode_pb_request_show_config decoder] decodes a [request_show_config] binary value from [decoder] *)

val decode_pb_request_exists : Pbrt.Decoder.t -> Vyconf_types.request_exists
(** [decode_pb_request_exists decoder] decodes a [request_exists] binary value from [decoder] *)

val decode_pb_request_get_value : Pbrt.Decoder.t -> Vyconf_types.request_get_value
(** [decode_pb_request_get_value decoder] decodes a [request_get_value] binary value from [decoder] *)

val decode_pb_request_get_values : Pbrt.Decoder.t -> Vyconf_types.request_get_values
(** [decode_pb_request_get_values decoder] decodes a [request_get_values] binary value from [decoder] *)

val decode_pb_request_list_children : Pbrt.Decoder.t -> Vyconf_types.request_list_children
(** [decode_pb_request_list_children decoder] decodes a [request_list_children] binary value from [decoder] *)

val decode_pb_request_run_op_mode : Pbrt.Decoder.t -> Vyconf_types.request_run_op_mode
(** [decode_pb_request_run_op_mode decoder] decodes a [request_run_op_mode] binary value from [decoder] *)

val decode_pb_request_confirm : Pbrt.Decoder.t -> Vyconf_types.request_confirm
(** [decode_pb_request_confirm decoder] decodes a [request_confirm] binary value from [decoder] *)

val decode_pb_request_enter_configuration_mode : Pbrt.Decoder.t -> Vyconf_types.request_enter_configuration_mode
(** [decode_pb_request_enter_configuration_mode decoder] decodes a [request_enter_configuration_mode] binary value from [decoder] *)

val decode_pb_request_exit_configuration_mode : Pbrt.Decoder.t -> Vyconf_types.request_exit_configuration_mode
(** [decode_pb_request_exit_configuration_mode decoder] decodes a [request_exit_configuration_mode] binary value from [decoder] *)

val decode_pb_request : Pbrt.Decoder.t -> Vyconf_types.request
(** [decode_pb_request decoder] decodes a [request] binary value from [decoder] *)

val decode_pb_request_envelope : Pbrt.Decoder.t -> Vyconf_types.request_envelope
(** [decode_pb_request_envelope decoder] decodes a [request_envelope] binary value from [decoder] *)

val decode_pb_status : Pbrt.Decoder.t -> Vyconf_types.status
(** [decode_pb_status decoder] decodes a [status] binary value from [decoder] *)

val decode_pb_response : Pbrt.Decoder.t -> Vyconf_types.response
(** [decode_pb_response decoder] decodes a [response] binary value from [decoder] *)
