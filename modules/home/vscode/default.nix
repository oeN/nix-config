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

      # for now is more convenient to use the user settings and extensions
      # directly from vscode and sync it through github gist

      # extensions = with pkgs.vscode-extensions; [
      #   vscodevim.vim
      #   bbenoist.nix
      #   catppuccin.catppuccin-vsc
      #   catppuccin.catppuccin-vsc-icons

      #   ms-python.vscode-pylance
      #   editorconfig.editorconfig

      #   arrterian.nix-env-selector
      #   kamadorueda.alejandra

      #   vscode-icons-team.vscode-icons
      # ];

      # userSettings = import ./user-settings.nix;
    };
  };
}
