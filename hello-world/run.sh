#!/usr/bin/env nix-shell
#! nix-shell -i bash

set -eu

patscc -o hello hello.dats
./hello
