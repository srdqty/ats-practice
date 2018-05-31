#!/usr/bin/env nix-shell
#! nix-shell -i bash

set -eu

#patsopt -tc --constraint-export -d tagged-pointer.dats | patsolve_z3 -i

#patscc --constraint-ignore -o tagged-pointer tagged-pointer.dats
patscc -o tagged-pointer tagged-pointer.dats

./tagged-pointer
