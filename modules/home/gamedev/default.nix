{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.gamedev;
in {
  options.my.home.gamedev = with lib; {
    enable = my.mkDisableOption "gamedev";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      love # Love2D game engine
    ];
  };
}
