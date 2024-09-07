{...}: {
  home.shellAliases = {
    nixswitch = "sudo nixos-rebuild switch --flake ~/nix-config/.#";
  };
}
