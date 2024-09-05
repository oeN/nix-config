{
  pkgs,
  config,
  lib,
  my,
  ...
}:
with lib; {
  imports = [
    ./base
    ../base.nix

    ./desktop
  ];

  config = {
    ####################################################################
    #  NixOS's Configuration for Xorg Server
    ####################################################################

    services = {
      gvfs.enable = true; # Mount, trash, and other functionalities
      tumbler.enable = true; # Thumbnail support for images

      displayManager = {
        autoLogin = {
          enable = true;
          user = my.vars.username;
        };
      };

      xserver = {
        enable = true;
        displayManager = {
          gdm.enable = true;
        };

        desktopManager.gnome.enable = true;

        # Configure keymap in X11
        xkb.layout = "us";
      };
    };
  };
}
