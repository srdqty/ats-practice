#!/usr/bin/env nix-shell
#! nix-shell -i bash

set -eu

patscc \
  -DATS_MEMALLOC_LIBC \
  -o datatype \
  datatype.dats
./datatype
