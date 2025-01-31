open Vyconfd_config.Defaults
open Vyconfd_config.Startup

module CT = Vyos1x.Config_tree
module FP = FilePath

exception Nonexistent_cache of string

let active_config_file = ref ""
let working_config_file = ref ""
let reference_tree_cache_name = ref ""

let config_file = ref defaults.config_file

let usage = "Usage: " ^ Sys.argv.(0) ^ " [options]"

let args = [
    ("--running-config", Arg.String (fun s -> active_config_file:= s), "running config file");
    ("--proposed-config", Arg.String (fun s -> working_config_file := s), "proposed config file");
    ("--reference-tree-cache", Arg.String (fun s -> reference_tree_cache_name := s), "reference tree cache file");
   ]

let parse_ct file_name =
    match file_name with
    | "" -> CT.make ""
    | _ ->
        let ic = open_in file_name in
        let s = really_input_string ic (in_channel_length ic) in
        let ct = Vyos1x.Parser.from_string s in
        close_in ic; ct

let () =
    let () = Arg.parse args (fun _ -> ()) usage in
    let vc = load_daemon_config !config_file in
    let rt_cache =
        match !reference_tree_cache_name with
        | "" -> FP.concat vc.reftree_dir vc.reference_tree
        | _ as rtc -> rtc
    in
    let af = !active_config_file in
    let wf = !working_config_file in
    let rt =
        match read_reference_tree rt_cache with
        | Ok reftree -> reftree
        | Error msg -> raise (Nonexistent_cache msg)
    in
    let at = parse_ct af in
    let wt = parse_ct wf in
    Vyconfd_config.Commit.show_commit_data rt at wt
