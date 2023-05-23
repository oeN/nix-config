{
    homebrew.enable = true;
    homebrew.onActivation.autoUpdate = true;
    homebrew.onActivation.cleanup = "zap";
    homebrew.global.brewfile = true;

    homebrew.taps = [
        "homebrew/cask"
    ];

    homebrew.casks = [
        # "firefox"
    ];
}