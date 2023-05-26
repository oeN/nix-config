self: super: {
  # Firefox = super.callPackage ./firefox.nix {};
  docker-desktop = super.callPackage ./docker-desktop.nix {};
}
