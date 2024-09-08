# Umbreon specific settings
{inputs, ...}: let
  nixos-hardware = inputs.nixos-hardware;
in {
  # TODO: fix audio and wezterm that shows only rectangles

  imports = [
    nixos-hardware.nixosModules.lenovo-thinkpad-l14-intel
    ./boot.nix
    ./hardware.nix
    ./networking.nix
    ./home.nix
    #   ./sound.nix
    ./options.nix
  ];

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  system.stateVersion = "24.05"; # Did you read the comment?
}
