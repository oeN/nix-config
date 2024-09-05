{ my-user, lib, ... }:
{
  imports = lib.attrValues (lib.my.mapModules ./. (file: file));

  programs.home-manager.enable = true;

  # First sane reproducible version
  home.stateVersion = "24.05";

  # Who am I?
  home.username = my-user.name;

  # Start services automatically
  systemd.user.startServices = "sd-switch";
}
