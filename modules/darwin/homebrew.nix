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
      "yubico-authenticator"
      "blender"
      "krita"
      "visual-studio-code"
      "contexts"
      "insomnia"
      "unity-hub"
      "vlc"
      "telegram"
      "motrix"
      "the-unarchiver"
      "postman"
      "openemu"
      "keybase"
    ];

    brews = [ "kdoctor" ];
  };
}
