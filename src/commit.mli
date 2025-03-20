type tree_source = DELETE | ADD

type status = {
  success : bool;
  out : string;
}

type node_data = {
    script_name: string;
    priority: int;
    tag_value: string option;
    arg_value: string option;
    path: string list;
    source: tree_source;
    reply: status option;
} [@@deriving to_yojson]

type commit_data = {
    session_id: string;
    config_diff: CD.config_diff;
    dry_run: bool;
    atomic: bool;
    background: bool;
    init: status option;
    node_list: node_data list;
} [@@deriving to_yojson]

val tree_source_to_yojson : tree_source -> [> `String of string ]

val default_node_data : node_data

val default_commit_data : commit_data

val calculate_priority_lists : Vyos1x.Reference_tree.t -> Vyos1x.Config_tree.t -> Vyos1x.Config_tree.t -> node_data list * node_data list

val commit_store : commit_data -> unit
