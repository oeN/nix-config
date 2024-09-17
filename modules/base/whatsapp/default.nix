{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.packages.whatsapp;
in {
  options.my.packages.whatsapp = with lib; {
    enable = my.mkDisableOption "whatsapp configuration";
  };

  # FIXME: this shouldn't be declared here
  options.my.homebrew.whatsapp = with lib; {
    enable = mkEnableOption "whatsapp configuration";
  };

  config.my = lib.mkMerge [
    (lib.mkIf pkgs.stdenv.isDarwin {
      homebrew.whatsapp.enable = cfg.enable;
    })
  ];
}
