#!/usr/bin/env nix-shell
#! nix-shell -i bash

set -eu

patscc -o datatype datatype.dats
./datatype
