[@@@ocaml.warning "-27-30-39-44"]

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

let rec default_error () = (Success:error)

let rec default_reply 
  ?error:((error:error) = default_error ())
  ?out:((out:string) = "")
  () : reply  = {
  error;
  out;
}

let rec default_call 
  ?script_name:((script_name:string) = "")
  ?tag_value:((tag_value:string option) = None)
  ?arg_value:((arg_value:string option) = None)
  ?reply:((reply:reply option) = None)
  () : call  = {
  script_name;
  tag_value;
  arg_value;
  reply;
}

let rec default_commit 
  ?session_id:((session_id:string) = "")
  ?named_active:((named_active:string option) = None)
  ?named_proposed:((named_proposed:string option) = None)
  ?dry_run:((dry_run:bool) = false)
  ?atomic:((atomic:bool) = false)
  ?background:((background:bool) = false)
  ?calls:((calls:call list) = [])
  () : commit  = {
  session_id;
  named_active;
  named_proposed;
  dry_run;
  atomic;
  background;
  calls;
}

type reply_mutable = {
  mutable error : error;
  mutable out : string;
}

let default_reply_mutable () : reply_mutable = {
  error = default_error ();
  out = "";
}

type call_mutable = {
  mutable script_name : string;
  mutable tag_value : string option;
  mutable arg_value : string option;
  mutable reply : reply option;
}

let default_call_mutable () : call_mutable = {
  script_name = "";
  tag_value = None;
  arg_value = None;
  reply = None;
}

type commit_mutable = {
  mutable session_id : string;
  mutable named_active : string option;
  mutable named_proposed : string option;
  mutable dry_run : bool;
  mutable atomic : bool;
  mutable background : bool;
  mutable calls : call list;
}

let default_commit_mutable () : commit_mutable = {
  session_id = "";
  named_active = None;
  named_proposed = None;
  dry_run = false;
  atomic = false;
  background = false;
  calls = [];
}

[@@@ocaml.warning "-27-30-39"]

(** {2 Formatters} *)

let rec pp_error fmt (v:error) =
  match v with
  | Success -> Format.fprintf fmt "Success"
  | Config_error -> Format.fprintf fmt "Config_error"
  | Daemon_error -> Format.fprintf fmt "Daemon_error"
  | Background -> Format.fprintf fmt "Background"

let rec pp_reply fmt (v:reply) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "error" pp_error fmt v.error;
    Pbrt.Pp.pp_record_field ~first:false "out" Pbrt.Pp.pp_string fmt v.out;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_call fmt (v:call) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "script_name" Pbrt.Pp.pp_string fmt v.script_name;
    Pbrt.Pp.pp_record_field ~first:false "tag_value" (Pbrt.Pp.pp_option Pbrt.Pp.pp_string) fmt v.tag_value;
    Pbrt.Pp.pp_record_field ~first:false "arg_value" (Pbrt.Pp.pp_option Pbrt.Pp.pp_string) fmt v.arg_value;
    Pbrt.Pp.pp_record_field ~first:false "reply" (Pbrt.Pp.pp_option pp_reply) fmt v.reply;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_commit fmt (v:commit) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "session_id" Pbrt.Pp.pp_string fmt v.session_id;
    Pbrt.Pp.pp_record_field ~first:false "named_active" (Pbrt.Pp.pp_option Pbrt.Pp.pp_string) fmt v.named_active;
    Pbrt.Pp.pp_record_field ~first:false "named_proposed" (Pbrt.Pp.pp_option Pbrt.Pp.pp_string) fmt v.named_proposed;
    Pbrt.Pp.pp_record_field ~first:false "dry_run" Pbrt.Pp.pp_bool fmt v.dry_run;
    Pbrt.Pp.pp_record_field ~first:false "atomic" Pbrt.Pp.pp_bool fmt v.atomic;
    Pbrt.Pp.pp_record_field ~first:false "background" Pbrt.Pp.pp_bool fmt v.background;
    Pbrt.Pp.pp_record_field ~first:false "calls" (Pbrt.Pp.pp_list pp_call) fmt v.calls;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

[@@@ocaml.warning "-27-30-39"]

(** {2 Protobuf Encoding} *)

let rec encode_pb_error (v:error) encoder =
  match v with
  | Success -> Pbrt.Encoder.int_as_varint (0) encoder
  | Config_error -> Pbrt.Encoder.int_as_varint 1 encoder
  | Daemon_error -> Pbrt.Encoder.int_as_varint 2 encoder
  | Background -> Pbrt.Encoder.int_as_varint 4 encoder

let rec encode_pb_reply (v:reply) encoder = 
  encode_pb_error v.error encoder;
  Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  Pbrt.Encoder.string v.out encoder;
  Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  ()

let rec encode_pb_call (v:call) encoder = 
  Pbrt.Encoder.string v.script_name encoder;
  Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  begin match v.tag_value with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  begin match v.arg_value with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 3 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  begin match v.reply with
  | Some x -> 
    Pbrt.Encoder.nested encode_pb_reply x encoder;
    Pbrt.Encoder.key 4 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  ()

let rec encode_pb_commit (v:commit) encoder = 
  Pbrt.Encoder.string v.session_id encoder;
  Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  begin match v.named_active with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  begin match v.named_proposed with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 3 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  Pbrt.Encoder.bool v.dry_run encoder;
  Pbrt.Encoder.key 4 Pbrt.Varint encoder; 
  Pbrt.Encoder.bool v.atomic encoder;
  Pbrt.Encoder.key 5 Pbrt.Varint encoder; 
  Pbrt.Encoder.bool v.background encoder;
  Pbrt.Encoder.key 6 Pbrt.Varint encoder; 
  Pbrt.List_util.rev_iter_with (fun x encoder -> 
    Pbrt.Encoder.nested encode_pb_call x encoder;
    Pbrt.Encoder.key 7 Pbrt.Bytes encoder; 
  ) v.calls encoder;
  ()

[@@@ocaml.warning "-27-30-39"]

(** {2 Protobuf Decoding} *)

let rec decode_pb_error d = 
  match Pbrt.Decoder.int_as_varint d with
  | 0 -> (Success:error)
  | 1 -> (Config_error:error)
  | 2 -> (Daemon_error:error)
  | 4 -> (Background:error)
  | _ -> Pbrt.Decoder.malformed_variant "error"

let rec decode_pb_reply d =
  let v = default_reply_mutable () in
  let continue__= ref true in
  let out_is_set = ref false in
  let error_is_set = ref false in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Varint) -> begin
      v.error <- decode_pb_error d; error_is_set := true;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(reply), field(1)" pk
    | Some (2, Pbrt.Bytes) -> begin
      v.out <- Pbrt.Decoder.string d; out_is_set := true;
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(reply), field(2)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  begin if not !out_is_set then Pbrt.Decoder.missing_field "out" end;
  begin if not !error_is_set then Pbrt.Decoder.missing_field "error" end;
  ({
    error = v.error;
    out = v.out;
  } : reply)

let rec decode_pb_call d =
  let v = default_call_mutable () in
  let continue__= ref true in
  let script_name_is_set = ref false in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      v.script_name <- Pbrt.Decoder.string d; script_name_is_set := true;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(call), field(1)" pk
    | Some (2, Pbrt.Bytes) -> begin
      v.tag_value <- Some (Pbrt.Decoder.string d);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(call), field(2)" pk
    | Some (3, Pbrt.Bytes) -> begin
      v.arg_value <- Some (Pbrt.Decoder.string d);
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(call), field(3)" pk
    | Some (4, Pbrt.Bytes) -> begin
      v.reply <- Some (decode_pb_reply (Pbrt.Decoder.nested d));
    end
    | Some (4, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(call), field(4)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  begin if not !script_name_is_set then Pbrt.Decoder.missing_field "script_name" end;
  ({
    script_name = v.script_name;
    tag_value = v.tag_value;
    arg_value = v.arg_value;
    reply = v.reply;
  } : call)

let rec decode_pb_commit d =
  let v = default_commit_mutable () in
  let continue__= ref true in
  let background_is_set = ref false in
  let atomic_is_set = ref false in
  let dry_run_is_set = ref false in
  let session_id_is_set = ref false in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
      v.calls <- List.rev v.calls;
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      v.session_id <- Pbrt.Decoder.string d; session_id_is_set := true;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit), field(1)" pk
    | Some (2, Pbrt.Bytes) -> begin
      v.named_active <- Some (Pbrt.Decoder.string d);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit), field(2)" pk
    | Some (3, Pbrt.Bytes) -> begin
      v.named_proposed <- Some (Pbrt.Decoder.string d);
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit), field(3)" pk
    | Some (4, Pbrt.Varint) -> begin
      v.dry_run <- Pbrt.Decoder.bool d; dry_run_is_set := true;
    end
    | Some (4, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit), field(4)" pk
    | Some (5, Pbrt.Varint) -> begin
      v.atomic <- Pbrt.Decoder.bool d; atomic_is_set := true;
    end
    | Some (5, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit), field(5)" pk
    | Some (6, Pbrt.Varint) -> begin
      v.background <- Pbrt.Decoder.bool d; background_is_set := true;
    end
    | Some (6, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit), field(6)" pk
    | Some (7, Pbrt.Bytes) -> begin
      v.calls <- (decode_pb_call (Pbrt.Decoder.nested d)) :: v.calls;
    end
    | Some (7, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit), field(7)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  begin if not !background_is_set then Pbrt.Decoder.missing_field "background" end;
  begin if not !atomic_is_set then Pbrt.Decoder.missing_field "atomic" end;
  begin if not !dry_run_is_set then Pbrt.Decoder.missing_field "dry_run" end;
  begin if not !session_id_is_set then Pbrt.Decoder.missing_field "session_id" end;
  ({
    session_id = v.session_id;
    named_active = v.named_active;
    named_proposed = v.named_proposed;
    dry_run = v.dry_run;
    atomic = v.atomic;
    background = v.background;
    calls = v.calls;
  } : commit)
