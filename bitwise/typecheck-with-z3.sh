#!/usr/bin/env nix-shell
#! nix-shell -i bash

set -eu

patsopt -tc --constraint-export -d bitwise.dats | patsolve_z3 -i
