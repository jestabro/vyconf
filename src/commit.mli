
type node_data = {
    script_name: string;
    priority: int;
    tag_value: string option;
    arg_value: string option;
    path: string list;
} [@@deriving yojson]

type session_data = {
    session_id: int32;
    dry_run: bool;
    atomic: bool;
    background: bool;
    node_list: node_data list;
} [@@deriving yojson]

val default_node_data : node_data

val default_session_data : session_data

val calculate_priority_lists : Vyos1x.Reference_tree.t -> Vyos1x.Config_tree.t -> Vyos1x.Config_tree.t -> node_data list * node_data list

val show_commit_data : Vyos1x.Config_tree.t -> Vyos1x.Config_tree.t -> string
