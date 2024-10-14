open Client.Vyconf_client_api

let path_opt = ref ""
let token : string option ref = ref None

(* Command line arguments *)
let usage = "Usage: " ^ Sys.argv.(0) ^ " [options]"

let args = [
    ("--path", Arg.String (fun s -> path_opt := s), "<string> Configuration path");
    ("--token", Arg.String (fun s -> token := Some s), "<string>  Session token");
   ]

let _ =
    let () = Arg.parse args (fun _ -> ()) usage in
    let path_list = Vyos1x.Util.list_of_path !path_opt in
    token := Some (session_init ());
    match !token with
    | None -> print_endline "Failed to get token"
    | Some stoken ->
            print_endline stoken;
            let res = session_path_exists stoken path_list in
            print_endline res
