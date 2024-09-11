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

        ms-python.vscode-pylance
        editorconfig.editorconfig

        arrterian.nix-env-selector
        kamadorueda.alejandra
      ];

      userSettings = import ./user-settings.nix;
    };
  };
}
