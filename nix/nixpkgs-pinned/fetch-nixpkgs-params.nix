{ owner
, repo
, rev
, bootstrap-pkgs
}:

let
  url= import ./build-url.nix { inherit owner repo rev; };

  newNix = 0 <= builtins.compareVersions builtins.nixVersion "1.12";

  file = if newNix then
    builtins.fetchTarball { url = url; }
  else
    builtins.fetchurl url;

  json = bootstrap-pkgs.writeText "nixpkgs.json" ''
    { "url": "${url}"
    , "rev": "${rev}"
    , "owner": "${owner}"
    , "repo": "${repo}"
    }
  '';

  sha256calc = if newNix then
    "nix-hash --type sha256 --base32 ${file}"
  else
    "sha256sum -b ${file} | awk -n '{print $1}'";

  paramsDrv = bootstrap-pkgs.stdenv.mkDerivation {
    name = "nixpkgs-params-${rev}";

    src = ./.;

    buildInputs = [
      bootstrap-pkgs.jq
      bootstrap-pkgs.nix
      bootstrap-pkgs.coreutils
    ];

    builder = bootstrap-pkgs.writeScript "builder" ''
      source $stdenv/setup

      mkdir -p $out
      sha256=$(${sha256calc})
      jq .+="{\"sha256\":\"$sha256\"}" ${json} > $out/nixpkgs.json
    '';
  };
in
  builtins.fromJSON (builtins.readFile "${paramsDrv}/nixpkgs.json")
