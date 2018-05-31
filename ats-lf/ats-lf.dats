#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(*****************************************************************************)
fun append  {a:type} {m,n:nat} (xs: list (a, m), ys: list (a, n))
  : list (a, m+n)
=
  case xs of
  | nil () => ys
  | cons (x, xs) => cons (x, append (xs, ys))

(*****************************************************************************)
dataprop MUL (int, int, int) =
  | {n:int} MULbas (0, n, 0)
  | {m,n,p:int | m >= 0 } MULind (m+1, n, p+n) of MUL (m, n, p)
  | {m,n,p:int | m > 0 } MULneg (~m, n, ~p) of MUL (m, n, p)

(*****************************************************************************)
fun concat {a:type} {m,n:nat} (xxs: list (list (a, n), m))
  : [p:nat] (MUL (m, n, p) | list (a, p))
=
  case xxs of
  | nil () => (MULbas () | nil ())
  | cons (xs, xss) => let
      val (pf | res) = concat xss
    in
      (MULind pf | append (xs, res))
    end

(*****************************************************************************)

(*
Z3 uses 100% memory when trying to check this lol

stacst mult : (int, int) -> int

extern praxi mult_base {n:int} (): [mult(0,n) == 0] unit_p
extern praxi mult_ind {m,n:int | m >= 0 } (): [mult(m+1,n) == n+mult(m,n)] unit_p
extern praxi mult_neg {m,n:int | m > 0 } (): [mult(~m,n) == ~mult(m,n)] unit_p

fun concat2 {a,b:int} (x: int a, y: int b)
  : int (mult (a,b))
= let
  prval () = $solver_assert(mult_base)
  prval () = $solver_assert(mult_ind)
  prval () = $solver_assert(mult_neg)
in
  x * y
end
*)

(*****************************************************************************)
implement main0 () = print ("Hello, world!\n")
