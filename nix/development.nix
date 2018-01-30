let
  pkgs = import ./nixpkgs-pinned {};
in
  pkgs.stdenv.mkDerivation {
    name = "ats-practice";

    buildInputs = [
      pkgs.git
      pkgs.vim
      pkgs.ncurses # Needed by the bash-prompt.sh script
      pkgs.ats2
    ];

    shellHook = builtins.readFile ./bash-prompt.sh + ''
      source ${pkgs.git.out}/etc/bash_completion.d/git-prompt.sh
      source ${pkgs.git.out}/etc/bash_completion.d/git-completion.bash
    '';
  }
