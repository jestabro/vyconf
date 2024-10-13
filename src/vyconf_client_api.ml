type op_t =
    | OpSetupSession
    | OpTeardownSession
    | OpShowConfig
    | OpValidate

let get_sockname =
    "/var/run/vyconfd.sock"

let call token op path ?(out_format="plain") ?(config_format="curly") cmd =
    let socket = get_sockname in
    let run =
        let%lwt client =
            Vyconf_client.create ~token:token socket out_format config_format
        in
        let%lwt result = match op with
        | None -> Error "Operation required" |> Lwt.return
        | Some o ->
            begin
            match o with
            | OpSetupSession ->
                let%lwt resp = setup_session client "vycli" in
                begin
                    match resp with
                    | Ok c -> get_token c
                    | Error e -> Error e |> Lwt.return
                end
            | OpTeardownSession -> teardown_session client
            | OpShowConfig -> show_config client path
            | OpValidate -> validate client path
            | _ -> Error "Unimplemented" |> Lwt.return
            end
        in match result with
        | Ok s ->
            let%lwt () = Lwt_io.write Lwt_io.stdout s in Lwt.return 0
        | Error e ->
            let%lwt () = Lwt_io.write Lwt_io.stderr (Printf.sprintf "%s\n" e) in Lwt.return 1
    in
    let result = Lwt_main.run run in exit result


let sesion_init ?(out_format="plain") ?(config_format="curly") =
    call_op None OpSetupSession []

let session_free token =
    call_op token OpTeardownSession []

let session_validate_path token path =
    call_op token OpValidate path
