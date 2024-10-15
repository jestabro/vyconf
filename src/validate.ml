open Client.Vyconf_client_api

let path_opt = ref ""
let token : string option ref = ref None

(* Command line arguments *)
let usage = "Usage: " ^ Sys.argv.(0) ^ " [options]"

let args = [
    ("--path", Arg.String (fun s -> path_opt := s), "<string> Configuration path");
    ("--token", Arg.String (fun s -> token := Some s), "<string>  Session token");
   ]

let get_sockname =
    "/var/run/vyconfd.sock"

let main socket path_list =
    let open Lwt.Syntax in
    let* token = session_init socket in
    let* out = session_validate_path socket token path_list in
    Lwt.return out

let _ =
    let () = Arg.parse args (fun _ -> ()) usage in
    let path_list = Vyos1x.Util.list_of_path !path_opt in
    let socket = get_sockname in
    let result = Lwt_main.run (main socket path_list) in
    let () = print_endline result in
    exit 0
