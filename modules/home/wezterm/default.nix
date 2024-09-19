{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.wezterm;
in {
  options.my.home.wezterm = with lib; {
    enable = my.mkDisableOption "wezterm configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.wezterm.enable = true;
    xdg.configFile."wezterm/wezterm.lua".source = ./config/wezterm.lua;
    xdg.configFile."wezterm/keys.lua".source = ./config/keys.lua;
    xdg.configFile."wezterm/theme.lua".source = ./config/theme.lua;
    xdg.configFile."wezterm/tab_bar.lua".source = ./config/tab_bar.lua;
    xdg.configFile."wezterm/multiplexing.lua".source = ./config/multiplexing.lua;
  };
}
