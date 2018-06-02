let
  pkgs = import ./nix/nixpkgs-pinned {};
  ats2-contrib = pkgs.callPackage ./nix/pkgs/ats2-contrib {};
  ats2 = pkgs.callPackage ./nix/pkgs/ats2 { inherit ats2-contrib; };
  patsolve_z3 = pkgs.callPackage ./nix/pkgs/patsolve_z3 { inherit ats2; };
in
  pkgs.stdenv.mkDerivation {
    name = "ats-practice";

    buildInputs = [
      pkgs.git
      pkgs.vim
      pkgs.ncurses # Needed by the bash-prompt.sh script
      pkgs.z3
      ats2
      patsolve_z3
      pkgs.haskellPackages.c2ats
    ];

    shellHook = builtins.readFile ./nix/bash-prompt.sh + ''
      source ${pkgs.git.out}/etc/bash_completion.d/git-prompt.sh
      source ${pkgs.git.out}/etc/bash_completion.d/git-completion.bash
    '';
  }
