{ owner ? "NixOS"
, repo ? "nixpkgs"
, rev ? "f96373262f5af078a4c118d9fb881eb7295dfe76"
}:

let
  pkgs = import <nixpkgs> {};

  url="https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";

  file = builtins.fetchurl url;
  json = builtins.toFile "data.json" ''
    { "url": "${url}"
    , "rev": "${rev}"
    , "owner": "${owner}"
    , "repo": "${repo}"
    }
  '';

  out-filename = builtins.toString ../nixpkgs-pinned/nixpkgs.json;
in


pkgs.stdenv.mkDerivation rec {
  name = "generate-nixpkgs-json";

  buildInputs = [
    pkgs.jq
  ];


  shellHook = ''
    set -eu
    sha256=$(sha256sum -b ${file} | awk -n '{printf $1}')
    jq .+="{\"sha256\":\"$sha256\"}" ${json} > ${out-filename}
    exit
  '';
}
