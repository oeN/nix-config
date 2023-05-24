{
    homebrew = {
        enable = true;
        onActivation.autoUpdate = true;
        global.brewfile = true;

        homebrew.casks = [
            "firefox"
            "raycast"
        ];
    };
}