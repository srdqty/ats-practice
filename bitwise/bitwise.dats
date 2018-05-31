#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

datasort bv32 =

stacst bv32_of_int: (int) -> bv32
stadef bv32 = bv32_of_int

stacst int_of_bv32: bv32 -> int
stadef bv32toint = int_of_bv32

stacst or_bv32_bv32: (bv32, bv32) -> bv32
stadef lor = or_bv32_bv32

abst@ype int_bv32 (bv:bv32) = $extype "int32_t"
typedef int (bv:bv32) = int_bv32(bv)

%{
#define lor_int_int_bv32(x,y) ((x)|(y))
%}

extern fun
lor_int_int_bv32 {x,y:bv32}
  (x:int (x), y: int (y)): int (x lor y) = "mac#"

overload lor with lor_int_int_bv32

//castfn bv32_of_int {n:nat} (int n): int (bv32(n))

extern praxi lor_comm{m,n:bv32}(): [(n lor m) == (m lor n)] unit_p

fn my_or {m,n:bv32} (x: int m, y: int n) : int (m lor n) = let
  // Why isn't this axiom enough?
  (*
λx. ./typecheck-with-z3.sh
Hello from [patsolve_z3]!
UnsolvedConstraint(main)@/home/srdqty/projects/ats-practice/bitwise/bitwise.dats: 762(line=35, offs=3) -- 769(line=35, offs=10):C3NSTRprop(S2Eeqeq(S2Eapp(S2Ecst(or_bv32_bv32); S2Evar(n), S2Evar(m)), S2Eapp(S2Ecst(or_bv32_bv32); S2Evar(m), S2Evar(n))))
typechecking has failed: there are some unsolved constraints: please inspect the above reported error message(s) for information.
  *)
  prval _ = lor_comm{m,n}()
in
  y lor x
end

(*****************************************************************************)
implement main0 () = print ("Hello, world!\n")
