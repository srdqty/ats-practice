{ pkgs ? import ../nix/nixpkgs-pinned {}
, ats2 ? pkgs.ats2
, stdenv ? pkgs.stdenv }:

stdenv.mkDerivation {
  name = "ats-hello-world";

  src = ./.;

  buildInputs = [ ats2 ];

  buildPhase = ''
    patscc -o hello hello.dats
  '';

  installPhase = ''
    install -D -m555 -T ./hello $out/bin/hello
  '';
}
