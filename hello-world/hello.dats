#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
staload UN = $UNSAFE

fn f {n:nat} (x:uintptr n): uintptr n = x
fn g (x:uintptr): uintptr = x

implement main0 () = let
  val x:uintptr = $UN.cast{uintptr}(0u)
  val y:uintptr = x+x
  val b:bool = true
  val b:bool = x = g(x)
in
(
  println!("y=", y);
  print ("Hello, world!\n")
)
end
