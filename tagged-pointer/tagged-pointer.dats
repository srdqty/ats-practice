#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
staload UN = $UNSAFE

datasort tptr_s =
| left_tptr_s
| right_tptr_s

abst@ype tptr_t (n:addr, x:tptr_s) = uintptr

(*****************************************************************************)
fn tptr_left_of_ptr {n:addr} (p: ptr n): tptr_t (n, left_tptr_s) = let
  val n = $UN.cast{uintptr}(p)
  val tagged = n lor $UN.cast{uintptr}(1)
  val pleft = $UN.cast{ptr}(tagged)
in
  $UN.cast{tptr_t (n,left_tptr_s)}(pleft)
end

(*****************************************************************************)
fn tptr_right_of_ptr {n:addr} (p: ptr n): tptr_t (n,right_tptr_s) =
  $UN.cast{tptr_t (n,right_tptr_s)}(p)

(*****************************************************************************)
extern fn {t:tptr_s} ptr_of_tptr {n:addr} (tp: tptr_t (n,t)): ptr n

implement {right_tptr_s} ptr_of_tptr {n} (tp) =
  $UN.cast{ptr n}(tp)

implement {left_tptr_s} ptr_of_tptr {n} (tp) = let
  val n = $UN.cast{uintptr}(tp)
  val untagged == n land (lnot 1u)
in
  $UN.cast{ptr n}(untagged)
end

(*****************************************************************************)
extern fn {t:tptr_s} is_ptr_right {n:addr} (x: tptr_t (n,t)) : bool

implement {t} is_ptr_right (x) = let
  val x = $UN.cast{uintptr}(x)
in
  0u = (x land 1u)
end

implement {right_tptr_s} is_ptr_right (x) = true
implement {left_tptr_s} is_ptr_right (x) = false

(*****************************************************************************)
extern fn {t:tptr_s} is_ptr_left {n:addr} (x: tptr_t (n,t)) : bool

implement {t} is_ptr_left (x) = let
  val x = $UN.cast{uintptr}(x)
in
  1u = (x land 1u)
end

implement {right_tptr_s} is_ptr_left (x) = false
implement {left_tptr_s} is_ptr_left (x) = true

(*****************************************************************************)
extern fn
{a:t@ype}
  tptr_get_left
{n:addr}
(pf: a @ n | tp: tptr_t (n,left_tptr_s)) : (a @ n | a)

(*****************************************************************************)
extern fn
{a:t@ype}
  tptr_get_right
{n:addr}
(pf: a @ n | tp: tptr_t (n,right_tptr_s)) : (a @ n | a)

(*****************************************************************************)
fn f {n:addr} {t:tptr_s} (x: tptr_t (n, t)) : [t:tptr_s] tptr_t (n,t) = x

(*****************************************************************************)
implement main0 () = let
  val t = 78
  val p = $UN.cast{ptr 1}(t)
  val tp = tptr_left_of_ptr(p)
  val x = $UN.cast{uint}(tp)
  val p2 = ptr_of_tptr(tp)
  val fx = f(tp)
  val () = println!("t=", t)
  val () = println!("p=", p)
  val () = println!("x=", x)
  val () = println!("p2=", p2)
  val () = println!("is_ptr_right(tp)=", is_ptr_right(tp))
  val () = println!("is_ptr_left(tp)=", is_ptr_left(tp))
  val () = println!("is_ptr_left(fx)=", is_ptr_left(fx))
in
  ()
end
