{
  nixos-hardware,
  myvars,
  ...
}:
#############################################################
#
#  Ai - my main computer, with NixOS + I5-13600KF + RTX 4090 GPU, for gaming & daily use.
#
#############################################################
let
  hostName = "umbreon"; # Define your hostname.
in {
  imports = [
    nixos-hardware.nixosModules.lenovo-thinkpad-l14-intel
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking = {
    inherit hostName;

    # desktop need its cli for status bar
    networkmanager.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
