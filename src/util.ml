(** The unavoidable module for functions that don't fit anywhere else *)

(** Convert a list of strings to a string of unquoted, space separated words *)
let string_of_list ss =
    let rec aux xs acc =
        match xs with
        | [] -> acc
        | x :: xs' -> aux xs' (Printf.sprintf "%s %s" acc x)
    in
    match ss with
    | [] -> ""
    | x :: xs -> Printf.sprintf "%s%s" x (aux xs "")

(** Convert a list of strings to JSON *)
let json_of_list ss =
    let ss = List.map (fun x -> `String x) ss in
    Yojson.Safe.to_string (`List ss)
