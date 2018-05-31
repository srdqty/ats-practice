#!/usr/bin/env nix-shell
#! nix-shell -i bash

set -eu

patsopt -tc --constraint-export -d ats-lf.dats | patsolve_z3 -i

#patscc --constraint-ignore -o ats-lf ats-lf.dats
patscc -o ats-lf ats-lf.dats

./ats-lf
