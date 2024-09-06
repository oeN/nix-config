{
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f6a06cc5-2a62-4952-9b15-ff762356a191";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9117-87B2";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/f4a3cd66-8094-4ff0-bab6-2c0486e5f2c0";}
  ];
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  my.hardware = {
    firmware = {
      cpuFlavor = "intel";
    };

    graphics = {
      enable = true;

      gpuFlavor = "intel";
    };
  };

  # hardware = {
  #   trackpoint = {
  #     enable = true;

  #     emulateWheel = true; # Holding middle buttons allows scrolling

  #     device = "TPPS/2 Elan TrackPoint"; # Use the correct device name
  #   };
  # };
}
