#!/usr/bin/env bash

set -eu

rev=$1
dir=`ls /nix/store | grep "nixpkgs-params-${rev}" | grep -v drv`

cat "/nix/store/$dir/nixpkgs.json"
