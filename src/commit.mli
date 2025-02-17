
type commit_data = {
    script_name: string option;
    priority: int;
    tag_value: string option;
    arg_value: string option;
    path: string list;
} [@@deriving yojson]

type commit_session = {
    dry_run: bool;
    atomic: bool;
    background: bool;
    commit_list: commit_data list;
} [@@deriving yojson]

val default_commit_data : commit_data

val default_commit_session : commit_session

val calculate_priority_lists : Vyos1x.Reference_tree.t -> Vyos1x.Config_tree.t -> Vyos1x.Config_tree.t -> commit_data list * commit_data list

val show_commit_data : Vyos1x.Config_tree.t -> Vyos1x.Config_tree.t -> string
