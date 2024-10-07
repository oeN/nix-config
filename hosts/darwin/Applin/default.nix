# Applin specific settings
_: let
  hostname = "Applin";
in {
  imports = [
    ./options.nix
  ];

  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  system.stateVersion = 5;
}
