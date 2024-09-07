{
  config,
  lib,
  ...
}: let
  cfg = config.my.home.alacritty;
in {
  options.my.home.alacritty = with lib; {
    enable = mkEnableOption "alacritty configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty.enable = true;
    xdg.configFile."alacritty/alacritty.yml".source = ./alacritty.dark.yml;
  };
}
