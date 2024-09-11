{
  config,
  lib,
  ...
}: let
  cfg = config.my.homebrew.blender;
in {
  options.my.homebrew.blender = with lib; {
    enable = mkEnableOption "blender configuration";
  };

  config.homebrew = lib.mkIf cfg.enable {
    casks = ["blender"];
  };
}
