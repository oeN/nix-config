{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.atuin;
in {
  options.my.home.atuin = with lib; {
    enable = my.mkDisableOption "atuin configuration";

    # I want the full experience by default
    package = mkPackageOption pkgs "atuin" {};
  };

  config = lib.mkIf cfg.enable {
    programs.atuin = {
      enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;

      inherit (cfg) package;

      settings = {
        # The package is managed by Nix
        update_check = false;
        # I don't care for the fancy display
        style = "compact";
        # Get closer to fzf's fuzzy search
        search_mode = "skim";
        # Show long command lines at the bottom
        show_preview = true;
        # I like being able to edit my commands
        enter_accept = false;
      };
    };
  };
}
