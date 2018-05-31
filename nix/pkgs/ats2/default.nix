{ stdenv
, fetchurl
, gmp
, ats2-contrib
}:

stdenv.mkDerivation rec {
  name = "ats-${version}";
  version = "0.3.10";

  src = fetchurl {
    url = "mirror://sourceforge/ats2-lang/ATS2-Postiats-${version}.tgz";
    sha256 = "0mjp8a4zq2gh2w1hifg2lj6lmhriicqcdd2yyl3ah5kghg3w2y05";
  };

  buildInputs = [
    gmp
  ];

  setupHook = ./setup-hook.sh;

  postInstall = ''
    rm -rf $out/lib/ats2-postiats-0.3.10/contrib
    cp -r ${ats2-contrib}/ats2-contrib/contrib $out/lib/ats2-postiats-0.3.10/contrib
  '';
}
