#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

stacst fact: int -> int

extern praxi fact_base(): [fact(0) == 1] unit_p
extern praxi fact_ind {n:int | n >= 1} (): [fact(n) == n * fact(n-1)] unit_p

fun fact {n:nat} (n: int n): int (fact(n)) = let
  prval () = $solver_assert(fact_base)
  prval () = $solver_assert(fact_ind)

  fun loop {n,r:nat} (n: int n, r: int r): int (fact(n)*r) =
    if n > 0 then loop (n-1, n*r) else r
in
  loop(n, 1)
end

implement main0() = let
  var r = fact(5)
in
  println!("5! = ", r)
end
