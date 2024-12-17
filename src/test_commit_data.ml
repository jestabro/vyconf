
module IR = Vyos1x.Internal.Make(Vyos1x.Reference_tree)

let parse_ct file_name =
    let ic = open_in file_name in
    let s = really_input_string ic (in_channel_length ic) in
    let ct = Vyos1x.Parser.from_string s in
    close_in ic; ct

let () =
    let rt_cache = "/home/jestabro/reftree.cache" in
    let f = "/home/jestabro/config.vrf" in
    let rt = IR.read_internal rt_cache in
    let ct = parse_ct f in
    Vyconfd_config.Commit.test_commit_data rt ct
