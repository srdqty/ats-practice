#include "prelude/basics_pre.sats"
#include "share/atspre_staload.hats"

sortdef srd = { a:int | (a land 3) }

implement main0 () = print ("Hello, world!\n")
