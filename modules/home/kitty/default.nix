{
  config,
  lib,
  ...
}: let
  cfg = config.my.home.kitty;
in {
  options.my.home.kitty = with lib; {
    enable = my.mkDisableOption "kitty configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty.enable = true;
  };
}
