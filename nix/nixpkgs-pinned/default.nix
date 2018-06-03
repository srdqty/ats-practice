{ config ? {}
, overlays ? []
, owner ? "NixOS"
, repo ? "nixpkgs"
, rev ? "56fb68dcef494b7cdb3e09362d67836b8137019c"
, sha256 ? "0im8l87nghsp4z7swidgg2qpx9mxidnc0zs7a86qvw8jh7b6sbv2"
, bootstrap-pkgs ? import <nixpkgs> {}
}:

let
  fetch-nixpkgs = import ./fetch-nixpkgs.nix;
  nixpkgs-params = import ./fetch-nixpkgs-params.nix {
    inherit owner repo rev bootstrap-pkgs;
  };

  nixpkgs = fetch-nixpkgs {
    url = import ./build-url.nix { inherit owner repo rev; };
    rev = rev;
    sha256 = if builtins.isNull sha256 then nixpkgs-params.sha256 else sha256;
  };

  pkgs = import nixpkgs { inherit config overlays; };
in
  pkgs
