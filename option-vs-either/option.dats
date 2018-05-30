#include "share/atspre_staload.hats"

fun gen_option{n:nat}(x: int n) : Option_vt(int n) =
(
  if x > 1000 then Some_vt(x) else None_vt ()
)


implement main0 () = let
  fun loop{i:nat} .<i>. (x: int i) =
  (
    if x = 0
    then
      ()
    else
      case+ gen_option(x) of
      | ~Some_vt(x) => loop(x-1)
      | ~None_vt () => loop(x-1)
  )
in
  println!("result:", loop(1000000))
end
