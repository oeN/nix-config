{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.blender;
in {
  options.my.home.blender = with lib; {
    enable = my.mkDisableOption "blender configuration";
  };

  config.home =
    lib.mkIf cfg.enable
    (lib.mkIf pkgs.stdenv.isLinux {
      packages = with pkgs; [
        blender
      ];
    });
}
