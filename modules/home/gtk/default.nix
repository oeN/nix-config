{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.my.home.gtk;
in {
  options.my.home.gtk = with lib; {
    enable = my.mkDisableOption "gtk configuration";
  };

  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;

      theme = {
        package = pkgs.gnome-themes-extra;
        name = "Adwaita";
      };

      iconTheme = {
        package = pkgs.gnome-themes-extra;
        name = "Adwaita";
      };
    };

    home.pointerCursor = {
      package = pkgs.vimix-cursors;
      name = "Vimix-cursors";

      gtk.enable = true;
    };
  };
}
