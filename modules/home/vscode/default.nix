{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.vscode;
in {
  options.my.home.vscode = with lib; {
    enable = my.mkDisableOption "vscode configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;

      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        bbenoist.nix
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
      ];

      userSettings = {
        # color scheme
        "workbench.colorTheme" = "Catppuccin Macchiato";
        "workbench.preferredDarkColorTheme" = "Catppuccin Macchiato";
        "workbench.preferredLightColorTheme" = "Catppuccin Latte";
        "window.autoDetectColorScheme" = true;
        # icons
        "workbench.iconTheme" = "catppuccin-macchiato";
        "catppuccin-icons.hidesExplorerArrows" = true;
        # vim
        "vim.useCtrlKeys" = false;
      };
    };
  };
}
