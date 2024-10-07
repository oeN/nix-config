{lib, ...}: {
  imports = lib.attrValues (lib.my.mapModules ./. (file: file));

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
      "actual"
      "raycast"
      "1password"
      "1password-cli"
      "yubico-authenticator"
      "krita"
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
