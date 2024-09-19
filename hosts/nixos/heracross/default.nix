{
  modulesPath,
  lib,
  pkgs,
  ...
}: let
  keys = import ../../../keys;
in {
  imports =
    lib.attrValues (lib.my.mapModules ./. (file: file))
    ++ [
      # ../common/hardware-overrides.nix
    ];

  time.timeZone = "Europe/Rome";

  system.stateVersion = "23.05";
}
