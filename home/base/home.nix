{myvars, ...}: {
  imports = [
    ./modules/core.nix
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
    inherit (myvars) username;

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
}
