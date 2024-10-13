open Vyconf_connect.Vyconf_pbt

type op_t =
    | OpSetupSession
    | OpTeardownSession
    | OpShowConfig
    | OpValidate

let get_sockname =
    "/var/run/vyconfd.sock"

let config_format_of_string s =
    match s with
    | "curly" -> Curly
    | "json" -> Json
    | _ -> failwith (Printf.sprintf "Unknown config format %s, should be curly or json" s)

let output_format_of_string s =
    match s with
    | "plain" -> Out_plain
    | "json" ->	Out_json
    | _	-> failwith (Printf.sprintf "Unknown output format %s, should be plain or json" s)

let call_op ?(out_format="plain") ?(config_format="curly") token op path =
    let socket = get_sockname in
    let config_format = config_format_of_string config_format in
    let out_format = output_format_of_string out_format in
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
                let%lwt resp = Vyconf_client.setup_session client "vyconf_client_session" in
                begin
                    match resp with
                    | Ok c -> Vyconf_client.get_token c
                    | Error e -> Error e |> Lwt.return
                end
            | OpTeardownSession -> Vyconf_client.teardown_session client
            | OpShowConfig -> Vyconf_client.show_config client path
            | OpValidate -> Vyconf_client.validate client path
            end
        in
        match result with
        | Ok s ->  Printf.sprintf "%s\n" s |> Lwt.return
(*            let%lwt () = Lwt_io.write Lwt_io.stdout s in Lwt.return 0*)
        | Error e -> Printf.sprintf "%s\n" e |> Lwt.return
(*            let%lwt () = Lwt_io.write Lwt_io.stderr (Printf.sprintf "%s\n" e) in Lwt.return 1*)
    in
    Lwt_main.run run


let session_init ?(out_format="plain") ?(config_format="curly") () =
    call_op ~out_format:out_format ~config_format:config_format None (Some OpSetupSession) []

let session_free token =
    call_op (Some token) (Some OpTeardownSession) []

let session_validate_path token path =
    call_op (Some token) (Some OpValidate) path

let session_show_config token path =
    call_op (Some token) (Some OpShowConfig) path