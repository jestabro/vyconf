open Client.Vyconf_client_api

let path_opt = ref ""

(* Command line arguments *)
let usage = "Usage: " ^ Sys.argv.(0) ^ " [options]"

let args = [
    ("--path", Arg.String (fun s -> path_opt := s), "<string> Configuration path");
   ]

let _ =
    let () = Arg.parse args (fun _ -> ()) usage in
    let path = Vyos1x.Util.list_of_path !path_opt in
    let stoken = session_init () in
    let res = session_validate_path stoken path in
    print_endline res
