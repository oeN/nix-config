{pkgs, ...}: {
  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331

  programs.zsh.enable = true;
  environment = {
    shells = [pkgs.zsh];
    variables.EDITOR = "nvim";
    systemPath = ["/opt/homebrew/bin" "/opt/homebrew/sbin"];

    systemPackages = with pkgs; [
      neovim
      git

      gnugrep
      gnutar

      gcc
      just # use Justfile to simplify nix-darwin's commands
    ];
  };

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    global.brewfile = true;

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      # Xcode = 497799835;
    };

    taps = ["homebrew/services"];

    # `brew install`
    brews = [
      "wget" # download tool
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      "kdoctor"
      "terraform"
    ];

    # `brew install --cask`
    casks = [
      "firefox"
      "raycast"
      "1password"
      "1password-cli"
      "yubico-authenticator"
      "blender"
      "krita"
      "visual-studio-code"
      "contexts"
      "insomnia"
      "vlc"
      "telegram"
      "motrix"
      "the-unarchiver"
      "postman"
      "openemu"
      "keybase"
      "godot"
      "inkscape"
      "handbrake"
      "microsoft-teams"
      "autodesk-fusion"
    ];
  };
}
