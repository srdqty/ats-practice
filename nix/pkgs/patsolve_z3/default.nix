{ stdenv
, fetchFromGitHub
, ats2
, pkgconfig
, json_c
, boehmgc
, z3
}:

stdenv.mkDerivation rec {
  name = "patsolve_z3";

  src = fetchFromGitHub {
    owner = "ats-lang";
    repo = "ATS-Postiats-release";
    rev = "ecf3a0eeb15c343ed2ef97562d5436a0355e8e39";
    sha256 = "08p9j3y0ac5qj1ldycqb0xrs1i57pci0h5xkf2dbakgbxh9g9ifc";
  };

  buildInputs = [
    ats2
    pkgconfig
    json_c
    boehmgc
    z3
  ];

  buildPhase = ''
    make -C contrib/ATS-extsolve-z3
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv -f contrib/ATS-extsolve-z3/bin/patsolve_z3 $out/bin/
  '';
}
