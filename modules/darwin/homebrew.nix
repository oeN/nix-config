{
    homebrew = {
        enable = true;
        onActivation.autoUpdate = true;
        global.brewfile = true;

        casks = [
            "firefox"
            "raycast"
        ];
    };
}