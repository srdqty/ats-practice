{ config ? {} }:

let
  fetch-nixpkgs = import ./fetch-nixpkgs.nix;

  nixpkgs-args = builtins.fromJSON (builtins.readFile ./nixpkgs.json);

  nixpkgs = fetch-nixpkgs {
    inherit (nixpkgs-args) owner repo rev sha256;
  };

  pkgs = import nixpkgs { config = config; };
in
  pkgs
