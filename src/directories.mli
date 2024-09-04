type t = {
    components: string;
    validators: string;
    migrators: string;
    component_definitions: string;
    interface_definitions: string;
}

val make : string -> Vyconfd_config.Vyconf_config.t -> t

val test : t -> (unit, string) result
