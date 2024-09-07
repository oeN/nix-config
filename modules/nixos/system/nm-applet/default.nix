{
  config,
  lib,
  ...
}: let
  cfg = config.my.system.nm-applet;
in {
  options.my.system.nm-applet = with lib; {
    enable = mkEnableOption "network-manager-applet configuration";
  };

  config.programs.nm-applet = lib.mkIf cfg.enable {
    enable = true;
  };
}
