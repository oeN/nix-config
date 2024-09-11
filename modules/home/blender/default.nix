{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.blender;
in {
  options.my.home.blender = with lib; {
    enable = mkEnableOption "blender configuration";
  };

  config.home = lib.mkIf cfg.enable {
    packages = with pkgs; [
      blender
    ];
  };
}
