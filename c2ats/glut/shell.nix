let
  pkgs = import ../../nix/nixpkgs-pinned {};
  base = import ../../shell.nix;
in
  base.overrideAttrs (old: rec {
    buildInputs = old.buildInputs ++ [
      pkgs.freeglut
      pkgs.mesa
    ];
  })
