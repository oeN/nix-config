{
  config,
  lib,
  ...
}: let
  cfg = config.my.desktop;
  my-user = config.my.user;
in {
  options.my.desktop = with lib; {
    enable = my.mkDisableOption "Enable the desktop manager";
  };

  config = lib.mkIf cfg.enable {
    ####################################################################
    #  NixOS's Configuration for Xorg Server
    ####################################################################

    services = {
      gvfs.enable = true; # Mount, trash, and other functionalities
      tumbler.enable = true; # Thumbnail support for images

      displayManager = {
        autoLogin = {
          enable = true;
          user = my-user.name;
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
