open Vydispatch_message.Vydispatch_pbt

type t = {
(*    sock: Lwt_unix.file_descr;*)
    ic: Lwt_io.input Lwt_io.channel;
    oc: Lwt_io.output Lwt_io.channel;
}

let create sockfile =
    let open Lwt_unix in
    let sock = socket PF_UNIX SOCK_STREAM 0 in
    let%lwt () = connect sock (ADDR_UNIX sockfile) in
    let ic = Lwt_io.of_fd ~mode:Lwt_io.Input sock in
    let oc = Lwt_io.of_fd ~mode:Lwt_io.Output sock in
    Lwt.return {
(*      sock=sock; *)
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
(*    Lwt_log.debug (Printf.sprintf "Write length: %d\n" length) |> Lwt.ignore_result;
    Lwt_log.debug (hexdump msg |> Printf.sprintf "Write message: %s") |>
    Lwt.ignore_result; *)
    if length' < 0l then failwith (Printf.sprintf "Bad message length: %d" length) else
    let header = Bytes.create 4 in
    let () = EndianBytes.BigEndian.set_int32 header 0 length' in
    let%lwt () = Lwt_io.write_from_exactly oc header 0 4 in
    Lwt_io.write_from_exactly oc msg 0 length

let do_read ic =
    let header = Bytes.create 4 in
(*    let header = Bytes.make 4 '3' in*)
    Lwt_log.debug (Printf.sprintf "Header length: %d\n" (Bytes.length header)) |> Lwt.ignore_result;
    let%lwt () = Lwt_io.read_into_exactly ic header 0 4 in
    Lwt_log.debug (hexdump header |> Printf.sprintf "Header: %s") |> Lwt.ignore_result;
    let length = EndianBytes.BigEndian.get_int32 header 0 |> Int32.to_int in
(*    Lwt_log.debug (Printf.sprintf "Wtf length: %d\n" 0) |>
      Lwt.ignore_result;*)
    Lwt_log.debug (Printf.sprintf "Read length: %d\n" length) |> Lwt.ignore_result;
    if length < 0 then failwith (Printf.sprintf "Bad message length: %d" length) else
    let buffer = Bytes.create length in
    let%lwt () = Lwt_io.read_into_exactly ic buffer 0 length in
    Lwt_log.debug (hexdump buffer |> Printf.sprintf "Read mesage: %s") |> Lwt.ignore_result;
    Lwt.return buffer
(*    Lwt.return length*)

let do_request client req =
    let request = {token = 137l; dispatch=req} in
    let enc = Pbrt.Encoder.create () in
    let () = encode_pb_dispatch_envelope request enc in
    let msg = Pbrt.Encoder.to_bytes enc in
    let%lwt () = do_write client.oc msg in
    Lwt_log.debug (Printf.sprintf "do_write %d\n" 0) |> Lwt.ignore_result;
    let%lwt resp = do_read client.ic in
    Lwt_log.debug (Printf.sprintf "do_read %d\n" 0) |> Lwt.ignore_result;
    decode_pb_result (Pbrt.Decoder.of_bytes resp) |> Lwt.return
(*    let%lwt () = do_write client.oc msg in
    Lwt.return () *)
(*    in
    let%lwt resp = Vyconf_connect.Message.read client.ic in
    decode_pb_response (Pbrt.Decoder.of_bytes resp) |> Lwt.return
*)
(*
let shutdown client =
    let%lwt () = Lwt_unix.close client.sock in
    Lwt.return client
*)
let run () =
    Lwt_log.default :=
    Lwt_log.channel
      ~template:"$(date).$(milliseconds) [$(level)] $(message)"
      ~close_mode:`Keep
      ~channel:Lwt_io.stdout
      ();

    Lwt_log.add_rule "*" Lwt_log.Debug;

    let sockfile = "/tmp/vydispatchd.sock" in
    let%lwt client = create sockfile in
(*    let req = Initialization { pid=137l } in
    let%lwt resp = do_request client req in
    let%lwt () = Lwt_io.write Lwt_io.stdout resp.output in *)
    let req_init =
        Init { config_active=None; config_proposed=None; dry_run=Some true; atomic=None }
    in
    let%lwt resp_init = do_request client req_init in
    let%lwt () = Lwt_io.write Lwt_io.stdout resp_init.output in

    let req = Call { script="Some other message"; tag_value=None; arg_value=None } in
    let%lwt resp = do_request client req in
    let%lwt () = Lwt_io.write Lwt_io.stdout resp.output in
(*    let%lwt () = Lwt_io.write Lwt_io.stdout "dummy\n" in*)
    Lwt_io.flush Lwt_io.stdout

(*    let%lwt () = do_request client req in *)
(*    let%lwt () = do_request client req in
    Lwt_unix.sleep 1.0 |> Lwt.ignore_result;
    let%lwt _ = shutdown client in*)
(*    let%lwt () = Lwt_unix.close client.sock in*)
(*    Lwt.return ()*)

let _ = Lwt_main.run @@ run ()
