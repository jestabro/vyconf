[@@@ocaml.warning "-27-30-39-44"]

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

let rec default_dispatch_initialization 
  ?config_active:((config_active:string option) = None)
  ?config_proposed:((config_proposed:string option) = None)
  ?dry_run:((dry_run:bool option) = None)
  ?atomic:((atomic:bool option) = None)
  () : dispatch_initialization  = {
  config_active;
  config_proposed;
  dry_run;
  atomic;
}

let rec default_dispatch_call 
  ?script:((script:string) = "")
  ?tag_value:((tag_value:string option) = None)
  ?arg:((arg:string option) = None)
  () : dispatch_call  = {
  script;
  tag_value;
  arg;
}

let rec default_dispatch () : dispatch = Initialization (default_dispatch_initialization ())

let rec default_dispatch_envelope 
  ?token:((token:int32) = 0l)
  ?dispatch:((dispatch:dispatch) = default_dispatch ())
  () : dispatch_envelope  = {
  token;
  dispatch;
}

let rec default_error () = (Success:error)

let rec default_command 
  ?node:((node:string list) = [])
  () : command  = {
  node;
}

let rec default_commands 
  ?cmd:((cmd:command list) = [])
  () : commands  = {
  cmd;
}

let rec default_result 
  ?error:((error:error) = default_error ())
  ?output:((output:string) = "")
  ?set:((set:commands option) = None)
  ?delete:((delete:commands option) = None)
  () : result  = {
  error;
  output;
  set;
  delete;
}

type dispatch_initialization_mutable = {
  mutable config_active : string option;
  mutable config_proposed : string option;
  mutable dry_run : bool option;
  mutable atomic : bool option;
}

let default_dispatch_initialization_mutable () : dispatch_initialization_mutable = {
  config_active = None;
  config_proposed = None;
  dry_run = None;
  atomic = None;
}

type dispatch_call_mutable = {
  mutable script : string;
  mutable tag_value : string option;
  mutable arg : string option;
}

let default_dispatch_call_mutable () : dispatch_call_mutable = {
  script = "";
  tag_value = None;
  arg = None;
}

type dispatch_envelope_mutable = {
  mutable token : int32;
  mutable dispatch : dispatch;
}

let default_dispatch_envelope_mutable () : dispatch_envelope_mutable = {
  token = 0l;
  dispatch = default_dispatch ();
}

type command_mutable = {
  mutable node : string list;
}

let default_command_mutable () : command_mutable = {
  node = [];
}

type commands_mutable = {
  mutable cmd : command list;
}

let default_commands_mutable () : commands_mutable = {
  cmd = [];
}

type result_mutable = {
  mutable error : error;
  mutable output : string;
  mutable set : commands option;
  mutable delete : commands option;
}

let default_result_mutable () : result_mutable = {
  error = default_error ();
  output = "";
  set = None;
  delete = None;
}

[@@@ocaml.warning "-27-30-39"]

(** {2 Formatters} *)

let rec pp_dispatch_initialization fmt (v:dispatch_initialization) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "config_active" (Pbrt.Pp.pp_option Pbrt.Pp.pp_string) fmt v.config_active;
    Pbrt.Pp.pp_record_field ~first:false "config_proposed" (Pbrt.Pp.pp_option Pbrt.Pp.pp_string) fmt v.config_proposed;
    Pbrt.Pp.pp_record_field ~first:false "dry_run" (Pbrt.Pp.pp_option Pbrt.Pp.pp_bool) fmt v.dry_run;
    Pbrt.Pp.pp_record_field ~first:false "atomic" (Pbrt.Pp.pp_option Pbrt.Pp.pp_bool) fmt v.atomic;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_dispatch_call fmt (v:dispatch_call) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "script" Pbrt.Pp.pp_string fmt v.script;
    Pbrt.Pp.pp_record_field ~first:false "tag_value" (Pbrt.Pp.pp_option Pbrt.Pp.pp_string) fmt v.tag_value;
    Pbrt.Pp.pp_record_field ~first:false "arg" (Pbrt.Pp.pp_option Pbrt.Pp.pp_string) fmt v.arg;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_dispatch fmt (v:dispatch) =
  match v with
  | Initialization x -> Format.fprintf fmt "@[<hv2>Initialization(@,%a)@]" pp_dispatch_initialization x
  | Call x -> Format.fprintf fmt "@[<hv2>Call(@,%a)@]" pp_dispatch_call x

let rec pp_dispatch_envelope fmt (v:dispatch_envelope) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "token" Pbrt.Pp.pp_int32 fmt v.token;
    Pbrt.Pp.pp_record_field ~first:false "dispatch" pp_dispatch fmt v.dispatch;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_error fmt (v:error) =
  match v with
  | Success -> Format.fprintf fmt "Success"
  | Config_error -> Format.fprintf fmt "Config_error"
  | Daemon_error -> Format.fprintf fmt "Daemon_error"
  | Pass_through -> Format.fprintf fmt "Pass_through"

let rec pp_command fmt (v:command) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "node" (Pbrt.Pp.pp_list Pbrt.Pp.pp_string) fmt v.node;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_commands fmt (v:commands) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "cmd" (Pbrt.Pp.pp_list pp_command) fmt v.cmd;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_result fmt (v:result) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "error" pp_error fmt v.error;
    Pbrt.Pp.pp_record_field ~first:false "output" Pbrt.Pp.pp_string fmt v.output;
    Pbrt.Pp.pp_record_field ~first:false "set" (Pbrt.Pp.pp_option pp_commands) fmt v.set;
    Pbrt.Pp.pp_record_field ~first:false "delete" (Pbrt.Pp.pp_option pp_commands) fmt v.delete;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

[@@@ocaml.warning "-27-30-39"]

(** {2 Protobuf Encoding} *)

let rec encode_pb_dispatch_initialization (v:dispatch_initialization) encoder = 
  begin match v.config_active with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  begin match v.config_proposed with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 3 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  begin match v.dry_run with
  | Some x -> 
    Pbrt.Encoder.bool x encoder;
    Pbrt.Encoder.key 4 Pbrt.Varint encoder; 
  | None -> ();
  end;
  begin match v.atomic with
  | Some x -> 
    Pbrt.Encoder.bool x encoder;
    Pbrt.Encoder.key 5 Pbrt.Varint encoder; 
  | None -> ();
  end;
  ()

let rec encode_pb_dispatch_call (v:dispatch_call) encoder = 
  Pbrt.Encoder.string v.script encoder;
  Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  begin match v.tag_value with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  begin match v.arg with
  | Some x -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 3 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  ()

let rec encode_pb_dispatch (v:dispatch) encoder = 
  begin match v with
  | Initialization x ->
    Pbrt.Encoder.nested encode_pb_dispatch_initialization x encoder;
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  | Call x ->
    Pbrt.Encoder.nested encode_pb_dispatch_call x encoder;
    Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  end

let rec encode_pb_dispatch_envelope (v:dispatch_envelope) encoder = 
  Pbrt.Encoder.int32_as_varint v.token encoder;
  Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  Pbrt.Encoder.nested encode_pb_dispatch v.dispatch encoder;
  Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  ()

let rec encode_pb_error (v:error) encoder =
  match v with
  | Success -> Pbrt.Encoder.int_as_varint (0) encoder
  | Config_error -> Pbrt.Encoder.int_as_varint 1 encoder
  | Daemon_error -> Pbrt.Encoder.int_as_varint 2 encoder
  | Pass_through -> Pbrt.Encoder.int_as_varint 3 encoder

let rec encode_pb_command (v:command) encoder = 
  Pbrt.List_util.rev_iter_with (fun x encoder -> 
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  ) v.node encoder;
  ()

let rec encode_pb_commands (v:commands) encoder = 
  Pbrt.List_util.rev_iter_with (fun x encoder -> 
    Pbrt.Encoder.nested encode_pb_command x encoder;
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  ) v.cmd encoder;
  ()

let rec encode_pb_result (v:result) encoder = 
  encode_pb_error v.error encoder;
  Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  Pbrt.Encoder.string v.output encoder;
  Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  begin match v.set with
  | Some x -> 
    Pbrt.Encoder.nested encode_pb_commands x encoder;
    Pbrt.Encoder.key 3 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  begin match v.delete with
  | Some x -> 
    Pbrt.Encoder.nested encode_pb_commands x encoder;
    Pbrt.Encoder.key 4 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  ()

[@@@ocaml.warning "-27-30-39"]

(** {2 Protobuf Decoding} *)

let rec decode_pb_dispatch_initialization d =
  let v = default_dispatch_initialization_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (2, Pbrt.Bytes) -> begin
      v.config_active <- Some (Pbrt.Decoder.string d);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(dispatch_initialization), field(2)" pk
    | Some (3, Pbrt.Bytes) -> begin
      v.config_proposed <- Some (Pbrt.Decoder.string d);
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(dispatch_initialization), field(3)" pk
    | Some (4, Pbrt.Varint) -> begin
      v.dry_run <- Some (Pbrt.Decoder.bool d);
    end
    | Some (4, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(dispatch_initialization), field(4)" pk
    | Some (5, Pbrt.Varint) -> begin
      v.atomic <- Some (Pbrt.Decoder.bool d);
    end
    | Some (5, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(dispatch_initialization), field(5)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    config_active = v.config_active;
    config_proposed = v.config_proposed;
    dry_run = v.dry_run;
    atomic = v.atomic;
  } : dispatch_initialization)

let rec decode_pb_dispatch_call d =
  let v = default_dispatch_call_mutable () in
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
      Pbrt.Decoder.unexpected_payload "Message(dispatch_call), field(1)" pk
    | Some (2, Pbrt.Bytes) -> begin
      v.tag_value <- Some (Pbrt.Decoder.string d);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(dispatch_call), field(2)" pk
    | Some (3, Pbrt.Bytes) -> begin
      v.arg <- Some (Pbrt.Decoder.string d);
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(dispatch_call), field(3)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  begin if not !script_is_set then Pbrt.Decoder.missing_field "script" end;
  ({
    script = v.script;
    tag_value = v.tag_value;
    arg = v.arg;
  } : dispatch_call)

let rec decode_pb_dispatch d = 
  let rec loop () = 
    let ret:dispatch = match Pbrt.Decoder.key d with
      | None -> Pbrt.Decoder.malformed_variant "dispatch"
      | Some (1, _) -> (Initialization (decode_pb_dispatch_initialization (Pbrt.Decoder.nested d)) : dispatch) 
      | Some (2, _) -> (Call (decode_pb_dispatch_call (Pbrt.Decoder.nested d)) : dispatch) 
      | Some (n, payload_kind) -> (
        Pbrt.Decoder.skip d payload_kind; 
        loop () 
      )
    in
    ret
  in
  loop ()

let rec decode_pb_dispatch_envelope d =
  let v = default_dispatch_envelope_mutable () in
  let continue__= ref true in
  let dispatch_is_set = ref false in
  let token_is_set = ref false in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Varint) -> begin
      v.token <- Pbrt.Decoder.int32_as_varint d; token_is_set := true;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(dispatch_envelope), field(1)" pk
    | Some (2, Pbrt.Bytes) -> begin
      v.dispatch <- decode_pb_dispatch (Pbrt.Decoder.nested d); dispatch_is_set := true;
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(dispatch_envelope), field(2)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  begin if not !dispatch_is_set then Pbrt.Decoder.missing_field "dispatch" end;
  begin if not !token_is_set then Pbrt.Decoder.missing_field "token" end;
  ({
    token = v.token;
    dispatch = v.dispatch;
  } : dispatch_envelope)

let rec decode_pb_error d = 
  match Pbrt.Decoder.int_as_varint d with
  | 0 -> (Success:error)
  | 1 -> (Config_error:error)
  | 2 -> (Daemon_error:error)
  | 3 -> (Pass_through:error)
  | _ -> Pbrt.Decoder.malformed_variant "error"

let rec decode_pb_command d =
  let v = default_command_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
      v.node <- List.rev v.node;
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      v.node <- (Pbrt.Decoder.string d) :: v.node;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(command), field(1)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    node = v.node;
  } : command)

let rec decode_pb_commands d =
  let v = default_commands_mutable () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
      v.cmd <- List.rev v.cmd;
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      v.cmd <- (decode_pb_command (Pbrt.Decoder.nested d)) :: v.cmd;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(commands), field(1)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  ({
    cmd = v.cmd;
  } : commands)

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
    | Some (3, Pbrt.Bytes) -> begin
      v.set <- Some (decode_pb_commands (Pbrt.Decoder.nested d));
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(result), field(3)" pk
    | Some (4, Pbrt.Bytes) -> begin
      v.delete <- Some (decode_pb_commands (Pbrt.Decoder.nested d));
    end
    | Some (4, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(result), field(4)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  begin if not !output_is_set then Pbrt.Decoder.missing_field "output" end;
  begin if not !error_is_set then Pbrt.Decoder.missing_field "error" end;
  ({
    error = v.error;
    output = v.output;
    set = v.set;
    delete = v.delete;
  } : result)
