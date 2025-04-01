(*
 *)

open Commitd_client.Commit

module CD = Vyos1x.Config_diff
module FP = FilePath

let show_commit_data at wt =
    let vc =
        Startup.load_daemon_config Defaults.defaults.config_file in
    let rt_opt =
        Startup.read_reference_tree (FP.concat vc.reftree_dir vc.reference_tree)
    in
    match rt_opt with
    | Error msg -> msg
    | Ok rt ->
        let diff = CD.diff_tree [] at wt in
        let del_list, add_list =
            calculate_priority_lists rt diff
        in
        let sprint_node_data acc s =
            acc ^ "\n" ^ (node_data_to_yojson s |> Yojson.Safe.to_string)
        in
        let del_out = List.fold_left sprint_node_data "" del_list in
        let add_out = List.fold_left sprint_node_data "" add_list in
        del_out ^ "\n" ^ add_out
