#!/usr/bin/env nix-shell
#! nix-shell -i bash

set -eu

patscc -o tagged-pointer tagged-pointer.dats
./tagged-pointer
