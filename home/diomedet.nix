{ config, pkgs, lib, ... }:

{
  home.stateVersion = "23.05";
  imports = [
    ./modules/git.nix
  ];

  home.packages = with pkgs; [
    # Some basics
    coreutils
    curl
    wget

    # Dev stuff
    jq
  ];

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  programs.alacritty = {
    enable = true;
    settings.font.normal.family = "JetBrainsMono Nerd Font";
    settings.font.size = 16;
  };

  programs.bat.enable = true;
  programs.bat.config.theme = "OneDark";

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
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        "jump"
        "aws"
        "kubectl"
        "nix-shell"
      ];
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

  programs.vscode.enable = true;
}