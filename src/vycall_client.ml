(* send commit data to Python commit daemon *)

open Vycall_message.Vycall_pbt
open Vyconfd_config.Commit

module CT = Vyos1x.Config_tree
module IC = Vyos1x.Internal.Make(CT)
module ST = Vyconfd_config.Startup
module DF = Vyconfd_config.Defaults
module FP = FilePath

type t = {
    ic: Lwt_io.input Lwt_io.channel;
    oc: Lwt_io.output Lwt_io.channel;
}

let default_call = {script_name=""; tag_value=None; arg_value=None}
let default_commit = {session_id=0l; named_active=None; named_proposed=None;
                      dry_run=false; atomic=false; background=false;
                      calls=[] }
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
    let%lwt () = Lwt_io.read_into_exactly ic header 0 4 in
    let length = EndianBytes.BigEndian.get_int32 header 0 |> Int32.to_int in
    if length < 0 then failwith (Printf.sprintf "Bad message length: %d" length) else
    let buffer = Bytes.create length in
    let%lwt () = Lwt_io.read_into_exactly ic buffer 0 length in
    Lwt.return buffer

let do_call client request =
    let enc = Pbrt.Encoder.create () in
    let () = encode_pb_commit request enc in
    let msg = Pbrt.Encoder.to_bytes enc in
    let%lwt () = do_write client.oc msg in
    let%lwt resp = do_read client.ic in
    decode_pb_result (Pbrt.Decoder.of_bytes resp) |> Lwt.return

let create sockfile =
    let open Lwt_unix in
    let sock = socket PF_UNIX SOCK_STREAM 0 in
    let%lwt () = connect sock (ADDR_UNIX sockfile) in
    let ic = Lwt_io.of_fd ~mode:Lwt_io.Input sock in
    let oc = Lwt_io.of_fd ~mode:Lwt_io.Output sock in
    Lwt.return { ic=ic; oc=oc; }

let commit _session =
    let run () =
        let sockfile = "/run/vyos-commitd.sock" in
        let%lwt client = create sockfile in

        let cmds = [{ default_call with script_name="foo" };
                    { default_call with script_name="bar" }]
        in
        let req = { default_commit with calls=cmds } in

        let%lwt resp = do_call client req in
        let%lwt () = Lwt_io.write Lwt_io.stdout resp.out in
        Lwt_io.flush Lwt_io.stdout
    in Lwt_main.run @@ run ()

let test_commit at wt =
    let vc =
        ST.load_daemon_config DF.defaults.config_file in
    let () =
        IC.write_internal at (FP.concat vc.session_dir vc.running_cache) in
    let () =
        IC.write_internal wt (FP.concat vc.session_dir vc.working_cache) in
    let rt_opt =
        ST.read_reference_tree (FP.concat vc.reftree_dir vc.reference_tree)
    in
    match rt_opt with
    | Error msg -> print_endline msg
    | Ok rt ->
        let del_list, add_list =
            calculate_priority_lists rt at wt
        in
        let commit_l = del_list @ add_list in
        let commit_session =
            { default_commit_session with commit_list = commit_l; }
        in
        commit commit_session
