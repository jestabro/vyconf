val find : ('a -> bool) -> 'a list -> 'a option
val remove : ('a -> bool) -> 'a list -> 'a list
val replace : ('a -> bool) -> 'a -> 'a list -> 'a list