{ owner ? "NixOS"
, repo ? "nixpkgs"
, rev ? "56fb68dcef494b7cdb3e09362d67836b8137019c"
, pkgs ? import <nixpkgs> {}
}:

let
  url="https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";

  newNix = 0 <= builtins.compareVersions builtins.nixVersion "1.12";

  file = if newNix then
    builtins.fetchTarball { url = url; }
  else
    builtins.fetchurl url;

  json = pkgs.writeText "data.json" ''
    { "url": "${url}"
    , "rev": "${rev}"
    , "owner": "${owner}"
    , "repo": "${repo}"
    }
  '';

  sha256calc = if newNix then
    "nix-hash --type sha256 --base32 ${file}"
  else
    "sha256sum -b ${file} | awk -n '{print $1}'";

  paramsDrv = pkgs.stdenv.mkDerivation {
    name = "fetchParamsFromGitHub";

    src = ./.;

    buildInputs = [
      pkgs.jq
      pkgs.nix
      pkgs.coreutils
    ];

    builder = pkgs.writeScript "builder" ''
      source $stdenv/setup

      mkdir -p $out
      sha256=$(${sha256calc})
      jq .+="{\"sha256\":\"$sha256\"}" ${json} > $out/nixpkgs.json
    '';
  };
in
  builtins.fromJSON (builtins.readFile "${paramsDrv}/nixpkgs.json")
