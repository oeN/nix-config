{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.packages.blender;
in {
  options.my.packages.blender = with lib; {
    enable = my.mkDisableOption "blender configuration";
  };

  # FIXME: this shouldn't be declared here
  options.my.homebrew.blender = with lib; {
    enable = mkEnableOption "blender configuration";
  };

  config.my = lib.mkMerge [
    (lib.mkIf pkgs.stdenv.isLinux {
      home.blender.enable = cfg.enable;
    })

    (lib.mkIf pkgs.stdenv.isDarwin {
      homebrew.blender.enable = cfg.enable;
    })
  ];
}
