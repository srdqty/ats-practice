{ stdenv
, fetchFromGitHub
, gmp
}:

stdenv.mkDerivation rec {
  name = "ats2-contrib-${version}";
  version = "0.3.10";

  src = fetchFromGitHub {
    owner = "ats-lang";
    repo = "ATS-Postiats-release";
    rev = "ecf3a0eeb15c343ed2ef97562d5436a0355e8e39";
    sha256 = "08p9j3y0ac5qj1ldycqb0xrs1i57pci0h5xkf2dbakgbxh9g9ifc";
  };

  buildInputs = [
    gmp
  ];

  configurePhase = "true";
  buildPhase = "true";

  installPhase = ''
    mkdir -p $out/ats2-contrib
    cp -r contrib $out/ats2-contrib
  '';

  setupHook = ./setup-hook.sh;
}
