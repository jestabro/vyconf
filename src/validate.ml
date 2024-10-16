open Client.Vyconf_client_api

let path_opt = ref ""

(* Command line arguments *)
let usage = "Usage: " ^ Sys.argv.(0) ^ " [options]"

let args = [
    ("--path", Arg.String (fun s -> path_opt := s), "<string> Configuration path");
   ]

let get_sockname =
    "/var/run/vyconfd.sock"

let wrap o =
    match o with
    | Ok v -> Some v
    | Error _ -> None

let main socket path_list =
    let%lwt token = session_init socket in
    match token with
    | Error e -> Lwt.return ("Failed to initialize session: " ^ e)
    | Ok token ->
        let%lwt out = session_validate_path socket token path_list
        in
        let%lwt _ = session_free socket token in
        match out with
        | Error e -> Lwt.return ("Failed to validate path: " ^ e)
        | Ok _ -> Lwt.return ("Appeared to work")
    (*
    let%lwt token = session_init socket in
    let token = wrap token in
    let%lwt out = session_validate_path socket token path_list in
    let%lwt _ = session_free socket token in
    match out with
    | Error e -> Lwt.return ("Something happened: " ^ e)
    | Ok _ -> Lwt.return "Appeared to work"
    *)
(*            | Ok _ ->
                let%lwt out = session_show_config socket token [] in
                match out with
                | Error e -> Lwt.return ("Failed to show config: " ^ e)
                | Ok out -> Lwt.return out *)
(*        Lwt.return (Printf.sprintf "Session token: %s" token) *)
(*
    let* out = session_validate_path socket token path_list in
    Lwt.return out
*)

let _ =
    let () = Arg.parse args (fun _ -> ()) usage in
    let path_list = Vyos1x.Util.list_of_path !path_opt in
    let socket = get_sockname in
    let result = Lwt_main.run (main socket path_list) in
    let () = print_endline result in
    exit 0
