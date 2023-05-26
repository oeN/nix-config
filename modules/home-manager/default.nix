{ config, pkgs, lib, ... }:

{
  home.stateVersion = "23.05";
  imports = [
    ./modules/git.nix
    ./modules/alacritty
    ./modules/neovim
    ./modules/packages.nix
  ];

  home.sessionVariables = {
    PAGER = "less";
    EDITOR = "nvim";
    CLICLOLOR = 1;
    GITHUB_TOKEN = "op://Personal/GitHub Personal Access Token/credential";
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


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "jump"
        "aws"
        "kubectl"
      ];
    };
    shellAliases = {
      nixswitch = "darwin-rebuild switch --flake ~/nix-config/.#";
      nixup = "pushd ~/nix-config; nix flake update; nixswitch; popd";
    };
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    terminal = "screen-256color";
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
