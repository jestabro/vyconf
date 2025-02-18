open Vycall_message.Vycall_pbt

type t = {
    ic: Lwt_io.input Lwt_io.channel;
    oc: Lwt_io.output Lwt_io.channel;
}

let default_call = { script_name=""; tag_value=None; arg_value=None }
let default_commit = { session_id=0l; named_active=None; named_proposed=None;
                       dry_run=false; atomic=false; background=false;
                       calls=[] }

let create sockfile =
    let open Lwt_unix in
    let sock = socket PF_UNIX SOCK_STREAM 0 in
    let%lwt () = connect sock (ADDR_UNIX sockfile) in
    let ic = Lwt_io.of_fd ~mode:Lwt_io.Input sock in
    let oc = Lwt_io.of_fd ~mode:Lwt_io.Output sock in
    Lwt.return {
      ic=ic;
      oc=oc;
    }

let hexdump b =
    let dump = ref "" in
    Bytes.iter (fun c -> dump := Char.code c |> Printf.sprintf "%s %02x" !dump) b;
    !dump

let do_write oc msg =
    let length = Bytes.length msg in
    let length' = Int32.of_int length in
    if length' < 0l then failwith (Printf.sprintf "Bad message length: %d" length) else
    let header = Bytes.create 4 in
    let () = EndianBytes.BigEndian.set_int32 header 0 length' in
    let%lwt () = Lwt_io.write_from_exactly oc header 0 4 in
    Lwt_io.write_from_exactly oc msg 0 length

let do_read ic =
    let header = Bytes.create 4 in
    Lwt_log.debug (Printf.sprintf "Header length: %d\n" (Bytes.length header)) |> Lwt.ignore_result;
    let%lwt () = Lwt_io.read_into_exactly ic header 0 4 in
    Lwt_log.debug (hexdump header |> Printf.sprintf "Header: %s") |> Lwt.ignore_result;
    let length = EndianBytes.BigEndian.get_int32 header 0 |> Int32.to_int in
    Lwt_log.debug (Printf.sprintf "Read length: %d\n" length) |> Lwt.ignore_result;
    if length < 0 then failwith (Printf.sprintf "Bad message length: %d" length) else
    let buffer = Bytes.create length in
    let%lwt () = Lwt_io.read_into_exactly ic buffer 0 length in
    Lwt_log.debug (hexdump buffer |> Printf.sprintf "Read mesage: %s") |> Lwt.ignore_result;
    Lwt.return buffer

let do_request client request =
    let enc = Pbrt.Encoder.create () in
    let () = encode_pb_commit request enc in
    let msg = Pbrt.Encoder.to_bytes enc in
    let%lwt () = do_write client.oc msg in
    Lwt_log.debug (Printf.sprintf "do_write %d\n" 0) |> Lwt.ignore_result;
    let%lwt resp = do_read client.ic in
    Lwt_log.debug (Printf.sprintf "do_read %d\n" 0) |> Lwt.ignore_result;
    decode_pb_result (Pbrt.Decoder.of_bytes resp) |> Lwt.return

let run () =
    Lwt_log.default :=
    Lwt_log.channel
      ~template:"$(date).$(milliseconds) [$(level)] $(message)"
      ~close_mode:`Keep
      ~channel:Lwt_io.stdout
      ();

    Lwt_log.add_rule "*" Lwt_log.Debug;

    let sockfile = "/run/vyos-commitd.sock" in
    let%lwt client = create sockfile in

    let cmds = [{ default_call with script_name="foo" };
                { default_call with script_name="bar" }]
    in
    let req = { default_commit with calls=cmds } in

    let%lwt resp = do_request client req in
    let%lwt () = Lwt_io.write Lwt_io.stdout resp.out in
    Lwt_io.flush Lwt_io.stdout

let _ = Lwt_main.run @@ run ()
