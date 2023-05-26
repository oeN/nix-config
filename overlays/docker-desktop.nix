{ stdenv, lib, fetchurl, undmg, unzip }:
stdenv.mkDerivation rec {

  pname = "Docker-Desktop";
  buildInputs = [ undmg unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r Docker.app "$out/Applications/Docker.app"
    '';

  src = fetchurl {
    name = "Docker.dmg";
    url = "https://desktop.docker.com/mac/main/arm64/${name}";
    sha256 = "VU9qUMmxSjMJh2KYiS8+1+xT0GK7fmWUQfRKeKwRZ28=";
  };

  meta = with lib; {
    description = "Docker Desktop";
    homepage = "https://www.docker.com/products/docker-desktop/";
    platforms = platforms.darwin;
  };
}
