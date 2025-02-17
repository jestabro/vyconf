[@@@ocaml.warning "-27-30-39-44"]

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

let rec default_commit_init 
  ?named_active:((named_active:string option) = None)
  ?named_proposed:((named_proposed:string option) = None)
  ?dry_run:((dry_run:bool) = false)
  ?atomic:((atomic:bool) = false)
  ?background:((background:bool) = false)
  () : commit_init  = {
  named_active;
  named_proposed;
  dry_run;
  atomic;
  background;
}

let rec default_commit_call 
  ?script:((script:string) = "")
  ?tag_value:((tag_value:string option) = None)
  ?arg_value:((arg_value:string option) = None)
  () : commit_call  = {
  script;
  tag_value;
  arg_value;
}

let rec default_commit () : commit = Init (default_commit_init ())

let rec default_commit_envelope 
  ?token:((token:int32) = 0l)
  ?commit:((commit:commit) = default_commit ())
  () : commit_envelope  = {
  token;
  commit;
}

let rec default_error () = (Success:error)

let rec default_result 
  ?error:((error:error) = default_error ())
  ?output:((output:string) = "")
  () : result  = {
  error;
  output;
}

type commit_init_mutable = {
  mutable named_active : string option;
  mutable named_proposed : string option;
  mutable dry_run : bool;
  mutable atomic : bool;
  mutable background : bool;
}

let default_commit_init_mutable () : commit_init_mutable = {
  named_active = None;
  named_proposed = None;
  dry_run = false;
  atomic = false;
  background = false;
}

type commit_call_mutable = {
  mutable script : string;
  mutable tag_value : string option;
  mutable arg_value : string option;
}

let default_commit_call_mutable () : commit_call_mutable = {
  script = "";
  tag_value = None;
  arg_value = None;
}

type commit_envelope_mutable = {
  mutable token : int32;
  mutable commit : commit;
}

let default_commit_envelope_mutable () : commit_envelope_mutable = {
  token = 0l;
  commit = default_commit ();
}

type result_mutable = {
  mutable error : error;
  mutable output : string;
}

let default_result_mutable () : result_mutable = {
  error = default_error ();
  output = "";
}

[@@@ocaml.warning "-27-30-39"]

(** {2 Formatters} *)

let rec pp_commit_init fmt (v:commit_init) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "named_active" (Pbrt.Pp.pp_option Pbrt.Pp.pp_string) fmt v.named_active;
    Pbrt.Pp.pp_record_field ~first:false "named_proposed" (Pbrt.Pp.pp_option Pbrt.Pp.pp_string) fmt v.named_proposed;
    Pbrt.Pp.pp_record_field ~first:false "dry_run" Pbrt.Pp.pp_bool fmt v.dry_run;
    Pbrt.Pp.pp_record_field ~first:false "atomic" Pbrt.Pp.pp_bool fmt v.atomic;
    Pbrt.Pp.pp_record_field ~first:false "background" Pbrt.Pp.pp_bool fmt v.background;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_commit_call fmt (v:commit_call) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "script" Pbrt.Pp.pp_string fmt v.script;
    Pbrt.Pp.pp_record_field ~first:false "tag_value" (Pbrt.Pp.pp_option Pbrt.Pp.pp_string) fmt v.tag_value;
    Pbrt.Pp.pp_record_field ~first:false "arg_value" (Pbrt.Pp.pp_option Pbrt.Pp.pp_string) fmt v.arg_value;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_commit fmt (v:commit) =
  match v with
  | Init x -> Format.fprintf fmt "@[<hv2>Init(@,%a)@]" pp_commit_init x
  | Call x -> Format.fprintf fmt "@[<hv2>Call(@,%a)@]" pp_commit_call x

let rec pp_commit_envelope fmt (v:commit_envelope) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "token" Pbrt.Pp.pp_int32 fmt v.token;
    Pbrt.Pp.pp_record_field ~first:false "commit" pp_commit fmt v.commit;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_error fmt (v:error) =
  match v with
  | Success -> Format.fprintf fmt "Success"
  | Config_error -> Format.fprintf fmt "Config_error"
  | Sync_error -> Format.fprintf fmt "Sync_error"
  | Background -> Format.fprintf fmt "Background"

let rec pp_result fmt (v:result) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "error" pp_error fmt v.error;
    Pbrt.Pp.pp_record_field ~first:false "output" Pbrt.Pp.pp_string fmt v.output;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

[@@@ocaml.warning "-27-30-39"]

(** {2 Protobuf Encoding} *)

let rec encode_pb_commit_init (v:commit_init) encoder = 
  begin match v.named_active with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  begin match v.named_proposed with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  Pbrt.Encoder.bool v.dry_run encoder;
  Pbrt.Encoder.key 3 Pbrt.Varint encoder; 
  Pbrt.Encoder.bool v.atomic encoder;
  Pbrt.Encoder.key 4 Pbrt.Varint encoder; 
  Pbrt.Encoder.bool v.background encoder;
  Pbrt.Encoder.key 5 Pbrt.Varint encoder; 
  ()

let rec encode_pb_commit_call (v:commit_call) encoder = 
  Pbrt.Encoder.string v.script encoder;
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
  ()

let rec encode_pb_commit (v:commit) encoder = 
  begin match v with
  | Init x ->
    Pbrt.Encoder.nested encode_pb_commit_init x encoder;
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  | Call x ->
    Pbrt.Encoder.nested encode_pb_commit_call x encoder;
    Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  end

let rec encode_pb_commit_envelope (v:commit_envelope) encoder = 
  Pbrt.Encoder.int32_as_varint v.token encoder;
  Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  Pbrt.Encoder.nested encode_pb_commit v.commit encoder;
  Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  ()

let rec encode_pb_error (v:error) encoder =
  match v with
  | Success -> Pbrt.Encoder.int_as_varint (0) encoder
  | Config_error -> Pbrt.Encoder.int_as_varint 1 encoder
  | Sync_error -> Pbrt.Encoder.int_as_varint 2 encoder
  | Background -> Pbrt.Encoder.int_as_varint 3 encoder

let rec encode_pb_result (v:result) encoder = 
  encode_pb_error v.error encoder;
  Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  Pbrt.Encoder.string v.output encoder;
  Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  ()

[@@@ocaml.warning "-27-30-39"]

(** {2 Protobuf Decoding} *)

let rec decode_pb_commit_init d =
  let v = default_commit_init_mutable () in
  let continue__= ref true in
  let background_is_set = ref false in
  let atomic_is_set = ref false in
  let dry_run_is_set = ref false in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      v.named_active <- Some (Pbrt.Decoder.string d);
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit_init), field(1)" pk
    | Some (2, Pbrt.Bytes) -> begin
      v.named_proposed <- Some (Pbrt.Decoder.string d);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit_init), field(2)" pk
    | Some (3, Pbrt.Varint) -> begin
      v.dry_run <- Pbrt.Decoder.bool d; dry_run_is_set := true;
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit_init), field(3)" pk
    | Some (4, Pbrt.Varint) -> begin
      v.atomic <- Pbrt.Decoder.bool d; atomic_is_set := true;
    end
    | Some (4, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit_init), field(4)" pk
    | Some (5, Pbrt.Varint) -> begin
      v.background <- Pbrt.Decoder.bool d; background_is_set := true;
    end
    | Some (5, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit_init), field(5)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  begin if not !background_is_set then Pbrt.Decoder.missing_field "background" end;
  begin if not !atomic_is_set then Pbrt.Decoder.missing_field "atomic" end;
  begin if not !dry_run_is_set then Pbrt.Decoder.missing_field "dry_run" end;
  ({
    named_active = v.named_active;
    named_proposed = v.named_proposed;
    dry_run = v.dry_run;
    atomic = v.atomic;
    background = v.background;
  } : commit_init)

let rec decode_pb_commit_call d =
  let v = default_commit_call_mutable () in
  let continue__= ref true in
  let script_is_set = ref false in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      v.script <- Pbrt.Decoder.string d; script_is_set := true;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit_call), field(1)" pk
    | Some (2, Pbrt.Bytes) -> begin
      v.tag_value <- Some (Pbrt.Decoder.string d);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit_call), field(2)" pk
    | Some (3, Pbrt.Bytes) -> begin
      v.arg_value <- Some (Pbrt.Decoder.string d);
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit_call), field(3)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  begin if not !script_is_set then Pbrt.Decoder.missing_field "script" end;
  ({
    script = v.script;
    tag_value = v.tag_value;
    arg_value = v.arg_value;
  } : commit_call)

let rec decode_pb_commit d = 
  let rec loop () = 
    let ret:commit = match Pbrt.Decoder.key d with
      | None -> Pbrt.Decoder.malformed_variant "commit"
      | Some (1, _) -> (Init (decode_pb_commit_init (Pbrt.Decoder.nested d)) : commit) 
      | Some (2, _) -> (Call (decode_pb_commit_call (Pbrt.Decoder.nested d)) : commit) 
      | Some (n, payload_kind) -> (
        Pbrt.Decoder.skip d payload_kind; 
        loop () 
      )
    in
    ret
  in
  loop ()

let rec decode_pb_commit_envelope d =
  let v = default_commit_envelope_mutable () in
  let continue__= ref true in
  let commit_is_set = ref false in
  let token_is_set = ref false in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Varint) -> begin
      v.token <- Pbrt.Decoder.int32_as_varint d; token_is_set := true;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit_envelope), field(1)" pk
    | Some (2, Pbrt.Bytes) -> begin
      v.commit <- decode_pb_commit (Pbrt.Decoder.nested d); commit_is_set := true;
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commit_envelope), field(2)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  begin if not !commit_is_set then Pbrt.Decoder.missing_field "commit" end;
  begin if not !token_is_set then Pbrt.Decoder.missing_field "token" end;
  ({
    token = v.token;
    commit = v.commit;
  } : commit_envelope)

let rec decode_pb_error d = 
  match Pbrt.Decoder.int_as_varint d with
  | 0 -> (Success:error)
  | 1 -> (Config_error:error)
  | 2 -> (Sync_error:error)
  | 3 -> (Background:error)
  | _ -> Pbrt.Decoder.malformed_variant "error"

let rec decode_pb_result d =
  let v = default_result_mutable () in
  let continue__= ref true in
  let output_is_set = ref false in
  let error_is_set = ref false in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Varint) -> begin
      v.error <- decode_pb_error d; error_is_set := true;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(result), field(1)" pk
    | Some (2, Pbrt.Bytes) -> begin
      v.output <- Pbrt.Decoder.string d; output_is_set := true;
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(result), field(2)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  begin if not !output_is_set then Pbrt.Decoder.missing_field "output" end;
  begin if not !error_is_set then Pbrt.Decoder.missing_field "error" end;
  ({
    error = v.error;
    output = v.output;
  } : result)
