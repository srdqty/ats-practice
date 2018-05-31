#!/usr/bin/env nix-shell
#! nix-shell -i bash

set -eu

patsopt -tc --constraint-export -d with-z3.dats
