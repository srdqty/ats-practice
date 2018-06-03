{ stdenv
, fetchFromGitHub
, gmp
}:

stdenv.mkDerivation rec {
  name = "ats-${version}";
  version = "0.3.11";

  src = fetchFromGitHub {
    owner = "srdqty";
    repo = "ats2-lang-mirror";
    rev = "c4df96a39242ad59ce6ebfd814c02b900dbee062";
    sha256 = "049wl3jkfw3x0sk817zanh8ak6416lkrc1hgnp0y5nm4qwyd3jf2";
  };

  PATSHOME="${src}";

  buildInputs = [
    gmp
  ];

  setupHook = ./setup-hook.sh;
}
