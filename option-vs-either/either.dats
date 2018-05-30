#include "share/atspre_staload.hats"

fun gen_either{n:nat}(x: int n) : Either_vt(int n) =
(
  if x > 1000 then Some_vt(x) else None_vt ()
)


implement main0 () = let
  fun loop{i:nat} .<i>. (x: int i) =
    if x == 0
    then
      0
    else
      case+ genEither(x) of
      | ~Some_vt(x) => print("ok"); loop(x-1)
      | ~None_vt () => 0
in
  loop(1000000)
end
