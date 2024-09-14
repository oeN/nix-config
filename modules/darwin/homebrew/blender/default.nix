{
  config,
  lib,
  ...
}: let
  cfg = config.my.homebrew.blender;
in {
  # option defined in the base module

  config.homebrew = lib.mkIf cfg.enable {
    casks = ["blender"];
  };
}
