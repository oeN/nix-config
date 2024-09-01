{
  username,
  lib,
  ...
}: {
  imports = [
    ./modules/git.nix
    ./modules/alacritty
    ./modules/wezterm
    # ./modules/neovim
    ./modules/zsh
    ./modules/starship
    # ./modules/tmux
    ./modules/packages.nix
  ];

  home = {
    username = username;
    # FIXME: why do I need mkForce here?
    homeDirectory = lib.mkForce "/Users/${username}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.05";
    sessionVariables = {
      PAGER = "less";
      EDITOR = "nvim";
      CLICLOLOR = 1;
      GITHUB_TOKEN = "op://Personal/GitHub Personal Access Token/token";
    };
  };

  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    (pkgsFinal: pkgsPrev: {
      inherit (pkgsFinal.cross.x86_64-darwin) jellyfin-media-player;
    })
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

  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
}
