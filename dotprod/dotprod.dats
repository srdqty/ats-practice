fun
  { a : t@ype }
dotprod
  { n : nat | n >= 3 }

  ( x : &(@[a][n])
  , y : &(@[a][n])
  )
: double =
(
  x[0] * y[0] + x[1] * y[1] + x[2] * y[2]
)

implement main0 () = print ("Hello, world!\n")
