{
    homebrew = {
        enable = true;
        onActivation.autoUpdate = true;
        global.brewfile = true;

        casks = [
            "firefox"
            "raycast"
            "1password"
            "1password-cli"
        ];
    };
}