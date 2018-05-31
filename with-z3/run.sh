#!/usr/bin/env nix-shell
#! nix-shell -i bash

set -eu

patscc --constraint-ignore -o with-z3 with-z3.dats
./with-z3
