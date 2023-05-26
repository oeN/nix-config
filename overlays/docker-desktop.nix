{ stdenv, lib, fetchurl, undmg, lzfse, zlib, bzip2, unzip }:
stdenv.mkDerivation rec {
  name = "docker-desktop";
  pname = "Docker-Desktop";
  buildInputs = [ undmg lzfse zlib bzip2 unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r Docker.app "$out/Applications/Docker.app"
    '';

  src = fetchurl {
    name = "Docker.dmg";
    url = "https://desktop.docker.com/mac/main/arm64/Docker.dmg";
    sha256 = "S7DvTczu8c1uex9ZvGDnEmWVInXOFm50nfF+qKj0kqo=";
  };

  meta = with lib; {
    description = "Docker Desktop";
    homepage = "https://www.docker.com/products/docker-desktop/";
    platforms = platforms.darwin;
  };
}
