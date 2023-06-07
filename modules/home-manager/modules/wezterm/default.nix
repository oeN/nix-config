{
  programs.wezterm.enable = true;
  xdg.configFile."wezterm/wezterm.lua".source = ./config/wezterm.lua;
  xdg.configFile."wezterm/keys.lua".source = ./config/keys.lua;
  xdg.configFile."wezterm/theme.lua".source = ./config/theme.lua;
}
