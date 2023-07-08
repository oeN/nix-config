{ config, pkgs, lib, ... }:

{
  home.stateVersion = "23.05";
  imports = [
    ./modules/git.nix
    ./modules/alacritty
    ./modules/wezterm
    ./modules/neovim
    ./modules/zsh
    ./modules/starship
    # ./modules/tmux
    ./modules/packages.nix
  ];

  nixpkgs.overlays = [
    (pkgsFinal: pkgsPrev: {
      inherit (pkgsFinal.cross.x86_64-darwin) jellyfin-media-player;
    })
  ];

  home.sessionVariables = {
    PAGER = "less";
    EDITOR = "nvim";
    CLICLOLOR = 1;
    GITHUB_TOKEN = "op://Personal/GitHub Personal Access Token/token";
  };

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
}
