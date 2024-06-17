{ pkgs, lib, ... }: {
  programs.zsh.enable = true;

  environment = {
    shells = with pkgs; [ zsh ];
    loginShell = pkgs.zsh;
    systemPackages = with pkgs; [ gcc terminal-notifier ];
    systemPath = [ "/opt/homebrew/bin" "/opt/homebrew/sbin" ];
    pathsToLink = [ "/Applications" ];
  };

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  nix.settings.trusted-users = [ "diomedet" "root" ];
  nix.settings.builders-use-substitutes = true;

  nix.buildMachines = [{
    system = "x86_64-linux";
    sshUser = "root";
    sshKey = "/Users/diomedet/.ssh/id_ed25519";
    hostName = "scyther";
  }];
  nix.distributedBuilds = true;

  services.nix-daemon.enable = true;
  programs.nix-index.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    recursive
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraMono" "Meslo" ]; })
  ];

  # Keyboard
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Dock and Mission Control
  system.defaults.dock = {
    autohide = true;
    orientation = "left";
    expose-group-by-app = false;
    mru-spaces = false;
    tilesize = 128;
    # Disable all hot corners
    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
  };

  # Finder
  system.defaults.finder = { FXEnableExtensionChangeWarning = true; };

  # Trackpad
  system.defaults.trackpad = {
    Clicking = true;
    TrackpadRightClick = true;
  };

  system.defaults.NSGlobalDomain = {
    "com.apple.trackpad.scaling" = 3.0;
    AppleInterfaceStyleSwitchesAutomatically = true;
    AppleMeasurementUnits = "Centimeters";
    AppleMetricUnits = 1;
    AppleShowScrollBars = "Automatic";
    AppleTemperatureUnit = "Celsius";
    InitialKeyRepeat = 15;
    KeyRepeat = 2;
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    _HIHideMenuBar = false;
  };
}
