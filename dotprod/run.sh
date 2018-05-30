#!/usr/bin/env nix-shell
#! nix-shell -i bash

set -eu

patscc -o dotprod dotprod.dats
./dotprod
