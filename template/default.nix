let
  pkgs = import ../nix/nixpkgs-pinned {};
in

{ mkDerivation ? pkgs.stdenv.mkDerivation
, ats2 ? pkgs.ats2
}:

mkDerivation {
  name = "ats-template";

  src = ./.;

  makeFlags = ["PREFIX=$(out)"];

  buildInputs = [
    ats2
  ];
}
