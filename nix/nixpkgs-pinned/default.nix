{ config ? {}
, overlays ? []
}:

let
  fetch-nixpkgs = import ./fetch-nixpkgs.nix;
  nixpkgs-params = import ./fetch-nixpkgs-params.nix {};

  nixpkgs = fetch-nixpkgs {
    inherit (nixpkgs-params) url rev sha256;
  };

  pkgs = import nixpkgs { inherit config overlays; };
in
  pkgs
